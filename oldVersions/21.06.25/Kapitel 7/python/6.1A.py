import numpy as np
import matplotlib.pyplot as plt
import io
import base64
from flask import Flask, render_template_string, request

app = Flask(__name__)

HTML_TEMPLATE = """
<!DOCTYPE html>
<html lang="de">
<head>
    <meta charset="UTF-8">
    <title>FZRK-Dichtevisualisierung</title>
</head>
<body>
    <h1>FZRK – Semantische Dichtefunktion</h1>
    <form method="post">
        <label>σ<sub>0</sub> (Startdichte): <input type="number" step="0.1" name="sigma0" value="1.0"></label><br>
        <label>Δσ (Gradient): <input type="number" step="0.1" name="delta_sigma" value="0.5"></label><br>
        <label>Instabilität (Rauschen): <input type="number" step="0.1" name="noise" value="0.2"></label><br>
        <input type="submit" value="Aktualisieren">
    </form>
    {% if plot_url %}
        <h2>Visualisierung</h2>
        <img src="{{ plot_url }}" alt="Dichteverlauf">
    {% endif %}
</body>
</html>
"""

def generate_plot(sigma0, delta_sigma, noise):
    t = np.linspace(0, 10, 500)
    sigma = sigma0 + delta_sigma * t + np.random.normal(0, noise, t.shape)

    fig, ax = plt.subplots()
    ax.plot(t, sigma, label=r"$\sigma(t)$", color="darkblue")
    ax.set_xlabel("Zeit t")
    ax.set_ylabel("Semantische Dichte σ")
    ax.set_title("Dichteverlauf im intentionalen Raum")
    ax.legend()
    ax.grid(True)

    buf = io.BytesIO()
    plt.savefig(buf, format='png')
    plt.close(fig)
    buf.seek(0)
    img_base64 = base64.b64encode(buf.read()).decode('utf-8')
    return f"data:image/png;base64,{img_base64}"

@app.route('/', methods=['GET', 'POST'])
def index():
    plot_url = None
    if request.method == 'POST':
        sigma0 = float(request.form.get('sigma0', 1.0))
        delta_sigma = float(request.form.get('delta_sigma', 0.5))
        noise = float(request.form.get('noise', 0.2))
        plot_url = generate_plot(sigma0, delta_sigma, noise)
    return render_template_string(HTML_TEMPLATE, plot_url=plot_url)

if __name__ == '__main__':
    app.run(debug=True)
