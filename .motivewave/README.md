# MotiveWave config

Portable user config for MotiveWave on Linux. Maps to `~/.motivewave/`.

## Files

| File | Purpose |
|------|---------|
| `startup.ini` | JVM startup options read by the launcher: `MAX_HEAP`, `MAX_VRAM`, `SCALE`, `VM_ARGS` |
| `settings.json` | UI themes and font sizes (chart/bar/window theme, `fontSize`, per-panel fonts) |

`SCALE` is a percentage passed to the JVM as `-Dglass.gtk.uiScale` /
`-Dsun.java2d.uiScale`. `100%` is normal; use `90%` for slightly smaller,
`125%`+ for larger. MotiveWave only reads `startup.ini` at launch and rewrites
it while running, so **fully quit the app before editing**.

## Deliberately NOT tracked

These live in `~/.motivewave/` but are machine/account specific or sensitive:

- `.cfg` — encrypted local state
- `mwave_license.txt` — license
- `workspaces/` — layouts plus account/order data (may contain account IDs / API details)
- `historical_data/` — cached market data
- `output/` — runtime logs (contain signed API URLs)

## Apply

Back up first, then copy or symlink the two files into `~/.motivewave/`:

```sh
mkdir -p ~/.motivewave
cp .motivewave/startup.ini ~/.motivewave/startup.ini
cp .motivewave/settings.json ~/.motivewave/settings.json
```

Do this while MotiveWave is closed, then launch it.
