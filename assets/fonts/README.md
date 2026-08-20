# Bundled fonts

Self-hosted rather than fetched from `fonts.googleapis.com` at runtime, so first
paint does not depend on a third-party request.

| Family           | Weights   | Source                                        |
| ---------------- | --------- | --------------------------------------------- |
| IBM Plex Sans    | 400, 600  | google/fonts `ofl/ibmplexsans` (variable)     |
| IBM Plex Mono    | 400, 500  | google/fonts `ofl/ibmplexmono`                |
| Instrument Serif | 400       | google/fonts `ofl/instrumentserif`            |

Both families are licensed under the SIL Open Font License 1.1; see the `OFL-*.txt`
files alongside these fonts.

## Regenerating

IBM Plex Sans upstream is now a variable font, so the static weights are instanced
out of it first, then every file is subset to Latin. Requires `uv`.

```sh
# 1. Instance the variable font at the weights we use.
uvx --from "fonttools[woff]" fonttools varLib.instancer \
  'IBMPlexSans[wdth,wght].ttf' wght=400 wdth=100 -o _sans400.ttf

# 2. Subset to Latin. Widen --unicodes if copy needs more characters.
uvx --from "fonttools[woff]" pyftsubset _sans400.ttf \
  --unicodes="U+0000-00FF,U+0131,U+0152-0153,U+02BB-02BC,U+02C6,U+02DA,U+02DC,U+2000-206F,U+2074,U+20AC,U+2122,U+2190-21FF,U+2212,U+2215,U+25A0,U+25CF,U+2605,U+FEFF,U+FFFD" \
  --layout-features='kern,liga,calt,tnum' --no-hinting \
  --output-file=IBMPlexSans-Regular.ttf
```

The range deliberately covers the whole arrow block (U+2190-21FF) because the UI
sets "↗" (U+2197) on every external link, and U+00E9 (é in "résumé"). Dropping
either makes CanvasKit fall back to a Noto font fetched from gstatic at runtime,
which reintroduces the third-party request self-hosting was meant to remove.

Instrument Serif has no U+2197 in its source and does not need one — arrows are
only ever set in IBM Plex Mono.
