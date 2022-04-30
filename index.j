(function() {
  "use strict";
  var M = Math.PI,
    N = Math.min,
    O = Math.max,
    P = Math.abs,
    Q = Math.cos,
    R = Math.sin,
    S = Math.hypot;

  function a(a) {
    return a.map(a => ({
      x: a.x,
      y: a.y,
      z: a.z
    }))
  }

  function b(a, b) {
    const c = a.length;
    for (let d = 0; d < c; d++) {
      const c = a[d],
        e = b[d];
      e.x = c.x, e.y = c.y, e.z = c.z
    }
  }

  function c(a) {
    const b = a.vertices;
    a.middle.x = (b[0].x + b[1].x + b[2].x) / 3, a.middle.y = (b[0].y + b[1].y + b[2].y) / 3, a.middle.z = (b[0].z + b[1].z + b[2].z) / 3
  }

  function d(a) {
    const b = a.vertices;
    a.middle.x = (b[0].x + b[1].x + b[2].x + b[3].x) / 4, a.middle.y = (b[0].y + b[1].y + b[2].y + b[3].y) / 4, a.middle.z = (b[0].z + b[1].z + b[2].z + b[3].z) / 4
  }

  function e(a) {
    3 === a.vertices.length ? c(a) : d(a)
  }

  function f(a) {
    e(a);
    const b = a.middle.x,
      c = a.middle.y,
      d = a.middle.z - va;
    a.depth = S(b, c, d)
  }

  function g(a, b) {
    const c = a.vertices[0],
      d = a.vertices[1],
      e = a.vertices[2],
      f = c.x - d.x,
      g = c.y - d.y,
      h = c.z - d.z,
      i = c.x - e.x,
      j = c.y - e.y,
      k = c.z - e.z,
      l = g * k - h * j,
      m = h * i - f * k,
      n = f * j - g * i,
      o = S(l, m, n),
      p = a[b];
    p.x = l / o, p.y = m / o, p.z = n / o
  }

  function h(a, b, c, d, e, f, g, h, j, k, l) {
    const m = R(f),
      n = Q(f),
      o = R(g),
      p = Q(g),
      q = R(h),
      r = Q(h);
    a.forEach((a, f) => {
      const g = b[f],
        h = a.x,
        i = a.z * m + a.y * n,
        s = a.z * n - a.y * m,
        t = h * p - s * o,
        u = i;
      g.x = (t * r - u * q) * j + c, g.y = (t * q + u * r) * k + d, g.z = (h * o + s * p) * l + e
    })
  }

  function i({
    scale: a = 1
  }) {
    return {
      vertices: [{
        x: -a,
        y: -a,
        z: a
      }, {
        x: a,
        y: -a,
        z: a
      }, {
        x: a,
        y: a,
        z: a
      }, {
        x: -a,
        y: a,
        z: a
      }, {
        x: -a,
        y: -a,
        z: -a
      }, {
        x: a,
        y: -a,
        z: -a
      }, {
        x: a,
        y: a,
        z: -a
      }, {
        x: -a,
        y: a,
        z: -a
      }],
      polys: [{
        vIndexes: [0, 1, 2, 3]
      }, {
        vIndexes: [7, 6, 5, 4]
      }, {
        vIndexes: [3, 2, 6, 7]
      }, {
        vIndexes: [4, 5, 1, 0]
      }, {
        vIndexes: [5, 6, 2, 1]
      }, {
        vIndexes: [0, 3, 7, 4]
      }]
    }
  }

  function j({
    recursionLevel: a,
    splitFn: b,
    color: c,
    scale: d = 1
  }) {
    const e = a => 1 / 3 ** a;
    let f = [{
      x: 0,
      y: 0,
      z: 0
    }];
    for (let g = 1; g <= a; g++) {
      const a = 2 * e(g),
        c = [];
      f.forEach(d => {
        c.push(...b(d, a))
      }), f = c
    }
    const g = {
        vertices: [],
        polys: []
      },
      h = i({
        scale: 1
      });
    h.vertices.forEach(gb(e(a)));
    const j = e(a) * (3 ** a - 1);
    return f.forEach((b, c) => {
      const e = O(P(b.x), P(b.y), P(b.z)) / j,
        f = 2 < a ? e : (e + .8) / 1.8;
      g.vertices.push(...h.vertices.map(a => ({
        x: (a.x + b.x) * d,
        y: (a.y + b.y) * d,
        z: (a.z + b.z) * d
      }))), g.polys.push(...h.polys.map(a => ({
        vIndexes: a.vIndexes.map(fb(8 * c))
      })))
    }), g
  }

  function k(a, b) {
    return [{
      x: a.x + b,
      y: a.y - b,
      z: a.z + b
    }, {
      x: a.x + b,
      y: a.y - b,
      z: a.z + 0
    }, {
      x: a.x + b,
      y: a.y - b,
      z: a.z - b
    }, {
      x: a.x + 0,
      y: a.y - b,
      z: a.z + b
    }, {
      x: a.x + 0,
      y: a.y - b,
      z: a.z - b
    }, {
      x: a.x - b,
      y: a.y - b,
      z: a.z + b
    }, {
      x: a.x - b,
      y: a.y - b,
      z: a.z + 0
    }, {
      x: a.x - b,
      y: a.y - b,
      z: a.z - b
    }, {
      x: a.x + b,
      y: a.y + b,
      z: a.z + b
    }, {
      x: a.x + b,
      y: a.y + b,
      z: a.z + 0
    }, {
      x: a.x + b,
      y: a.y + b,
      z: a.z - b
    }, {
      x: a.x + 0,
      y: a.y + b,
      z: a.z + b
    }, {
      x: a.x + 0,
      y: a.y + b,
      z: a.z - b
    }, {
      x: a.x - b,
      y: a.y + b,
      z: a.z + b
    }, {
      x: a.x - b,
      y: a.y + b,
      z: a.z + 0
    }, {
      x: a.x - b,
      y: a.y + b,
      z: a.z - b
    }, {
      x: a.x + b,
      y: a.y + 0,
      z: a.z + b
    }, {
      x: a.x + b,
      y: a.y + 0,
      z: a.z - b
    }, {
      x: a.x - b,
      y: a.y + 0,
      z: a.z + b
    }, {
      x: a.x - b,
      y: a.y + 0,
      z: a.z - b
    }]
  }

  function l(a, b = 1e-4) {
    const {
      vertices: c,
      polys: d
    } = a, e = (a, c) => P(a.x - c.x) < b && P(a.y - c.y) < b && P(a.z - c.z) < b, f = (a, b) => {
      const c = a.vIndexes,
        d = b.vIndexes;
      return (c[0] === d[0] || c[0] === d[1] || c[0] === d[2] || c[0] === d[3]) && (c[1] === d[0] || c[1] === d[1] || c[1] === d[2] || c[1] === d[3]) && (c[2] === d[0] || c[2] === d[1] || c[2] === d[2] || c[2] === d[3]) && (c[3] === d[0] ||
        c[3] === d[1] || c[3] === d[2] || c[3] === d[3])
    };
    c.forEach((a, b) => {
      a.originalIndexes = [b]
    });
    for (let d = c.length - 1; 0 <= d; d--)
      for (let a = d - 1; 0 <= a; a--) {
        const b = c[d],
          f = c[a];
        if (e(b, f)) {
          c.splice(d, 1), f.originalIndexes.push(...b.originalIndexes);
          break
        }
      }
    c.forEach((a, b) => {
      d.forEach(c => {
        c.vIndexes.forEach((c, d, e) => {
          const f = a.originalIndexes;
          f.includes(c) && (e[d] = b)
        })
      })
    }), d.forEach(a => {
      const b = a.vIndexes;
      a.sum = b[0] + b[1] + b[2] + b[3]
    }), d.sort((c, a) => a.sum - c.sum);
    for (let c = d.length - 1; 0 <= c; c--)
      for (let a = c - 1; 0 <= a; a--) {
        const b = d[c],
          e = d[a];
        if (b.sum !== e.sum) break;
        if (f(b, e)) {
          d.splice(c, 1), d.splice(a, 1), c--;
          break
        }
      }
    return a
  }

  function m() {
    for (; kb.length;) pb(kb.pop())
  }

  function n(a, b, c, d) {
    const e = wb.pop() || {};
    return e.x = a + .5 * c, e.y = b + .5 * d, e.xD = c, e.yD = d, e.life = Ya(200, 300), e.maxLife = e.life, vb.push(e), e
  }

  function o(a, b, c, d) {
    const e = Va / c;
    for (let f = 0; f < c; f++) {
      const c = f * e + e * Math.random(),
        g = (1 - Math.random() ** 3) * d;
      n(a, b, R(c) * g, Q(c) * g)
    }
  }

  function p(c) {
    xb ? b(c.vertices, xb) : xb = a(c.vertices), xb.forEach(a => {
      .4 > Math.random() && (hb(a), n(a.x, a.y, Ya(-12, 12), Ya(-12, 12)))
    })
  }

  function q(a) {
    wb.push(a)
  }

  function r(a) {
    yb.style.display = a ? "block" : "none"
  }

  function s() {
    Ma() ? (zb.style.display = "none", Ab.style.opacity = 1) : (zb.innerText = `SCORE: ${Ja.game.score}`, zb.style.display = "block", Ab.style.opacity = .65), Ab.innerText = `CUBES SMASHED: ${Ja.game.cubeCount}`
  }

  function t(a) {
    Bb.style.opacity = 0 === a ? 0 : 1, Cb.style.transform = `scaleX(${a.toFixed(3)})`
  }

  function u(a) {
    a.classList.add("active")
  }

  function v(a) {
    a.classList.remove("active")
  }

  function w() {
    switch (v(Eb), v(Fb), v(Gb), Ja.menus.active) {
      case Ga:
        u(Eb);
        break;
      case Ha:
        u(Fb);
        break;
      case Ia:
        Hb.textContent = Ua(Ja.game.score), Ib.textContent = Sa() ? "New High Score!" : `High Score: ${Ua(Pa())}`, u(Gb);
    }
    r(!La()), Db.classList.toggle("has-active", La()), Db.classList.toggle("interactive-mode", La() && aa)
  }

  function x(a) {
    Ja.menus.active = a, w()
  }

  function y(a) {
    Ja.game.score = a, s()
  }

  function z(a) {
    Ka() && (Ja.game.score += a, 0 > Ja.game.score && (Ja.game.score = 0), s())
  }

  function A(a) {
    Ja.game.cubeCount = a, s()
  }

  function B(a) {
    Ka() && (Ja.game.cubeCount += a, s())
  }

  function C(a) {
    Ja.game.mode = a
  }

  function D() {
    m(), Ja.game.time = 0, cb(), y(0), A(0), Jb = Z()
  }

  function E() {
    Ka() && x(Ha)
  }

  function F() {
    Na() && x(null)
  }

  function G() {
    K(), Sa() && Ra(Ja.game.score), x(Ia)
  }

  function H(a, b, c, d, e) {
    var j = Math.ceil;
    if (Ja.game.time += c, 0 < Ob) Ob -= c, 0 > Ob && (Ob = 0), Rb = aa ? .075 : .3;
    else {
      const a = La() && aa;
      Rb = a ? .025 : 1
    }
    t(Ob / Nb), T += (Rb - T) / 22 * e, T = Wa(T, 0, 1);
    const k = a / 2,
      l = b / 2,
      m = 1 - ha * d,
      n = 1 - la * d,
      r = 1 / (.75 * d + .25);
    Lb.x = 0, Lb.y = 0, Mb.x = 0, Mb.y = 0;
    const s = pa[pa.length - 1];
    aa && s && !s.touchBreak && (Lb.x = ca.x - s.x, Lb.y = ca.y - s.y, Mb.x = Lb.x * r, Mb.y = Lb.y * r);
    const u = S(Lb.x, Lb.y),
      v = u * r;
    for (pa.forEach(a => a.life -= c), aa && pa.push({
        x: ca.x,
        y: ca.y,
        life: oa
      }); pa[0] && 0 >= pa[0].life;) pa.shift();
    if (Jb -= c, 0 >= Jb) {
      0 < Pb ? (Pb--, Jb = Qb) : Jb = Z();
      const a = nb(),
        b = N(.8 * k, Kb);
      a.x = 2 * (Math.random() * b) - b, a.y = l + 100, a.z = 2 * (Math.random() * qa) - qa, a.xD = Math.random() * (-2 * a.x / 120), a.yD = -20, kb.push(a)
    }
    const w = -k + qa,
      x = k - qa,
      y = -l - 120,
      A = .4;
    targetLoop: for (let a = kb.length - 1; 0 <= a; a--) {
      const b = kb[a];
      if (b.x += b.xD * d, b.y += b.yD * d, b.y < y && (b.y = y, b.yD = 0), b.x < w ? (b.x = w, b.xD *= -A) : b.x > x && (b.x = x, b.xD *= -A), b.z < fa && (b.z = fa, b.zD *= -A), b.yD += ia * d, b.rotateX += b.rotateXD * d, b.rotateY += b
        .rotateYD * d, b.rotateZ += b.rotateZD * d, b.transform(), b.project(), b.y > l + 100) {
        kb.splice(a, 1), pb(b), Ka() && (Ma() ? z(-25) : G());
        continue
      }
      const c = j(2 * (u / qa));
      for (let d = 1; d <= c; d++) {
        const e = 1 - d / c,
          f = ca.x - Lb.x * e,
          g = ca.y - Lb.y * e,
          h = S(f - b.projected.x, g - b.projected.y);
        if (h <= ra) {
          if (!b.hit) {
            b.hit = !0, b.xD += Mb.x * ea, b.yD += Mb.y * ea, b.rotateXD += .001 * Mb.y, b.rotateYD += .001 * Mb.x;
            const c = 7 + .125 * v;
            v > da ? (b.health--, z(10), 0 >= b.health ? (B(1), tb(b, r), o(f, g, 8, c), b.wireframe && (Ob = Nb, Jb = 0, Pb = 2), kb.splice(a, 1), pb(b)) : (o(f, g, 8, c), p(b), ob(b, 0))) : (z(5), o(f, g, 3, c))
          }
          continue targetLoop
        }
      }
      b.hit = !1
    }
    const C = fa + ta;
    for (let f = qb.length - 1; 0 <= f; f--) {
      const b = qb[f];
      if (b.x += b.xD * d, b.y += b.yD * d, b.z += b.zD * d, b.xD *= m, b.yD *= m, b.zD *= m, b.y < y && (b.y = y, b.yD = 0), b.z < C && (b.z = C, b.zD *= -A), b.yD += ia * d, b.rotateX += b.rotateXD * d, b.rotateY += b.rotateYD * d, b
        .rotateZ += b.rotateZD * d, b.transform(), b.project(), b.projected.y > l + ra || b.projected.x < -a || b.projected.x > a || b.z > ya) {
        qb.splice(f, 1), ub(b);
        continue
      }
    }
    for (let f = vb.length - 1; 0 <= f; f--) {
      const a = vb[f];
      if (a.life -= c, 0 >= a.life) {
        vb.splice(f, 1), q(a);
        continue
      }
      a.x += a.xD * d, a.y += a.yD * d, a.xD *= n, a.yD *= n, a.yD += ia * d
    }
    Aa.length = 0, Ba.length = 0, Ca.length = 0, Da.length = 0, kb.forEach(a => {
      Aa.push(...a.vertices), Ba.push(...a.polys), Ca.push(...a.shadowVertices), Da.push(...a.shadowPolys)
    }), qb.forEach(a => {
      Aa.push(...a.vertices), Ba.push(...a.polys), Ca.push(...a.shadowVertices), Da.push(...a.shadowPolys)
    }), Ba.forEach(a => g(a, "normalWorld")), Ba.forEach(f), Ba.sort((c, a) => a.depth - c.depth), Aa.forEach(hb), Ba.forEach(a => g(a, "normalCamera")), h(Ca, Ca, 0, 0, 0, Va / 8, 0, 0, 1, 1, 1), Da.forEach(a => g(a, "normalWorld"));
    const D = S(1, 1),
      E = Ca.length;
    for (let f = 0; f < E; f++) {
      const a = Aa[f].z - fa;
      Ca[f].z -= D * a
    }
    h(Ca, Ca, 0, 0, 0, -Va / 8, 0, 0, 1, 1, 1), Ca.forEach(hb)
  }

  function I(a, b, c) {
    a.lineJoin = "bevel", a.fillStyle = ga, a.strokeStyle = ga, Da.forEach(b => {
      if (b.wireframe) {
        a.lineWidth = 2, a.beginPath();
        const {
          vertices: c
        } = b, d = c.length, e = c[0];
        a.moveTo(e.x, e.y);
        for (let b = 1; b < d; b++) {
          const d = c[b];
          a.lineTo(d.x, d.y)
        }
        a.closePath(), a.stroke()
      } else {
        a.beginPath();
        const {
          vertices: c
        } = b, d = c.length, e = c[0];
        a.moveTo(e.x, e.y);
        for (let b = 1; b < d; b++) {
          const d = c[b];
          a.lineTo(d.x, d.y)
        }
        a.closePath(), a.fill()
      }
    }), Ba.forEach(b => {
      if (!b.wireframe && 0 > b.normalCamera.z) return;
      0 !== b.strokeWidth && (a.lineWidth = 0 > b.normalCamera.z ? .5 * b.strokeWidth : b.strokeWidth, a.strokeStyle = 0 > b.normalCamera.z ? b.strokeColorDark : b.strokeColor);
      const {
        vertices: c
      } = b, d = c[c.length - 1], e = b.middle.z > xa;
      if (!b.wireframe) {
        const c = .5 * b.normalWorld.y + -.5 * b.normalWorld.z,
          d = 0 < c ? .1 : .9 * ((c ** 32 - c) / 2) + .1;
        a.fillStyle = _a(b.color, d)
      }
      e && (a.globalAlpha = O(0, 1 - (b.middle.z - xa) / za)), a.beginPath(), a.moveTo(d.x, d.y);
      for (let d of c) a.lineTo(d.x, d.y);
      b.wireframe || a.fill(), 0 !== b.strokeWidth && a.stroke(), e && (a.globalAlpha = 1)
    }), a.strokeStyle = ja, a.lineWidth = ka, a.beginPath(), vb.forEach(b => {
      a.moveTo(b.x, b.y);
      const c = 1.5 * (b.life / b.maxLife) ** .5;
      a.lineTo(b.x - b.xD * c, b.y - b.yD * c)
    }), a.stroke(), a.strokeStyle = ma;
    const d = pa.length;
    for (let e = 1; e < d; e++) {
      const b = pa[e],
        c = pa[e - 1];
      if (b.touchBreak || c.touchBreak) continue;
      const d = b.life / oa;
      a.lineWidth = d * na, a.beginPath(), a.moveTo(c.x, c.y), a.lineTo(b.x, b.y), a.stroke()
    }
  }

  function J(a, b) {
    aa || (aa = !0, ba.x = a, ba.y = b, La() && w())
  }

  function K() {
    aa && (aa = !1, pa.push({
      touchBreak: !0,
      life: oa
    }), La() && w())
  }

  function L(a, b) {
    aa && (ba.x = a, ba.y = b)
  }
  let T = 1;
  const U = {
      r: 103,
      g: 215,
      b: 240
    },
    V = {
      r: 166,
      g: 224,
      b: 44
    },
    W = {
      r: 250,
      g: 36,
      b: 115
    },
    X = {
      r: 254,
      g: 149,
      b: 34
    },
    Y = [U, V, W, X],
    Z = () => {
      const a = 1400 - 3.1 * Ja.game.cubeCount;
      return O(a, 550)
    },
    _ = 2e3;
  let aa = !1,
    ba = {
      x: 0,
      y: 0
    },
    ca = {
      x: 0,
      y: 0
    };
  const da = 60,
    ea = .1,
    fa = -400,
    ga = "#262e36",
    ha = .022,
    ia = .3,
    ja = "rgba(170,221,255,.9)",
    ka = 2.2,
    la = .1,
    ma = "rgba(170,221,255,.62)",
    na = 7,
    oa = 120,
    pa = [],
    qa = 40,
    ra = 50,
    sa = () => "rgb(170,221,255)",
    ta = qa / 3,
    ua = document.querySelector("#c"),
    va = 900,
    wa = 1,
    xa = .45 * va,
    ya = .65 * va,
    za = ya - xa,
    Aa = [],
    Ba = [],
    Ca = [],
    Da = [],
    Ea = Symbol("GAME_MODE_RANKED"),
    Fa = Symbol("GAME_MODE_CASUAL"),
    Ga = Symbol("MENU_MAIN"),
    Ha = Symbol("MENU_PAUSE"),
    Ia = Symbol("MENU_SCORE"),
    Ja = {
      game: {
        mode: Ea,
        time: 0,
        score: 0,
        cubeCount: 0
      },
      menus: {
        active: Ga
      }
    },
    Ka = () => !Ja.menus.active,
    La = () => !!Ja.menus.active,
    Ma = () => Ja.game.mode === Fa,
    Na = () => Ja.menus.active === Ha,
    Oa = "__CuttingEdge__highScore",
    Pa = () => {
      const a = localStorage.getItem(Oa);
      return a ? parseInt(a, 10) : 0
    };
  let Qa = Pa();
  const Ra = a => {
      Qa = Pa(), localStorage.setItem(Oa, a + "")
    },
    Sa = () => Ja.game.score > Qa,
    Ta = a => document.querySelector(a),
    $ = (a, b) => a.addEventListener("click", b),
    Ua = a => a.toLocaleString(),
    Va = 2 * M,
    Wa = (a, b, c) => N(O(a, b), c),
    Xa = (c, a, b) => (a - c) * b + c,
    Ya = (a, b) => Math.random() * (b - a) + a,
    Za = a => a[0 | Math.random() * a.length],
    $a = a => "#" + (0 | a.r).toString(16).padStart(2, "0") + (0 | a.g).toString(16).padStart(2, "0") + (0 | a.b).toString(16).padStart(2, "0"),
    _a = (a, b) => {
      let c, d;
      return .5 > b ? (c = 0, d = 1 - 2 * b) : (c = 255, d = 2 * b - 1), "#" + (0 | Xa(a.r, c, d)).toString(16).padStart(2, "0") + (0 | Xa(a.g, c, d)).toString(16).padStart(2, "0") + (0 | Xa(a.b, c, d)).toString(16).padStart(2, "0")
    },
    ab = [],
    bb = (a, b = 1) => {
      let c = 0,
        d = 0;
      const e = {
          rechargeTime: a,
          units: b
        },
        f = () => {
          const a = Ja.game.time;
          a < d ? c = 0 : (c -= a - d, 0 > c && (c = 0)), d = a
        },
        g = () => (f(), c <= a * (b - 1)),
        h = {
          canUse: g,
          useIfAble() {
            const b = g();
            return b && (c += a), b
          },
          mutate(d) {
            d.rechargeTime && (c -= a - d.rechargeTime, 0 > c && (c = 0), a = d.rechargeTime), d.units && (b = d.units)
          },
          reset() {
            c = 0, d = 0, this.mutate(e)
          }
        };
      return ab.push(h), h
    },
    cb = () => ab.forEach(a => a.reset()),
    db = ({
      chance: a,
      cooldownPerSpawn: b,
      maxSpawns: c
    }) => {
      const d = bb(b, c);
      return {
        shouldSpawn() {
          return Math.random() <= a && d.useIfAble()
        },
        mutate(b) {
          b.chance && (a = b.chance), d.mutate({
            rechargeTime: b.cooldownPerSpawn,
            units: b.maxSpawns
          })
        }
      }
    },
    eb = a => {
      const b = S(a.x, a.y, a.z);
      return {
        x: a.x / b,
        y: a.y / b,
        z: a.z / b
      }
    },
    fb = c => a => c + a,
    gb = a => b => {
      b.x *= a, b.y *= a, b.z *= a
    },
    hb = a => {
      const b = va * wa / (va - a.z);
      a.x *= b, a.y *= b
    },
    ib = (a, b) => {
      const c = va * wa / (va - a.z);
      b.x = a.x * c, b.y = a.y * c
    };
  class jb {
    constructor({
      model: b,
      color: c,
      wireframe: d = !1
    }) {
      const e = a(b.vertices),
        f = a(b.vertices),
        g = $a(c),
        h = _a(c, .4),
        i = b.polys.map(a => ({
          vertices: a.vIndexes.map(a => e[a]),
          color: c,
          wireframe: d,
          strokeWidth: d ? 2 : 0,
          strokeColor: g,
          strokeColorDark: h,
          depth: 0,
          middle: {
            x: 0,
            y: 0,
            z: 0
          },
          normalWorld: {
            x: 0,
            y: 0,
            z: 0
          },
          normalCamera: {
            x: 0,
            y: 0,
            z: 0
          }
        })),
        j = b.polys.map(a => ({
          vertices: a.vIndexes.map(a => f[a]),
          wireframe: d,
          normalWorld: {
            x: 0,
            y: 0,
            z: 0
          }
        }));
      this.projected = {}, this.model = b, this.vertices = e, this.polys = i, this.shadowVertices = f, this.shadowPolys = j, this.reset()
    }
    reset() {
      this.x = 0, this.y = 0, this.z = 0, this.xD = 0, this.yD = 0, this.zD = 0, this.rotateX = 0, this.rotateY = 0, this.rotateZ = 0, this.rotateXD = 0, this.rotateYD = 0, this.rotateZD = 0, this.scaleX = 1, this.scaleY = 1, this.scaleZ = 1,
        this.projected.x = 0, this.projected.y = 0
    }
    transform() {
      h(this.model.vertices, this.vertices, this.x, this.y, this.z, this.rotateX, this.rotateY, this.rotateZ, this.scaleX, this.scaleY, this.scaleZ), b(this.vertices, this.shadowVertices)
    }
    project() {
      ib(this, this.projected)
    }
  }
  const kb = [],
    lb = new Map(Y.map(a => [a, []])),
    mb = new Map(Y.map(a => [a, []])),
    nb = (() => {
      function a(a, b) {
        const c = b ? mb : lb;
        let d = c.get(a).pop();
        return d || (d = new jb({
          model: l(j({
            recursionLevel: 1,
            splitFn: k,
            scale: qa
          })),
          color: a,
          wireframe: b
        }), d.color = a, d.wireframe = b, d.hit = !1, d.maxHealth = 0, d.health = 0), d
      }
      const b = db({
        chance: .5,
        cooldownPerSpawn: 1e4,
        maxSpawns: 1
      });
      let c = !1;
      const d = db({
          chance: .3,
          cooldownPerSpawn: 12e3,
          maxSpawns: 1
        }),
        e = db({
          chance: .1,
          cooldownPerSpawn: 1e4,
          maxSpawns: 1
        }),
        f = [
          ["x", "y"],
          ["y", "z"],
          ["z", "x"]
        ];
      return function() {
        c && Ja.game.score <= _ ? c = !1 : !c && Ja.game.score > _ && (c = !0, d.mutate({
          maxSpawns: 2
        }));
        let g = Za([U, V, X]),
          h = !1,
          i = 1;
        const j = Ja.game.cubeCount >= 25 && Ka() && e.shouldSpawn();
        Ja.game.cubeCount >= 10 && b.shouldSpawn() ? (g = U, h = !0) : Ja.game.cubeCount >= 25 && d.shouldSpawn() && (g = W, i = 3);
        const k = a(g, h);
        k.hit = !1, k.maxHealth = 3, k.health = i, ob(k, 0);
        const l = [.1 * Math.random() - .05, .1 * Math.random() - .05];
        j && (l[0] = -.25, l[1] = 0, k.rotateZ = Ya(0, Va));
        const m = Za(f);
        return l.forEach((a, b) => {
          switch (m[b]) {
            case "x":
              k.rotateXD = a;
              break;
            case "y":
              k.rotateYD = a;
              break;
            case "z":
              k.rotateZD = a;
          }
        }), k
      }
    })(),
    ob = (a, b) => {
      if (a.health += b, !a.wireframe) {
        const b = a.health - 1,
          c = sa(a);
        for (let d of a.polys) d.strokeWidth = b, d.strokeColor = c
      }
    },
    pb = a => {
      a.reset();
      const b = a.wireframe ? mb : lb;
      b.get(a.color).push(a)
    },
    qb = [],
    rb = new Map(Y.map(a => [a, []])),
    sb = new Map(Y.map(a => [a, []])),
    tb = (() => {
      function b(a) {
        const b = a.wireframe ? sb : rb;
        let c = b.get(a.color).pop();
        return c || (c = new jb({
          model: i({
            scale: ta
          }),
          color: a.color,
          wireframe: a.wireframe
        }), c.color = a.color, c.wireframe = a.wireframe), c
      }
      const c = k({
          x: 0,
          y: 0,
          z: 0
        }, 2 * ta),
        d = a(c),
        e = a(c),
        f = a(c),
        g = c.map(eb),
        j = a(g),
        l = c.length;
      return (a, k = 1) => {
        h(c, d, a.x, a.y, a.z, a.rotateX, a.rotateY, a.rotateZ, 1, 1, 1), h(c, e, a.x - a.xD, a.y - a.yD, a.z - a.zD, a.rotateX - a.rotateXD, a.rotateY - a.rotateYD, a.rotateZ - a.rotateZD, 1, 1, 1);
        for (let b = 0; b < l; b++) {
          const a = d[b],
            c = e[b],
            g = f[b];
          g.x = a.x - c.x, g.y = a.y - c.y, g.z = a.z - c.z
        }
        h(g, j, 0, 0, 0, a.rotateX, a.rotateY, a.rotateZ, 1, 1, 1);
        for (let c = 0; c < l; c++) {
          const e = d[c],
            g = f[c],
            h = j[c],
            i = b(a);
          i.x = e.x, i.y = e.y, i.z = e.z, i.rotateX = a.rotateX, i.rotateY = a.rotateY, i.rotateZ = a.rotateZ;
          const l = 2 * k,
            m = 2 * k,
            n = .015;
          i.xD = g.x + h.x * l + Math.random() * m, i.yD = g.y + h.y * l + Math.random() * m, i.zD = g.z + h.z * l + Math.random() * m, i.rotateXD = i.xD * n, i.rotateYD = i.yD * n, i.rotateZD = i.zD * n, qb.push(i)
        }
      }
    })(),
    ub = a => {
      a.reset();
      const b = a.wireframe ? sb : rb;
      b.get(a.color).push(a)
    },
    vb = [],
    wb = [];
  let xb;
  const yb = Ta(".hud"),
    zb = Ta(".score-lbl"),
    Ab = Ta(".cube-count-lbl");
  s(), ((a, b) => {
    a.addEventListener("touchstart", b), a.addEventListener("mousedown", b)
  })(Ta(".pause-btn"), () => E());
  const Bb = Ta(".slowmo"),
    Cb = Ta(".slowmo__bar"),
    Db = Ta(".menus"),
    Eb = Ta(".menu--main"),
    Fb = Ta(".menu--pause"),
    Gb = Ta(".menu--score"),
    Hb = Ta(".final-score-lbl"),
    Ib = Ta(".high-score-lbl");
  w(), $(Ta(".play-normal-btn"), () => {
    C(Ea), x(null), D()
  }), $(Ta(".play-casual-btn"), () => {
    C(Fa), x(null), D()
  }), $(Ta(".resume-btn"), () => F()), $(Ta(".menu-btn--pause"), () => x(Ga)), $(Ta(".play-again-btn"), () => {
    x(null), D()
  }), $(Ta(".menu-btn--score"), () => x(Ga)), window.addEventListener("keydown", a => {
    "p" === a.key && (Na() ? F() : E())
  });
  let Jb = 0;
  const Kb = 450,
    Lb = {
      x: 0,
      y: 0
    },
    Mb = {
      x: 0,
      y: 0
    },
    Nb = 1500;
  let Ob = 0,
    Pb = 0;
  const Qb = 300;
  let Rb = 1;
  if ("PointerEvent" in window) ua.addEventListener("pointerdown", a => {
    a.isPrimary && J(a.clientX, a.clientY)
  }), ua.addEventListener("pointerup", a => {
    a.isPrimary && K()
  }), ua.addEventListener("pointermove", a => {
    a.isPrimary && L(a.clientX, a.clientY)
  }), document.body.addEventListener("mouseleave", K);
  else {
    let a = null;
    ua.addEventListener("touchstart", b => {
      if (!aa) {
        const c = b.changedTouches[0];
        a = c.identifier, J(c.clientX, c.clientY)
      }
    }), ua.addEventListener("touchend", b => {
      for (let c of b.changedTouches)
        if (c.identifier === a) {
          K();
          break
        }
    }), ua.addEventListener("touchmove", b => {
      for (let c of b.changedTouches)
        if (c.identifier === a) {
          L(c.clientX, c.clientY), b.preventDefault();
          break
        }
    }, {
      passive: !1
    })
  }(function() {
    function a() {
      const a = window.innerWidth,
        b = window.innerHeight;
      e = b / 1e3, f = a / e, g = b / e, ua.width = a * d, ua.height = b * d, ua.style.width = a + "px", ua.style.height = b + "px"
    }

    function b(a) {
      let b = a - h;
      if (h = a, i(), Na()) return;
      0 > b ? b = 17 : 68 < b && (b = 68);
      const j = f / 2,
        k = g / 2;
      ca.x = ba.x / e - j, ca.y = ba.y / e - k;
      const l = b / 16.6667,
        m = T * b,
        n = T * l;
      H(f, g, m, n, l), c.clearRect(0, 0, ua.width, ua.height);
      const o = d * e;
      c.scale(o, o), c.translate(j, k), I(c, f, g, e), c.setTransform(1, 0, 0, 1, 0, 0)
    }
    const c = ua.getContext("2d"),
      d = window.devicePixelRatio || 1;
    let e, f, g;
    a(), window.addEventListener("resize", a);
    let h = 0;
    const i = () => requestAnimationFrame(b);
    i()
  })()
})();
