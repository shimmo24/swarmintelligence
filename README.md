# Schwarmintelligenz

An interactive **Boids** swarm simulation in the browser. Hundreds of small
squares move around and, from a few simple local rules, form flocks that
resemble schools of fish or flocks of birds — no leader, no central control.

Everything runs in a single self-contained HTML file. No build step, no
dependencies, no server required.

<!-- Tip: add a screenshot here, e.g. ![screenshot](screenshot.png) -->

## Features

- Adjustable number of squares (10 – 2000), **optimized** neighbor lookup via a
  spatial grid instead of O(n²)
- Adjustable speed, perception radius and separation radius
- Five independently tunable behavior rules (weights can be set to 0 to turn
  a rule off)
- Cluster analysis: the swarm is continuously split into connected groups
  so rules can act on "small vs. large swarms"
- Visual options: motion trails, wrap-around edges, glow
- Live HUD (FPS, square count, detected swarms) and keyboard shortcuts

## Getting started

**Option A — just open it**

Open `index.html` in any modern browser (double-click it).

**Option B — local server**

```bash
./start.sh          # serves on http://localhost:8090 and opens the browser
./start.sh 9000     # or pick another port
```

## Controls

### Swarm

| Slider | Range | Default | Description |
|---|---|---|---|
| Number of squares | 10 – 2000 | 150 | How many squares are simulated |
| Speed | 0.2 – 8 | 2.4 | Cruise speed (pixels per step) |
| Perception radius | 10 – 220 | 72 | How far a square "sees" neighbors |
| Separation radius | 6 – 120 | 26 | Distance at which squares push apart |

### The rules

| Rule | Weight (default) | Effect |
|---|---|---|
| **Avoid** (separation) | 1.6 | Steer away from squares that are too close |
| **Toward the center** (cohesion) | 0.8 | Steer toward the average position of neighbors |
| **Same direction** (alignment) | 1.0 | Match the average heading of neighbors |
| **Small → big swarms** | 1.0 | A small group flies toward the center of the nearest large group. "Large" is defined by the *Large swarm from* threshold (5 – 500, default 40). Active large-swarm centers are marked with orange crosses. |
| **Small = faster** | 0.8 | A square's speed scales inversely with the size of its swarm. Reference is the largest swarm on screen: the biggest swarm keeps base speed, smaller groups move faster (a lone square moves fastest). Set to 0 to disable. |

### Display

- **Trails** — draw fading motion trails
- **Wrap around edges** — squares leave one side and reappear on the other
  (otherwise they bounce off the walls)
- **Glow** — soft glow around each square

### Buttons & shortcuts

- **Pause / Resume** — or press `Space`
- **Reshuffle** — randomize positions and headings, or press `R`

## How the rules work

Each square only makes local decisions — it looks at neighbors within its
perception radius and combines the weighted forces above. Flocking is the
**emergent** result, not something that is drawn directly.

Rules 4 and 5 work on a coarser level: a coarse grid is used each frame to
find connected groups of squares (clusters), together with each group's size
and center. Rule 4 lets small groups merge into large ones; rule 5 makes
smaller groups move faster than larger ones.

## Performance notes

- Neighbor search uses a spatial hash grid plus a cap on neighbors examined
  per square, keeping the cost near-linear in the number of squares.
- Measured in headless Chromium: ~60 FPS at 400 squares and ~26 FPS at the
  maximum of 2000 squares (both with all rules enabled). Your results depend
  on your machine.
- Rendering is DPR-aware and frame-rate independent (the simulation is scaled
  by the real elapsed time).

## Tech

Plain HTML, CSS and JavaScript (Canvas 2D + `requestAnimationFrame`). Data is
stored in typed arrays (`Float32Array`) to stay fast at high square counts.

A read-only debug hook is exposed for testing and inspection:

```js
window.__sim.P              // live parameters
window.__sim.snapshot()     // positions/velocities, cluster ids and sizes
```
Made with Deepseek V4.1 Flash in 15 Minutes.
## License

MIT
