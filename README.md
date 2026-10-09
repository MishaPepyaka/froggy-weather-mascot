# Froggy Weather Mascot

A Hyprlock add-on featuring a pixel-art frog on the lock screen. It shows the weather for Winnipeg and changes its activity throughout the day. All artwork is stored in `assets/`; the scripts use Open-Meteo with a local cache, so the mascot still works after the first successful weather request even when the network is unavailable.

## Schedule

| Time | Scene |
| --- | --- |
| 22:00–07:00 | three sleeping poses: back, side, and crosswise in bed |
| 07:00–08:00 | brushing teeth plus two breakfast scenes, rotating every 15 minutes |
| 18:00–21:00 | tea, hammock, console, drawing, and a book, rotating every 15 minutes |
| 21:00–22:00 | reading in bed, brushing teeth, a bath, and stargazing, rotating every 15 minutes |
| All other times | two distinct scenes for each current weather and temperature condition |

Clicking the frog from 07:00–08:00 cycles through the three morning scenes; from 21:00–22:00 it cycles through the four bedtime scenes. A manually selected scene remains in place until that scheduled interval ends.

## Requirements

- Hyprland and Hyprlock;
- Bash, `curl`, `jq`, and GNU `date`;
- access to `api.open-meteo.com` to refresh the forecast.

## Installation

Clone the project or open this directory, then run:

```bash
cd /path/to/froggy-weather-mascot
./install.sh
```

The installer copies the scripts to `~/.local/bin/`, images to `~/.local/share/lockscreen/`, and creates `~/.cache/lock-weather/`. It does not modify your existing `hyprlock.conf`.

Paste the contents of [`config/hyprlock-mascot.conf`](config/hyprlock-mascot.conf) into `~/.config/hypr/hyprlock.conf`. The snippet adds one image and three forecast labels. Lock the screen again to see the result.

## Choosing a city

The city is not detected automatically. It is set by the Open-Meteo request URL in [`scripts/lock-weather-winnipeg`](scripts/lock-weather-winnipeg), specifically by these values:

```bash
latitude=49.8951
longitude=-97.1384
timezone=America%2FWinnipeg
```

Replace them with your location's latitude, longitude, and IANA time-zone name. For example, for Toronto use:

```bash
latitude=43.6532
longitude=-79.3832
timezone=America%2FToronto
```

After changing the script in this project, run `./install.sh` again. To force an immediate refresh, remove `~/.cache/lock-weather/winnipeg.json`; otherwise the cache refreshes automatically every 15 minutes.

## Customization

The main file is [`scripts/lock-weather-winnipeg`](scripts/lock-weather-winnipeg):

- `api_url` contains the city coordinates and time zone;
- the `sleep_scenes`, `morning_scenes`, `bedtime_scenes`, and `evening_scenes` arrays define the time-based rotations;
- the time intervals are defined in `update_mascot()`;
- the weather rules follow the schedule and apply only outside scheduled routines.

To replace an illustration, add a PNG to `assets/`, reinstall the project, and reference its filename from the appropriate array.

## Project layout

```text
assets/    Frog PNG artwork
scripts/   Weather script and click handler
config/    Ready-to-paste Hyprlock snippet
install.sh Installer for the current user
```
