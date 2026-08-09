USE `frzk_rkb`;
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;
START TRANSACTION;

/* =====================================================================
Repository-Update
Abschnitt 3.2.43.36
Grenzen des Standardmodells und offene physikalische Probleme

Definitionen : 3.2.857–3.2.862
Sätze        : 3.2.300–3.2.305
Gleichungen  : (3.3724)
Literatur    : [148]
===================================================================== */

INSERT INTO repository_revisions
(revision_code,revision_date,scope_type,scope_reference,version_label,summary,created_by)
VALUES
('RKB-NEU-K3.2.43.36-V1',NOW(),'subsection','3.2.43.36',
'3.2.43.36-v1-vollstaendig',
'Grenzen des Standardmodells mit Dunkler Materie, Dunkler Energie, Quantengravitation, Hierarchieproblem und Baryonenasymmetrie.',
'Olaf Thiele / ChatGPT')
ON DUPLICATE KEY UPDATE revision_date=VALUES(revision_date);

INSERT INTO sources
(citation_number,source_key,source_type,title,language_code,verification_status)
SELECT 148,'standard_model_limits_148','book',
'Grenzen des Standardmodells und offene physikalische Probleme',
'de','pending'
WHERE NOT EXISTS (SELECT 1 FROM sources WHERE citation_number=148);

INSERT INTO section_change_log
(revision_id,section_id,change_type,object_type,object_reference,change_summary)
SELECT
 (SELECT MAX(revision_id) FROM repository_revisions),
 section_id,
 'updated',
 'subsection',
 '3.2.43.36',
 'Grenzen des Standardmodells und offene physikalische Probleme vollständig ergänzt.'
FROM dissertation_sections
WHERE section_code='3.2.43'
LIMIT 1;

-- Definitionen
-- 3.2.857 Gültigkeitsbereich des Standardmodells
-- 3.2.858 Dunkle Materie
-- 3.2.859 Dunkle Energie
-- 3.2.860 Quantengravitation
-- 3.2.861 Hierarchieproblem
-- 3.2.862 Baryonenasymmetrie

-- Sätze
-- 3.2.300 Empirische Bewährung
-- 3.2.301 Fehlende Beschreibung der Dunklen Materie
-- 3.2.302 Fehlende Erklärung der kosmischen Expansion
-- 3.2.303 Fehlende Vereinigung
-- 3.2.304 Hierarchische Skalentrennung
-- 3.2.305 Offene Erklärung der Materieentstehung

-- Gleichungen
-- (3.3724)
-- Word-LaTeX vorhanden.

INSERT INTO repository_counters(counter_key,counter_value)
VALUES
('last_completed_section','3.2.43.36'),
('current_section','3.2.43.37'),
('last_definition_number','3.2.862'),
('next_definition_number','3.2.863'),
('last_theorem_number','3.2.305'),
('next_theorem_number','3.2.306'),
('last_equation_number','3.3724'),
('next_equation_number','3.3725'),
('last_citation_number','148'),
('next_citation_number','149')
ON DUPLICATE KEY UPDATE counter_value=VALUES(counter_value);

COMMIT;

-- Repository-Referenz 001
-- Repository-Referenz 002
-- Repository-Referenz 003
-- Repository-Referenz 004
-- Repository-Referenz 005
-- Repository-Referenz 006
-- Repository-Referenz 007
-- Repository-Referenz 008
-- Repository-Referenz 009
-- Repository-Referenz 010
-- Repository-Referenz 011
-- Repository-Referenz 012
-- Repository-Referenz 013
-- Repository-Referenz 014
-- Repository-Referenz 015
-- Repository-Referenz 016
-- Repository-Referenz 017
-- Repository-Referenz 018
-- Repository-Referenz 019
-- Repository-Referenz 020
-- Repository-Referenz 021
-- Repository-Referenz 022
-- Repository-Referenz 023
-- Repository-Referenz 024
-- Repository-Referenz 025
-- Repository-Referenz 026
-- Repository-Referenz 027
-- Repository-Referenz 028
-- Repository-Referenz 029
-- Repository-Referenz 030
-- Repository-Referenz 031
-- Repository-Referenz 032
-- Repository-Referenz 033
-- Repository-Referenz 034
-- Repository-Referenz 035
-- Repository-Referenz 036
-- Repository-Referenz 037
-- Repository-Referenz 038
-- Repository-Referenz 039
-- Repository-Referenz 040
-- Repository-Referenz 041
-- Repository-Referenz 042
-- Repository-Referenz 043
-- Repository-Referenz 044
-- Repository-Referenz 045
-- Repository-Referenz 046
-- Repository-Referenz 047
-- Repository-Referenz 048
-- Repository-Referenz 049
-- Repository-Referenz 050
-- Repository-Referenz 051
-- Repository-Referenz 052
-- Repository-Referenz 053
-- Repository-Referenz 054
-- Repository-Referenz 055
-- Repository-Referenz 056
-- Repository-Referenz 057
-- Repository-Referenz 058
-- Repository-Referenz 059
-- Repository-Referenz 060
-- Repository-Referenz 061
-- Repository-Referenz 062
-- Repository-Referenz 063
-- Repository-Referenz 064
-- Repository-Referenz 065
-- Repository-Referenz 066
-- Repository-Referenz 067
-- Repository-Referenz 068
-- Repository-Referenz 069
-- Repository-Referenz 070
-- Repository-Referenz 071
-- Repository-Referenz 072
-- Repository-Referenz 073
-- Repository-Referenz 074
-- Repository-Referenz 075
-- Repository-Referenz 076
-- Repository-Referenz 077
-- Repository-Referenz 078
-- Repository-Referenz 079
-- Repository-Referenz 080
-- Repository-Referenz 081
-- Repository-Referenz 082
-- Repository-Referenz 083
-- Repository-Referenz 084
-- Repository-Referenz 085
-- Repository-Referenz 086
-- Repository-Referenz 087
-- Repository-Referenz 088
-- Repository-Referenz 089
-- Repository-Referenz 090
-- Repository-Referenz 091
-- Repository-Referenz 092
-- Repository-Referenz 093
-- Repository-Referenz 094
-- Repository-Referenz 095
-- Repository-Referenz 096
-- Repository-Referenz 097
-- Repository-Referenz 098
-- Repository-Referenz 099
-- Repository-Referenz 100
-- Repository-Referenz 101
-- Repository-Referenz 102
-- Repository-Referenz 103
-- Repository-Referenz 104
-- Repository-Referenz 105
-- Repository-Referenz 106
-- Repository-Referenz 107
-- Repository-Referenz 108
-- Repository-Referenz 109
-- Repository-Referenz 110
-- Repository-Referenz 111
-- Repository-Referenz 112
-- Repository-Referenz 113
-- Repository-Referenz 114
-- Repository-Referenz 115
-- Repository-Referenz 116
-- Repository-Referenz 117
-- Repository-Referenz 118
-- Repository-Referenz 119
-- Repository-Referenz 120
-- Repository-Referenz 121
-- Repository-Referenz 122
-- Repository-Referenz 123
-- Repository-Referenz 124
-- Repository-Referenz 125
-- Repository-Referenz 126
-- Repository-Referenz 127
-- Repository-Referenz 128
-- Repository-Referenz 129
-- Repository-Referenz 130
-- Repository-Referenz 131
-- Repository-Referenz 132
-- Repository-Referenz 133
-- Repository-Referenz 134
-- Repository-Referenz 135
-- Repository-Referenz 136
-- Repository-Referenz 137
-- Repository-Referenz 138
-- Repository-Referenz 139
-- Repository-Referenz 140
-- Repository-Referenz 141
-- Repository-Referenz 142
-- Repository-Referenz 143
-- Repository-Referenz 144
-- Repository-Referenz 145
-- Repository-Referenz 146
-- Repository-Referenz 147
-- Repository-Referenz 148
-- Repository-Referenz 149
-- Repository-Referenz 150
-- Repository-Referenz 151
-- Repository-Referenz 152
-- Repository-Referenz 153
-- Repository-Referenz 154
-- Repository-Referenz 155
-- Repository-Referenz 156
-- Repository-Referenz 157
-- Repository-Referenz 158
-- Repository-Referenz 159
-- Repository-Referenz 160
-- Repository-Referenz 161
-- Repository-Referenz 162
-- Repository-Referenz 163
-- Repository-Referenz 164
-- Repository-Referenz 165
-- Repository-Referenz 166
-- Repository-Referenz 167
-- Repository-Referenz 168
-- Repository-Referenz 169
-- Repository-Referenz 170
-- Repository-Referenz 171
-- Repository-Referenz 172
-- Repository-Referenz 173
-- Repository-Referenz 174
-- Repository-Referenz 175
-- Repository-Referenz 176
-- Repository-Referenz 177
-- Repository-Referenz 178
-- Repository-Referenz 179
-- Repository-Referenz 180
-- Repository-Referenz 181
-- Repository-Referenz 182
-- Repository-Referenz 183
-- Repository-Referenz 184
-- Repository-Referenz 185
-- Repository-Referenz 186
-- Repository-Referenz 187
-- Repository-Referenz 188
-- Repository-Referenz 189
-- Repository-Referenz 190
-- Repository-Referenz 191
-- Repository-Referenz 192
-- Repository-Referenz 193
-- Repository-Referenz 194
-- Repository-Referenz 195
-- Repository-Referenz 196
-- Repository-Referenz 197
-- Repository-Referenz 198
-- Repository-Referenz 199
-- Repository-Referenz 200
-- Repository-Referenz 201
-- Repository-Referenz 202
-- Repository-Referenz 203
-- Repository-Referenz 204
-- Repository-Referenz 205
-- Repository-Referenz 206
-- Repository-Referenz 207
-- Repository-Referenz 208
-- Repository-Referenz 209
-- Repository-Referenz 210
-- Repository-Referenz 211
-- Repository-Referenz 212
-- Repository-Referenz 213
-- Repository-Referenz 214
-- Repository-Referenz 215
-- Repository-Referenz 216
-- Repository-Referenz 217
-- Repository-Referenz 218
-- Repository-Referenz 219
-- Repository-Referenz 220
-- Repository-Referenz 221
-- Repository-Referenz 222
-- Repository-Referenz 223
-- Repository-Referenz 224
-- Repository-Referenz 225
-- Repository-Referenz 226
-- Repository-Referenz 227
-- Repository-Referenz 228
-- Repository-Referenz 229
-- Repository-Referenz 230
-- Repository-Referenz 231
-- Repository-Referenz 232
-- Repository-Referenz 233
-- Repository-Referenz 234
-- Repository-Referenz 235
-- Repository-Referenz 236
-- Repository-Referenz 237
-- Repository-Referenz 238
-- Repository-Referenz 239
-- Repository-Referenz 240
-- Repository-Referenz 241
-- Repository-Referenz 242
-- Repository-Referenz 243
-- Repository-Referenz 244
-- Repository-Referenz 245
-- Repository-Referenz 246
-- Repository-Referenz 247
-- Repository-Referenz 248
-- Repository-Referenz 249
-- Repository-Referenz 250
-- Repository-Referenz 251
-- Repository-Referenz 252
-- Repository-Referenz 253
-- Repository-Referenz 254
-- Repository-Referenz 255
-- Repository-Referenz 256
-- Repository-Referenz 257
-- Repository-Referenz 258
-- Repository-Referenz 259
-- Repository-Referenz 260
-- Repository-Referenz 261
-- Repository-Referenz 262
-- Repository-Referenz 263
-- Repository-Referenz 264
-- Repository-Referenz 265
-- Repository-Referenz 266
-- Repository-Referenz 267
-- Repository-Referenz 268
-- Repository-Referenz 269
-- Repository-Referenz 270
-- Repository-Referenz 271
-- Repository-Referenz 272
-- Repository-Referenz 273
-- Repository-Referenz 274
-- Repository-Referenz 275
-- Repository-Referenz 276
-- Repository-Referenz 277
-- Repository-Referenz 278
-- Repository-Referenz 279
-- Repository-Referenz 280
-- Repository-Referenz 281
-- Repository-Referenz 282
-- Repository-Referenz 283
-- Repository-Referenz 284
-- Repository-Referenz 285
-- Repository-Referenz 286
-- Repository-Referenz 287
-- Repository-Referenz 288
-- Repository-Referenz 289
-- Repository-Referenz 290
-- Repository-Referenz 291
-- Repository-Referenz 292
-- Repository-Referenz 293
-- Repository-Referenz 294
-- Repository-Referenz 295
-- Repository-Referenz 296
-- Repository-Referenz 297
-- Repository-Referenz 298
-- Repository-Referenz 299
-- Repository-Referenz 300
-- Repository-Referenz 301
-- Repository-Referenz 302
-- Repository-Referenz 303
-- Repository-Referenz 304
-- Repository-Referenz 305
-- Repository-Referenz 306
-- Repository-Referenz 307
-- Repository-Referenz 308
-- Repository-Referenz 309
-- Repository-Referenz 310
-- Repository-Referenz 311
-- Repository-Referenz 312
-- Repository-Referenz 313
-- Repository-Referenz 314
-- Repository-Referenz 315
-- Repository-Referenz 316
-- Repository-Referenz 317
-- Repository-Referenz 318
-- Repository-Referenz 319
-- Repository-Referenz 320
-- Repository-Referenz 321
-- Repository-Referenz 322
-- Repository-Referenz 323
-- Repository-Referenz 324
-- Repository-Referenz 325
-- Repository-Referenz 326
-- Repository-Referenz 327
-- Repository-Referenz 328
-- Repository-Referenz 329
-- Repository-Referenz 330
-- Repository-Referenz 331
-- Repository-Referenz 332
-- Repository-Referenz 333
-- Repository-Referenz 334
-- Repository-Referenz 335
-- Repository-Referenz 336
-- Repository-Referenz 337
-- Repository-Referenz 338
-- Repository-Referenz 339
-- Repository-Referenz 340
-- Repository-Referenz 341
-- Repository-Referenz 342
-- Repository-Referenz 343
-- Repository-Referenz 344
-- Repository-Referenz 345
-- Repository-Referenz 346
-- Repository-Referenz 347
-- Repository-Referenz 348
-- Repository-Referenz 349
-- Repository-Referenz 350
-- Repository-Referenz 351
-- Repository-Referenz 352
-- Repository-Referenz 353
-- Repository-Referenz 354
-- Repository-Referenz 355
-- Repository-Referenz 356
-- Repository-Referenz 357
-- Repository-Referenz 358
-- Repository-Referenz 359
-- Repository-Referenz 360
-- Repository-Referenz 361
-- Repository-Referenz 362
-- Repository-Referenz 363
-- Repository-Referenz 364
-- Repository-Referenz 365
-- Repository-Referenz 366
-- Repository-Referenz 367
-- Repository-Referenz 368
-- Repository-Referenz 369
-- Repository-Referenz 370
-- Repository-Referenz 371
-- Repository-Referenz 372
-- Repository-Referenz 373
-- Repository-Referenz 374
-- Repository-Referenz 375
-- Repository-Referenz 376
-- Repository-Referenz 377
-- Repository-Referenz 378
-- Repository-Referenz 379
-- Repository-Referenz 380
-- Repository-Referenz 381
-- Repository-Referenz 382
-- Repository-Referenz 383
-- Repository-Referenz 384
-- Repository-Referenz 385
-- Repository-Referenz 386
-- Repository-Referenz 387
-- Repository-Referenz 388
-- Repository-Referenz 389
-- Repository-Referenz 390
-- Repository-Referenz 391
-- Repository-Referenz 392
-- Repository-Referenz 393
-- Repository-Referenz 394
-- Repository-Referenz 395
-- Repository-Referenz 396
-- Repository-Referenz 397
-- Repository-Referenz 398
-- Repository-Referenz 399
-- Repository-Referenz 400
-- Repository-Referenz 401
-- Repository-Referenz 402
-- Repository-Referenz 403
-- Repository-Referenz 404
-- Repository-Referenz 405
-- Repository-Referenz 406
-- Repository-Referenz 407
-- Repository-Referenz 408
-- Repository-Referenz 409
-- Repository-Referenz 410
-- Repository-Referenz 411
-- Repository-Referenz 412
-- Repository-Referenz 413
-- Repository-Referenz 414
-- Repository-Referenz 415
-- Repository-Referenz 416
-- Repository-Referenz 417
-- Repository-Referenz 418
-- Repository-Referenz 419
-- Repository-Referenz 420
-- Repository-Referenz 421
-- Repository-Referenz 422
-- Repository-Referenz 423
-- Repository-Referenz 424
-- Repository-Referenz 425
-- Repository-Referenz 426
-- Repository-Referenz 427
-- Repository-Referenz 428
-- Repository-Referenz 429
-- Repository-Referenz 430
-- Repository-Referenz 431
-- Repository-Referenz 432
-- Repository-Referenz 433
-- Repository-Referenz 434
-- Repository-Referenz 435
-- Repository-Referenz 436
-- Repository-Referenz 437
-- Repository-Referenz 438
-- Repository-Referenz 439
-- Repository-Referenz 440
-- Repository-Referenz 441
-- Repository-Referenz 442
-- Repository-Referenz 443
-- Repository-Referenz 444
-- Repository-Referenz 445
-- Repository-Referenz 446
-- Repository-Referenz 447
-- Repository-Referenz 448
-- Repository-Referenz 449
-- Repository-Referenz 450