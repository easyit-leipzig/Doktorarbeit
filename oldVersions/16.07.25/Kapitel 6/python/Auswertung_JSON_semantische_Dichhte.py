# plot_high_O_cells.py
import json
import numpy as np

# --- hier deine JSON-Ausgabe einfügen (kopieren) ---
data_json = r'''{
  "x_labels": ["2..4","4..6","6..8","8..10","10..12","12..14","14..16","16..18","18..20","20..22","22..24"],
  "y_labels": ["0..1.8","1.8..3.6","3.6..5.4","5.4..7.2","7.2..9"],
  "h": [
    [2.375,1.125,1.4375,null,null],
    [null,null,1.4375,null,3],
    [null,null,1.9375,1.9375,2.875],
    [null,null,2.8106617647058822,1.5625,null],
    [null,null,1.53125,1.46875,2.9797794117647056],
    [null,0.9411764705882353,null,1.296875,null],
    [null,null,null,1.859375,null],
    [0,2.4080882352941178,3.235294117647059,null,1.7083333333333333],
    [null,null,null,null,1.9816176470588234],
    [null,1.4926470588235294,null,null,1.5625],
    [null,1.9375,null,1.8125,2]
  ]
}'''

# load JSON (allow null)
data = json.loads(data_json)
x_labels = data["x_labels"]
y_labels = data["y_labels"]
h_raw = data["h"]

# convert to numpy array with nan
h = np.array(h_raw, dtype=float)   # shape (nx, ny) where nx=len(x_labels), ny=len(y_labels)
# For gradient we want shape (ny, nx) with x across columns, y across rows.
Z = h.T  # now shape (ny, nx)

# Replace nan with nearest-neighbor interpolation or 0 for gradient calc (here: use nan->np.nan)
# For gradient robust: fill nan with local mean using simple approach
Zf = Z.copy()
nan_mask = np.isnan(Zf)
# simple fill: replace nan with column (x) mean ignoring nans, then row mean fallback
col_mean = np.nanmean(Zf, axis=0)
row_mean = np.nanmean(Zf, axis=1)
for i in range(Zf.shape[0]):
    for j in range(Zf.shape[1]):
        if np.isnan(Zf[i,j]):
            if not np.isnan(col_mean[j]):
                Zf[i,j] = col_mean[j]
            elif not np.isnan(row_mean[i]):
                Zf[i,j] = row_mean[i]
            else:
                Zf[i,j] = 0.0

# gradient (dz/dx, dz/dy) approximated on index grid
# assume uniform spacing between bins -> use np.gradient on indices
gy, gx = np.gradient(Zf)   # gy: dZ/dy, gx: dZ/dx
grad = np.sqrt(gx**2 + gy**2)
maxg = np.nanmax(grad)
if maxg == 0:
    O = np.ones_like(grad)
else:
    O = 1.0 - (grad / maxg)

# threshold for "sehr hoch"
threshold = 0.8

high_indices = np.argwhere(O >= threshold)  # list of (row=y_idx, col=x_idx)

print("High-O Zellen (O >= {:.2f}):".format(threshold))
results = []
for (iy, ix) in high_indices:
    x_label = x_labels[ix]
    y_label = y_labels[iy]
    hval = Z[iy, ix]
    count_note = "missing" if np.isnan(hval) else f"{hval:.3f}"
    results.append({'x_idx': ix, 'y_idx': iy, 'x_label': x_label, 'y_label': y_label, 'h': hval, 'O': float(O[iy,ix])})
    print(f" x={x_label}  y={y_label}  h={count_note}  O={O[iy,ix]:.3f}")

# produce SQL WHERE ranges for numeric labels like '2..4'
def parse_interval(s):
    if '..' in s:
        a,b = s.split('..')
        try:
            return float(a), float(b)
        except:
            return None
    return None

sql_clauses = []
for r in results:
    xi = parse_interval(r['x_label'])
    yi = parse_interval(r['y_label'])
    # assume x field is numeric (ue_zuweisung_teilnehmer_id numeric) and y is numeric (gruppe_id)
    if xi and yi:
        sql_clauses.append({
            'x_range': xi,
            'y_range': yi,
            'sql': f"(ue_zuweisung_teilnehmer_id >= {xi[0]} AND ue_zuweisung_teilnehmer_id < {xi[1]} AND gruppe_id >= {yi[0]} AND gruppe_id < {yi[1]})"
        })
    else:
        sql_clauses.append({'x_label': r['x_label'], 'y_label': r['y_label'], 'sql': None})

print("\nVorschlag: SQL WHERE-Klauseln für die High-O-Zellen (zum Abfragen der val_*-Averages):")
for s in sql_clauses:
    print(s.get('sql') or f"Categorical cell: x={s.get('x_label')} y={s.get('y_label')}")
