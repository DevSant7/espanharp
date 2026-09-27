(function() {
    const t = document.createElement("link").relList;
    if (t && t.supports && t.supports("modulepreload")) return;
    for (const o of document.querySelectorAll('link[rel="modulepreload"]')) s(o);
    new MutationObserver(o => {
        for (const i of o)
            if (i.type === "childList")
                for (const r of i.addedNodes) r.tagName === "LINK" && r.rel === "modulepreload" && s(r)
    }).observe(document, {
        childList: !0,
        subtree: !0
    });

    function n(o) {
        const i = {};
        return o.integrity && (i.integrity = o.integrity), o.referrerPolicy && (i.referrerPolicy = o.referrerPolicy), o.crossOrigin === "use-credentials" ? i.credentials = "include" : o.crossOrigin === "anonymous" ? i.credentials = "omit" : i.credentials = "same-origin", i
    }

    function s(o) {
        if (o.ep) return;
        o.ep = !0;
        const i = n(o);
        fetch(o.href, i)
    }
})();
/**
 * @vue/shared v3.4.21
 * (c) 2018-present Yuxi (Evan) You and Vue contributors
 * @license MIT
 **/
function Ts(e, t) {
    const n = new Set(e.split(","));
    return t ? s => n.has(s.toLowerCase()) : s => n.has(s)
}
const ne = {},
    wt = [],
    Te = () => {},
    Yi = () => !1,
    Tn = e => e.charCodeAt(0) === 111 && e.charCodeAt(1) === 110 && (e.charCodeAt(2) > 122 || e.charCodeAt(2) < 97),
    Is = e => e.startsWith("onUpdate:"),
    he = Object.assign,
    Es = (e, t) => {
        const n = e.indexOf(t);
        n > -1 && e.splice(n, 1)
    },
    Zi = Object.prototype.hasOwnProperty,
    q = (e, t) => Zi.call(e, t),
    L = Array.isArray,
    Tt = e => In(e) === "[object Map]",
    Do = e => In(e) === "[object Set]",
    R = e => typeof e == "function",
    le = e => typeof e == "string",
    At = e => typeof e == "symbol",
    ee = e => e !== null && typeof e == "object",
    Bo = e => (ee(e) || R(e)) && R(e.then) && R(e.catch),
    Vo = Object.prototype.toString,
    In = e => Vo.call(e),
    Xi = e => In(e).slice(8, -1),
    Uo = e => In(e) === "[object Object]",
    Ms = e => le(e) && e !== "NaN" && e[0] !== "-" && "" + parseInt(e, 10) === e,
    Ht = Ts(",key,ref,ref_for,ref_key,onVnodeBeforeMount,onVnodeMounted,onVnodeBeforeUpdate,onVnodeUpdated,onVnodeBeforeUnmount,onVnodeUnmounted"),
    En = e => {
        const t = Object.create(null);
        return n => t[n] || (t[n] = e(n))
    },
    Qi = /-(\w)/g,
    Ue = En(e => e.replace(Qi, (t, n) => n ? n.toUpperCase() : "")),
    er = /\B([A-Z])/g,
    Nt = En(e => e.replace(er, "-$1").toLowerCase()),
    Mn = En(e => e.charAt(0).toUpperCase() + e.slice(1)),
    Yn = En(e => e ? `on${Mn(e)}` : ""),
    it = (e, t) => !Object.is(e, t),
    hn = (e, t) => {
        for (let n = 0; n < e.length; n++) e[n](t)
    },
    bn = (e, t, n) => {
        Object.defineProperty(e, t, {
            configurable: !0,
            enumerable: !1,
            value: n
        })
    },
    cs = e => {
        const t = parseFloat(e);
        return isNaN(t) ? e : t
    },
    tr = e => {
        const t = le(e) ? Number(e) : NaN;
        return isNaN(t) ? e : t
    };
let Ys;
const Ko = () => Ys || (Ys = typeof globalThis < "u" ? globalThis : typeof self < "u" ? self : typeof window < "u" || typeof window < "u" ? window : {});

function As(e) {
    if (L(e)) {
        const t = {};
        for (let n = 0; n < e.length; n++) {
            const s = e[n],
                o = le(s) ? ir(s) : As(s);
            if (o)
                for (const i in o) t[i] = o[i]
        }
        return t
    } else if (le(e) || ee(e)) return e
}
const nr = /;(?![^(]*\))/g,
    sr = /:([^]+)/,
    or = /\/\*[^]*?\*\//g;

function ir(e) {
    const t = {};
    return e.replace(or, "").split(nr).forEach(n => {
        if (n) {
            const s = n.split(sr);
            s.length > 1 && (t[s[0].trim()] = s[1].trim())
        }
    }), t
}

function Ie(e) {
    let t = "";
    if (le(e)) t = e;
    else if (L(e))
        for (let n = 0; n < e.length; n++) {
            const s = Ie(e[n]);
            s && (t += s + " ")
        } else if (ee(e))
            for (const n in e) e[n] && (t += n + " ");
    return t.trim()
}
const rr = "itemscope,allowfullscreen,formnovalidate,ismap,nomodule,novalidate,readonly",
    cr = Ts(rr);

function qo(e) {
    return !!e || e === ""
}
const J = e => le(e) ? e : e == null ? "" : L(e) || ee(e) && (e.toString === Vo || !R(e.toString)) ? JSON.stringify(e, Go, 2) : String(e),
    Go = (e, t) => t && t.__v_isRef ? Go(e, t.value) : Tt(t) ? {
        [`Map(${t.size})`]: [...t.entries()].reduce((n, [s, o], i) => (n[Zn(s, i) + " =>"] = o, n), {})
    } : Do(t) ? {
        [`Set(${t.size})`]: [...t.values()].map(n => Zn(n))
    } : At(t) ? Zn(t) : ee(t) && !L(t) && !Uo(t) ? String(t) : t,
    Zn = (e, t = "") => {
        var n;
        return At(e) ? `Symbol(${(n=e.description)!=null?n:t})` : e
    };
/**
 * @vue/reactivity v3.4.21
 * (c) 2018-present Yuxi (Evan) You and Vue contributors
 * @license MIT
 **/
let Ce;
class Wo {
    constructor(t = !1) {
        this.detached = t, this._active = !0, this.effects = [], this.cleanups = [], this.parent = Ce, !t && Ce && (this.index = (Ce.scopes || (Ce.scopes = [])).push(this) - 1)
    }
    get active() {
        return this._active
    }
    run(t) {
        if (this._active) {
            const n = Ce;
            try {
                return Ce = this, t()
            } finally {
                Ce = n
            }
        }
    }
    on() {
        Ce = this
    }
    off() {
        Ce = this.parent
    }
    stop(t) {
        if (this._active) {
            let n, s;
            for (n = 0, s = this.effects.length; n < s; n++) this.effects[n].stop();
            for (n = 0, s = this.cleanups.length; n < s; n++) this.cleanups[n]();
            if (this.scopes)
                for (n = 0, s = this.scopes.length; n < s; n++) this.scopes[n].stop(!0);
            if (!this.detached && this.parent && !t) {
                const o = this.parent.scopes.pop();
                o && o !== this && (this.parent.scopes[this.index] = o, o.index = this.index)
            }
            this.parent = void 0, this._active = !1
        }
    }
}

function zo(e) {
    return new Wo(e)
}

function lr(e, t = Ce) {
    t && t.active && t.effects.push(e)
}

function Jo() {
    return Ce
}

function ar(e) {
    Ce && Ce.cleanups.push(e)
}
let mt;
class Ns {
    constructor(t, n, s, o) {
        this.fn = t, this.trigger = n, this.scheduler = s, this.active = !0, this.deps = [], this._dirtyLevel = 4, this._trackId = 0, this._runnings = 0, this._shouldSchedule = !1, this._depsLength = 0, lr(this, o)
    }
    get dirty() {
        if (this._dirtyLevel === 2 || this._dirtyLevel === 3) {
            this._dirtyLevel = 1, bt();
            for (let t = 0; t < this._depsLength; t++) {
                const n = this.deps[t];
                if (n.computed && (ur(n.computed), this._dirtyLevel >= 4)) break
            }
            this._dirtyLevel === 1 && (this._dirtyLevel = 0), yt()
        }
        return this._dirtyLevel >= 4
    }
    set dirty(t) {
        this._dirtyLevel = t ? 4 : 0
    }
    run() {
        if (this._dirtyLevel = 0, !this.active) return this.fn();
        let t = st,
            n = mt;
        try {
            return st = !0, mt = this, this._runnings++, Zs(this), this.fn()
        } finally {
            Xs(this), this._runnings--, mt = n, st = t
        }
    }
    stop() {
        var t;
        this.active && (Zs(this), Xs(this), (t = this.onStop) == null || t.call(this), this.active = !1)
    }
}

function ur(e) {
    return e.value
}

function Zs(e) {
    e._trackId++, e._depsLength = 0
}

function Xs(e) {
    if (e.deps.length > e._depsLength) {
        for (let t = e._depsLength; t < e.deps.length; t++) Yo(e.deps[t], e);
        e.deps.length = e._depsLength
    }
}

function Yo(e, t) {
    const n = e.get(t);
    n !== void 0 && t._trackId !== n && (e.delete(t), e.size === 0 && e.cleanup())
}
let st = !0,
    ls = 0;
const Zo = [];

function bt() {
    Zo.push(st), st = !1
}

function yt() {
    const e = Zo.pop();
    st = e === void 0 ? !0 : e
}

function Ps() {
    ls++
}

function Ls() {
    for (ls--; !ls && as.length;) as.shift()()
}

function Xo(e, t, n) {
    if (t.get(e) !== e._trackId) {
        t.set(e, e._trackId);
        const s = e.deps[e._depsLength];
        s !== t ? (s && Yo(s, e), e.deps[e._depsLength++] = t) : e._depsLength++
    }
}
const as = [];

function Qo(e, t, n) {
    Ps();
    for (const s of e.keys()) {
        let o;
        s._dirtyLevel < t && (o ?? (o = e.get(s) === s._trackId)) && (s._shouldSchedule || (s._shouldSchedule = s._dirtyLevel === 0), s._dirtyLevel = t), s._shouldSchedule && (o ?? (o = e.get(s) === s._trackId)) && (s.trigger(), (!s._runnings || s.allowRecurse) && s._dirtyLevel !== 2 && (s._shouldSchedule = !1, s.scheduler && as.push(s.scheduler)))
    }
    Ls()
}
const ei = (e, t) => {
        const n = new Map;
        return n.cleanup = e, n.computed = t, n
    },
    yn = new WeakMap,
    gt = Symbol(""),
    us = Symbol("");

function $e(e, t, n) {
    if (st && mt) {
        let s = yn.get(e);
        s || yn.set(e, s = new Map);
        let o = s.get(n);
        o || s.set(n, o = ei(() => s.delete(n))), Xo(mt, o)
    }
}

function qe(e, t, n, s, o, i) {
    const r = yn.get(e);
    if (!r) return;
    let c = [];
    if (t === "clear") c = [...r.values()];
    else if (n === "length" && L(e)) {
        const l = Number(s);
        r.forEach((f, d) => {
            (d === "length" || !At(d) && d >= l) && c.push(f)
        })
    } else switch (n !== void 0 && c.push(r.get(n)), t) {
        case "add":
            L(e) ? Ms(n) && c.push(r.get("length")) : (c.push(r.get(gt)), Tt(e) && c.push(r.get(us)));
            break;
        case "delete":
            L(e) || (c.push(r.get(gt)), Tt(e) && c.push(r.get(us)));
            break;
        case "set":
            Tt(e) && c.push(r.get(gt));
            break
    }
    Ps();
    for (const l of c) l && Qo(l, 4);
    Ls()
}

function fr(e, t) {
    var n;
    return (n = yn.get(e)) == null ? void 0 : n.get(t)
}
const dr = Ts("__proto__,__v_isRef,__isVue"),
    ti = new Set(Object.getOwnPropertyNames(Symbol).filter(e => e !== "arguments" && e !== "caller").map(e => Symbol[e]).filter(At)),
    Qs = hr();

function hr() {
    const e = {};
    return ["includes", "indexOf", "lastIndexOf"].forEach(t => {
        e[t] = function(...n) {
            const s = K(this);
            for (let i = 0, r = this.length; i < r; i++) $e(s, "get", i + "");
            const o = s[t](...n);
            return o === -1 || o === !1 ? s[t](...n.map(K)) : o
        }
    }), ["push", "pop", "shift", "unshift", "splice"].forEach(t => {
        e[t] = function(...n) {
            bt(), Ps();
            const s = K(this)[t].apply(this, n);
            return Ls(), yt(), s
        }
    }), e
}

function pr(e) {
    const t = K(this);
    return $e(t, "has", e), t.hasOwnProperty(e)
}
class ni {
    constructor(t = !1, n = !1) {
        this._isReadonly = t, this._isShallow = n
    }
    get(t, n, s) {
        const o = this._isReadonly,
            i = this._isShallow;
        if (n === "__v_isReactive") return !o;
        if (n === "__v_isReadonly") return o;
        if (n === "__v_isShallow") return i;
        if (n === "__v_raw") return s === (o ? i ? Ir : ri : i ? ii : oi).get(t) || Object.getPrototypeOf(t) === Object.getPrototypeOf(s) ? t : void 0;
        const r = L(t);
        if (!o) {
            if (r && q(Qs, n)) return Reflect.get(Qs, n, s);
            if (n === "hasOwnProperty") return pr
        }
        const c = Reflect.get(t, n, s);
        return (At(n) ? ti.has(n) : dr(n)) || (o || $e(t, "get", n), i) ? c : ae(c) ? r && Ms(n) ? c : c.value : ee(c) ? o ? ci(c) : Nn(c) : c
    }
}
class si extends ni {
    constructor(t = !1) {
        super(!1, t)
    }
    set(t, n, s, o) {
        let i = t[n];
        if (!this._isShallow) {
            const l = Mt(i);
            if (!xn(s) && !Mt(s) && (i = K(i), s = K(s)), !L(t) && ae(i) && !ae(s)) return l ? !1 : (i.value = s, !0)
        }
        const r = L(t) && Ms(n) ? Number(n) < t.length : q(t, n),
            c = Reflect.set(t, n, s, o);
        return t === K(o) && (r ? it(s, i) && qe(t, "set", n, s) : qe(t, "add", n, s)), c
    }
    deleteProperty(t, n) {
        const s = q(t, n);
        t[n];
        const o = Reflect.deleteProperty(t, n);
        return o && s && qe(t, "delete", n, void 0), o
    }
    has(t, n) {
        const s = Reflect.has(t, n);
        return (!At(n) || !ti.has(n)) && $e(t, "has", n), s
    }
    ownKeys(t) {
        return $e(t, "iterate", L(t) ? "length" : gt), Reflect.ownKeys(t)
    }
}
class _r extends ni {
    constructor(t = !1) {
        super(!0, t)
    }
    set(t, n) {
        return !0
    }
    deleteProperty(t, n) {
        return !0
    }
}
const mr = new si,
    gr = new _r,
    vr = new si(!0),
    Os = e => e,
    An = e => Reflect.getPrototypeOf(e);

function on(e, t, n = !1, s = !1) {
    e = e.__v_raw;
    const o = K(e),
        i = K(t);
    n || (it(t, i) && $e(o, "get", t), $e(o, "get", i));
    const {
        has: r
    } = An(o), c = s ? Os : n ? ks : qt;
    if (r.call(o, t)) return c(e.get(t));
    if (r.call(o, i)) return c(e.get(i));
    e !== o && e.get(t)
}

function rn(e, t = !1) {
    const n = this.__v_raw,
        s = K(n),
        o = K(e);
    return t || (it(e, o) && $e(s, "has", e), $e(s, "has", o)), e === o ? n.has(e) : n.has(e) || n.has(o)
}

function cn(e, t = !1) {
    return e = e.__v_raw, !t && $e(K(e), "iterate", gt), Reflect.get(e, "size", e)
}

function eo(e) {
    e = K(e);
    const t = K(this);
    return An(t).has.call(t, e) || (t.add(e), qe(t, "add", e, e)), this
}

function to(e, t) {
    t = K(t);
    const n = K(this),
        {
            has: s,
            get: o
        } = An(n);
    let i = s.call(n, e);
    i || (e = K(e), i = s.call(n, e));
    const r = o.call(n, e);
    return n.set(e, t), i ? it(t, r) && qe(n, "set", e, t) : qe(n, "add", e, t), this
}

function no(e) {
    const t = K(this),
        {
            has: n,
            get: s
        } = An(t);
    let o = n.call(t, e);
    o || (e = K(e), o = n.call(t, e)), s && s.call(t, e);
    const i = t.delete(e);
    return o && qe(t, "delete", e, void 0), i
}

function so() {
    const e = K(this),
        t = e.size !== 0,
        n = e.clear();
    return t && qe(e, "clear", void 0, void 0), n
}

function ln(e, t) {
    return function(s, o) {
        const i = this,
            r = i.__v_raw,
            c = K(r),
            l = t ? Os : e ? ks : qt;
        return !e && $e(c, "iterate", gt), r.forEach((f, d) => s.call(o, l(f), l(d), i))
    }
}

function an(e, t, n) {
    return function(...s) {
        const o = this.__v_raw,
            i = K(o),
            r = Tt(i),
            c = e === "entries" || e === Symbol.iterator && r,
            l = e === "keys" && r,
            f = o[e](...s),
            d = n ? Os : t ? ks : qt;
        return !t && $e(i, "iterate", l ? us : gt), {
            next() {
                const {
                    value: p,
                    done: m
                } = f.next();
                return m ? {
                    value: p,
                    done: m
                } : {
                    value: c ? [d(p[0]), d(p[1])] : d(p),
                    done: m
                }
            },
            [Symbol.iterator]() {
                return this
            }
        }
    }
}

function Je(e) {
    return function(...t) {
        return e === "delete" ? !1 : e === "clear" ? void 0 : this
    }
}

function br() {
    const e = {
            get(i) {
                return on(this, i)
            },
            get size() {
                return cn(this)
            },
            has: rn,
            add: eo,
            set: to,
            delete: no,
            clear: so,
            forEach: ln(!1, !1)
        },
        t = {
            get(i) {
                return on(this, i, !1, !0)
            },
            get size() {
                return cn(this)
            },
            has: rn,
            add: eo,
            set: to,
            delete: no,
            clear: so,
            forEach: ln(!1, !0)
        },
        n = {
            get(i) {
                return on(this, i, !0)
            },
            get size() {
                return cn(this, !0)
            },
            has(i) {
                return rn.call(this, i, !0)
            },
            add: Je("add"),
            set: Je("set"),
            delete: Je("delete"),
            clear: Je("clear"),
            forEach: ln(!0, !1)
        },
        s = {
            get(i) {
                return on(this, i, !0, !0)
            },
            get size() {
                return cn(this, !0)
            },
            has(i) {
                return rn.call(this, i, !0)
            },
            add: Je("add"),
            set: Je("set"),
            delete: Je("delete"),
            clear: Je("clear"),
            forEach: ln(!0, !0)
        };
    return ["keys", "values", "entries", Symbol.iterator].forEach(i => {
        e[i] = an(i, !1, !1), n[i] = an(i, !0, !1), t[i] = an(i, !1, !0), s[i] = an(i, !0, !0)
    }), [e, n, t, s]
}
const [yr, xr, $r, Sr] = br();

function Fs(e, t) {
    const n = t ? e ? Sr : $r : e ? xr : yr;
    return (s, o, i) => o === "__v_isReactive" ? !e : o === "__v_isReadonly" ? e : o === "__v_raw" ? s : Reflect.get(q(n, o) && o in s ? n : s, o, i)
}
const Cr = {
        get: Fs(!1, !1)
    },
    wr = {
        get: Fs(!1, !0)
    },
    Tr = {
        get: Fs(!0, !1)
    },
    oi = new WeakMap,
    ii = new WeakMap,
    ri = new WeakMap,
    Ir = new WeakMap;

function Er(e) {
    switch (e) {
        case "Object":
        case "Array":
            return 1;
        case "Map":
        case "Set":
        case "WeakMap":
        case "WeakSet":
            return 2;
        default:
            return 0
    }
}

function Mr(e) {
    return e.__v_skip || !Object.isExtensible(e) ? 0 : Er(Xi(e))
}

function Nn(e) {
    return Mt(e) ? e : Rs(e, !1, mr, Cr, oi)
}

function Ar(e) {
    return Rs(e, !1, vr, wr, ii)
}

function ci(e) {
    return Rs(e, !0, gr, Tr, ri)
}

function Rs(e, t, n, s, o) {
    if (!ee(e) || e.__v_raw && !(t && e.__v_isReactive)) return e;
    const i = o.get(e);
    if (i) return i;
    const r = Mr(e);
    if (r === 0) return e;
    const c = new Proxy(e, r === 2 ? s : n);
    return o.set(e, c), c
}

function Ge(e) {
    return Mt(e) ? Ge(e.__v_raw) : !!(e && e.__v_isReactive)
}

function Mt(e) {
    return !!(e && e.__v_isReadonly)
}

function xn(e) {
    return !!(e && e.__v_isShallow)
}

function li(e) {
    return Ge(e) || Mt(e)
}

function K(e) {
    const t = e && e.__v_raw;
    return t ? K(t) : e
}

function Pn(e) {
    return Object.isExtensible(e) && bn(e, "__v_skip", !0), e
}
const qt = e => ee(e) ? Nn(e) : e,
    ks = e => ee(e) ? ci(e) : e;
class ai {
    constructor(t, n, s, o) {
        this.getter = t, this._setter = n, this.dep = void 0, this.__v_isRef = !0, this.__v_isReadonly = !1, this.effect = new Ns(() => t(this._value), () => pn(this, this.effect._dirtyLevel === 2 ? 2 : 3)), this.effect.computed = this, this.effect.active = this._cacheable = !o, this.__v_isReadonly = s
    }
    get value() {
        const t = K(this);
        return (!t._cacheable || t.effect.dirty) && it(t._value, t._value = t.effect.run()) && pn(t, 4), ui(t), t.effect._dirtyLevel >= 2 && pn(t, 2), t._value
    }
    set value(t) {
        this._setter(t)
    }
    get _dirty() {
        return this.effect.dirty
    }
    set _dirty(t) {
        this.effect.dirty = t
    }
}

function Nr(e, t, n = !1) {
    let s, o;
    const i = R(e);
    return i ? (s = e, o = Te) : (s = e.get, o = e.set), new ai(s, o, i || !o, n)
}

function ui(e) {
    var t;
    st && mt && (e = K(e), Xo(mt, (t = e.dep) != null ? t : e.dep = ei(() => e.dep = void 0, e instanceof ai ? e : void 0)))
}

function pn(e, t = 4, n) {
    e = K(e);
    const s = e.dep;
    s && Qo(s, t)
}

function ae(e) {
    return !!(e && e.__v_isRef === !0)
}

function ie(e) {
    return Pr(e, !1)
}

function Pr(e, t) {
    return ae(e) ? e : new Lr(e, t)
}
class Lr {
    constructor(t, n) {
        this.__v_isShallow = n, this.dep = void 0, this.__v_isRef = !0, this._rawValue = n ? t : K(t), this._value = n ? t : qt(t)
    }
    get value() {
        return ui(this), this._value
    }
    set value(t) {
        const n = this.__v_isShallow || xn(t) || Mt(t);
        t = n ? t : K(t), it(t, this._rawValue) && (this._rawValue = t, this._value = n ? t : qt(t), pn(this, 4))
    }
}

function k(e) {
    return ae(e) ? e.value : e
}
const Or = {
    get: (e, t, n) => k(Reflect.get(e, t, n)),
    set: (e, t, n, s) => {
        const o = e[t];
        return ae(o) && !ae(n) ? (o.value = n, !0) : Reflect.set(e, t, n, s)
    }
};

function fi(e) {
    return Ge(e) ? e : new Proxy(e, Or)
}

function Fr(e) {
    const t = L(e) ? new Array(e.length) : {};
    for (const n in e) t[n] = di(e, n);
    return t
}
class Rr {
    constructor(t, n, s) {
        this._object = t, this._key = n, this._defaultValue = s, this.__v_isRef = !0
    }
    get value() {
        const t = this._object[this._key];
        return t === void 0 ? this._defaultValue : t
    }
    set value(t) {
        this._object[this._key] = t
    }
    get dep() {
        return fr(K(this._object), this._key)
    }
}
class kr {
    constructor(t) {
        this._getter = t, this.__v_isRef = !0, this.__v_isReadonly = !0
    }
    get value() {
        return this._getter()
    }
}

function Hr(e, t, n) {
    return ae(e) ? e : R(e) ? new kr(e) : ee(e) && arguments.length > 1 ? di(e, t, n) : ie(e)
}

function di(e, t, n) {
    const s = e[t];
    return ae(s) ? s : new Rr(e, t, n)
}
/**
 * @vue/runtime-core v3.4.21
 * (c) 2018-present Yuxi (Evan) You and Vue contributors
 * @license MIT
 **/
function ot(e, t, n, s) {
    try {
        return s ? e(...s) : e()
    } catch (o) {
        Ln(o, t, n)
    }
}

function Ee(e, t, n, s) {
    if (R(e)) {
        const i = ot(e, t, n, s);
        return i && Bo(i) && i.catch(r => {
            Ln(r, t, n)
        }), i
    }
    const o = [];
    for (let i = 0; i < e.length; i++) o.push(Ee(e[i], t, n, s));
    return o
}

function Ln(e, t, n, s = !0) {
    const o = t ? t.vnode : null;
    if (t) {
        let i = t.parent;
        const r = t.proxy,
            c = `https://vuejs.org/error-reference/#runtime-${n}`;
        for (; i;) {
            const f = i.ec;
            if (f) {
                for (let d = 0; d < f.length; d++)
                    if (f[d](e, r, c) === !1) return
            }
            i = i.parent
        }
        const l = t.appContext.config.errorHandler;
        if (l) {
            ot(l, null, 10, [e, r, c]);
            return
        }
    }
    jr(e, n, o, s)
}

function jr(e, t, n, s = !0) {
    console.error(e)
}
let Gt = !1,
    fs = !1;
const pe = [];
let Be = 0;
const It = [];
let Qe = null,
    ht = 0;
const hi = Promise.resolve();
let Hs = null;

function pi(e) {
    const t = Hs || hi;
    return e ? t.then(this ? e.bind(this) : e) : t
}

function Dr(e) {
    let t = Be + 1,
        n = pe.length;
    for (; t < n;) {
        const s = t + n >>> 1,
            o = pe[s],
            i = Wt(o);
        i < e || i === e && o.pre ? t = s + 1 : n = s
    }
    return t
}

function js(e) {
    (!pe.length || !pe.includes(e, Gt && e.allowRecurse ? Be + 1 : Be)) && (e.id == null ? pe.push(e) : pe.splice(Dr(e.id), 0, e), _i())
}

function _i() {
    !Gt && !fs && (fs = !0, Hs = hi.then(gi))
}

function Br(e) {
    const t = pe.indexOf(e);
    t > Be && pe.splice(t, 1)
}

function Vr(e) {
    L(e) ? It.push(...e) : (!Qe || !Qe.includes(e, e.allowRecurse ? ht + 1 : ht)) && It.push(e), _i()
}

function oo(e, t, n = Gt ? Be + 1 : 0) {
    for (; n < pe.length; n++) {
        const s = pe[n];
        if (s && s.pre) {
            if (e && s.id !== e.uid) continue;
            pe.splice(n, 1), n--, s()
        }
    }
}

function mi(e) {
    if (It.length) {
        const t = [...new Set(It)].sort((n, s) => Wt(n) - Wt(s));
        if (It.length = 0, Qe) {
            Qe.push(...t);
            return
        }
        for (Qe = t, ht = 0; ht < Qe.length; ht++) Qe[ht]();
        Qe = null, ht = 0
    }
}
const Wt = e => e.id == null ? 1 / 0 : e.id,
    Ur = (e, t) => {
        const n = Wt(e) - Wt(t);
        if (n === 0) {
            if (e.pre && !t.pre) return -1;
            if (t.pre && !e.pre) return 1
        }
        return n
    };

function gi(e) {
    fs = !1, Gt = !0, pe.sort(Ur);
    try {
        for (Be = 0; Be < pe.length; Be++) {
            const t = pe[Be];
            t && t.active !== !1 && ot(t, null, 14)
        }
    } finally {
        Be = 0, pe.length = 0, mi(), Gt = !1, Hs = null, (pe.length || It.length) && gi()
    }
}

function Kr(e, t, ...n) {
    if (e.isUnmounted) return;
    const s = e.vnode.props || ne;
    let o = n;
    const i = t.startsWith("update:"),
        r = i && t.slice(7);
    if (r && r in s) {
        const d = `${r==="modelValue"?"model":r}Modifiers`,
            {
                number: p,
                trim: m
            } = s[d] || ne;
        m && (o = n.map(S => le(S) ? S.trim() : S)), p && (o = n.map(cs))
    }
    let c, l = s[c = Yn(t)] || s[c = Yn(Ue(t))];
    !l && i && (l = s[c = Yn(Nt(t))]), l && Ee(l, e, 6, o);
    const f = s[c + "Once"];
    if (f) {
        if (!e.emitted) e.emitted = {};
        else if (e.emitted[c]) return;
        e.emitted[c] = !0, Ee(f, e, 6, o)
    }
}

function vi(e, t, n = !1) {
    const s = t.emitsCache,
        o = s.get(e);
    if (o !== void 0) return o;
    const i = e.emits;
    let r = {},
        c = !1;
    if (!R(e)) {
        const l = f => {
            const d = vi(f, t, !0);
            d && (c = !0, he(r, d))
        };
        !n && t.mixins.length && t.mixins.forEach(l), e.extends && l(e.extends), e.mixins && e.mixins.forEach(l)
    }
    return !i && !c ? (ee(e) && s.set(e, null), null) : (L(i) ? i.forEach(l => r[l] = null) : he(r, i), ee(e) && s.set(e, r), r)
}

function On(e, t) {
    return !e || !Tn(t) ? !1 : (t = t.slice(2).replace(/Once$/, ""), q(e, t[0].toLowerCase() + t.slice(1)) || q(e, Nt(t)) || q(e, t))
}
let _e = null,
    Fn = null;

function $n(e) {
    const t = _e;
    return _e = e, Fn = e && e.type.__scopeId || null, t
}

function Oe(e) {
    Fn = e
}

function Fe() {
    Fn = null
}

function Yt(e, t = _e, n) {
    if (!t || e._n) return e;
    const s = (...o) => {
        s._d && go(-1);
        const i = $n(t);
        let r;
        try {
            r = e(...o)
        } finally {
            $n(i), s._d && go(1)
        }
        return r
    };
    return s._n = !0, s._c = !0, s._d = !0, s
}

function Xn(e) {
    const {
        type: t,
        vnode: n,
        proxy: s,
        withProxy: o,
        props: i,
        propsOptions: [r],
        slots: c,
        attrs: l,
        emit: f,
        render: d,
        renderCache: p,
        data: m,
        setupState: S,
        ctx: N,
        inheritAttrs: O
    } = e;
    let W, z;
    const ue = $n(e);
    try {
        if (n.shapeFlag & 4) {
            const M = o || s,
                U = M;
            W = De(d.call(U, M, p, i, S, m, N)), z = l
        } else {
            const M = t;
            W = De(M.length > 1 ? M(i, {
                attrs: l,
                slots: c,
                emit: f
            }) : M(i, null)), z = t.props ? l : qr(l)
        }
    } catch (M) {
        Vt.length = 0, Ln(M, e, 1), W = Z(Pe)
    }
    let D = W;
    if (z && O !== !1) {
        const M = Object.keys(z),
            {
                shapeFlag: U
            } = D;
        M.length && U & 7 && (r && M.some(Is) && (z = Gr(z, r)), D = rt(D, z))
    }
    return n.dirs && (D = rt(D), D.dirs = D.dirs ? D.dirs.concat(n.dirs) : n.dirs), n.transition && (D.transition = n.transition), W = D, $n(ue), W
}
const qr = e => {
        let t;
        for (const n in e)(n === "class" || n === "style" || Tn(n)) && ((t || (t = {}))[n] = e[n]);
        return t
    },
    Gr = (e, t) => {
        const n = {};
        for (const s in e)(!Is(s) || !(s.slice(9) in t)) && (n[s] = e[s]);
        return n
    };

function Wr(e, t, n) {
    const {
        props: s,
        children: o,
        component: i
    } = e, {
        props: r,
        children: c,
        patchFlag: l
    } = t, f = i.emitsOptions;
    if (t.dirs || t.transition) return !0;
    if (n && l >= 0) {
        if (l & 1024) return !0;
        if (l & 16) return s ? io(s, r, f) : !!r;
        if (l & 8) {
            const d = t.dynamicProps;
            for (let p = 0; p < d.length; p++) {
                const m = d[p];
                if (r[m] !== s[m] && !On(f, m)) return !0
            }
        }
    } else return (o || c) && (!c || !c.$stable) ? !0 : s === r ? !1 : s ? r ? io(s, r, f) : !0 : !!r;
    return !1
}

function io(e, t, n) {
    const s = Object.keys(t);
    if (s.length !== Object.keys(e).length) return !0;
    for (let o = 0; o < s.length; o++) {
        const i = s[o];
        if (t[i] !== e[i] && !On(n, i)) return !0
    }
    return !1
}

function zr({
    vnode: e,
    parent: t
}, n) {
    for (; t;) {
        const s = t.subTree;
        if (s.suspense && s.suspense.activeBranch === e && (s.el = e.el), s === e)(e = t.vnode).el = n, t = t.parent;
        else break
    }
}
const bi = "components",
    yi = Symbol.for("v-ndc");

function vt(e) {
    return le(e) ? Jr(bi, e, !1) || e : e || yi
}

function Jr(e, t, n = !0, s = !1) {
    const o = _e || de;
    if (o) {
        const i = o.type;
        if (e === bi) {
            const c = Gc(i, !1);
            if (c && (c === t || c === Ue(t) || c === Mn(Ue(t)))) return i
        }
        const r = ro(o[e] || i[e], t) || ro(o.appContext[e], t);
        return !r && s ? i : r
    }
}

function ro(e, t) {
    return e && (e[t] || e[Ue(t)] || e[Mn(Ue(t))])
}
const Yr = e => e.__isSuspense;

function Zr(e, t) {
    t && t.pendingBranch ? L(e) ? t.effects.push(...e) : t.effects.push(e) : Vr(e)
}
const Xr = Symbol.for("v-scx"),
    Qr = () => Bt(Xr),
    un = {};

function _n(e, t, n) {
    return xi(e, t, n)
}

function xi(e, t, {
    immediate: n,
    deep: s,
    flush: o,
    once: i,
    onTrack: r,
    onTrigger: c
} = ne) {
    if (t && i) {
        const H = t;
        t = (...ce) => {
            H(...ce), U()
        }
    }
    const l = de,
        f = H => s === !0 ? H : _t(H, s === !1 ? 1 : void 0);
    let d, p = !1,
        m = !1;
    if (ae(e) ? (d = () => e.value, p = xn(e)) : Ge(e) ? (d = () => f(e), p = !0) : L(e) ? (m = !0, p = e.some(H => Ge(H) || xn(H)), d = () => e.map(H => {
            if (ae(H)) return H.value;
            if (Ge(H)) return f(H);
            if (R(H)) return ot(H, l, 2)
        })) : R(e) ? t ? d = () => ot(e, l, 2) : d = () => (S && S(), Ee(e, l, 3, [N])) : d = Te, t && s) {
        const H = d;
        d = () => _t(H())
    }
    let S, N = H => {
            S = D.onStop = () => {
                ot(H, l, 4), S = D.onStop = void 0
            }
        },
        O;
    if (Dn)
        if (N = Te, t ? n && Ee(t, l, 3, [d(), m ? [] : void 0, N]) : d(), o === "sync") {
            const H = Qr();
            O = H.__watcherHandles || (H.__watcherHandles = [])
        } else return Te;
    let W = m ? new Array(e.length).fill(un) : un;
    const z = () => {
        if (!(!D.active || !D.dirty))
            if (t) {
                const H = D.run();
                (s || p || (m ? H.some((ce, T) => it(ce, W[T])) : it(H, W))) && (S && S(), Ee(t, l, 3, [H, W === un ? void 0 : m && W[0] === un ? [] : W, N]), W = H)
            } else D.run()
    };
    z.allowRecurse = !!t;
    let ue;
    o === "sync" ? ue = z : o === "post" ? ue = () => ye(z, l && l.suspense) : (z.pre = !0, l && (z.id = l.uid), ue = () => js(z));
    const D = new Ns(d, Te, ue),
        M = Jo(),
        U = () => {
            D.stop(), M && Es(M.effects, D)
        };
    return t ? n ? z() : W = D.run() : o === "post" ? ye(D.run.bind(D), l && l.suspense) : D.run(), O && O.push(U), U
}

function ec(e, t, n) {
    const s = this.proxy,
        o = le(e) ? e.includes(".") ? $i(s, e) : () => s[e] : e.bind(s, s);
    let i;
    R(t) ? i = t : (i = t.handler, n = t);
    const r = Zt(this),
        c = xi(o, i.bind(s), n);
    return r(), c
}

function $i(e, t) {
    const n = t.split(".");
    return () => {
        let s = e;
        for (let o = 0; o < n.length && s; o++) s = s[n[o]];
        return s
    }
}

function _t(e, t, n = 0, s) {
    if (!ee(e) || e.__v_skip) return e;
    if (t && t > 0) {
        if (n >= t) return e;
        n++
    }
    if (s = s || new Set, s.has(e)) return e;
    if (s.add(e), ae(e)) _t(e.value, t, n, s);
    else if (L(e))
        for (let o = 0; o < e.length; o++) _t(e[o], t, n, s);
    else if (Do(e) || Tt(e)) e.forEach(o => {
        _t(o, t, n, s)
    });
    else if (Uo(e))
        for (const o in e) _t(e[o], t, n, s);
    return e
}

function jt(e, t) {
    if (_e === null) return e;
    const n = Bn(_e) || _e.proxy,
        s = e.dirs || (e.dirs = []);
    for (let o = 0; o < t.length; o++) {
        let [i, r, c, l = ne] = t[o];
        i && (R(i) && (i = {
            mounted: i,
            updated: i
        }), i.deep && _t(r), s.push({
            dir: i,
            instance: n,
            value: r,
            oldValue: void 0,
            arg: c,
            modifiers: l
        }))
    }
    return e
}

function at(e, t, n, s) {
    const o = e.dirs,
        i = t && t.dirs;
    for (let r = 0; r < o.length; r++) {
        const c = o[r];
        i && (c.oldValue = i[r].value);
        let l = c.dir[s];
        l && (bt(), Ee(l, n, 8, [e.el, c, e, t]), yt())
    }
}
const et = Symbol("_leaveCb"),
    fn = Symbol("_enterCb");

function tc() {
    const e = {
        isMounted: !1,
        isLeaving: !1,
        isUnmounting: !1,
        leavingVNodes: new Map
    };
    return Ds(() => {
        e.isMounted = !0
    }), Ii(() => {
        e.isUnmounting = !0
    }), e
}
const we = [Function, Array],
    Si = {
        mode: String,
        appear: Boolean,
        persisted: Boolean,
        onBeforeEnter: we,
        onEnter: we,
        onAfterEnter: we,
        onEnterCancelled: we,
        onBeforeLeave: we,
        onLeave: we,
        onAfterLeave: we,
        onLeaveCancelled: we,
        onBeforeAppear: we,
        onAppear: we,
        onAfterAppear: we,
        onAppearCancelled: we
    },
    nc = {
        name: "BaseTransition",
        props: Si,
        setup(e, {
            slots: t
        }) {
            const n = Bc(),
                s = tc();
            return () => {
                const o = t.default && wi(t.default(), !0);
                if (!o || !o.length) return;
                let i = o[0];
                if (o.length > 1) {
                    for (const m of o)
                        if (m.type !== Pe) {
                            i = m;
                            break
                        }
                }
                const r = K(e),
                    {
                        mode: c
                    } = r;
                if (s.isLeaving) return Qn(i);
                const l = co(i);
                if (!l) return Qn(i);
                const f = ds(l, r, s, n);
                hs(l, f);
                const d = n.subTree,
                    p = d && co(d);
                if (p && p.type !== Pe && !pt(l, p)) {
                    const m = ds(p, r, s, n);
                    if (hs(p, m), c === "out-in") return s.isLeaving = !0, m.afterLeave = () => {
                        s.isLeaving = !1, n.update.active !== !1 && (n.effect.dirty = !0, n.update())
                    }, Qn(i);
                    c === "in-out" && l.type !== Pe && (m.delayLeave = (S, N, O) => {
                        const W = Ci(s, p);
                        W[String(p.key)] = p, S[et] = () => {
                            N(), S[et] = void 0, delete f.delayedLeave
                        }, f.delayedLeave = O
                    })
                }
                return i
            }
        }
    },
    sc = nc;

function Ci(e, t) {
    const {
        leavingVNodes: n
    } = e;
    let s = n.get(t.type);
    return s || (s = Object.create(null), n.set(t.type, s)), s
}

function ds(e, t, n, s) {
    const {
        appear: o,
        mode: i,
        persisted: r = !1,
        onBeforeEnter: c,
        onEnter: l,
        onAfterEnter: f,
        onEnterCancelled: d,
        onBeforeLeave: p,
        onLeave: m,
        onAfterLeave: S,
        onLeaveCancelled: N,
        onBeforeAppear: O,
        onAppear: W,
        onAfterAppear: z,
        onAppearCancelled: ue
    } = t, D = String(e.key), M = Ci(n, e), U = (T, P) => {
        T && Ee(T, s, 9, P)
    }, H = (T, P) => {
        const B = P[1];
        U(T, P), L(T) ? T.every(se => se.length <= 1) && B() : T.length <= 1 && B()
    }, ce = {
        mode: i,
        persisted: r,
        beforeEnter(T) {
            let P = c;
            if (!n.isMounted)
                if (o) P = O || c;
                else return;
            T[et] && T[et](!0);
            const B = M[D];
            B && pt(e, B) && B.el[et] && B.el[et](), U(P, [T])
        },
        enter(T) {
            let P = l,
                B = f,
                se = d;
            if (!n.isMounted)
                if (o) P = W || l, B = z || f, se = ue || d;
                else return;
            let I = !1;
            const te = T[fn] = me => {
                I || (I = !0, me ? U(se, [T]) : U(B, [T]), ce.delayedLeave && ce.delayedLeave(), T[fn] = void 0)
            };
            P ? H(P, [T, te]) : te()
        },
        leave(T, P) {
            const B = String(e.key);
            if (T[fn] && T[fn](!0), n.isUnmounting) return P();
            U(p, [T]);
            let se = !1;
            const I = T[et] = te => {
                se || (se = !0, P(), te ? U(N, [T]) : U(S, [T]), T[et] = void 0, M[B] === e && delete M[B])
            };
            M[B] = e, m ? H(m, [T, I]) : I()
        },
        clone(T) {
            return ds(T, t, n, s)
        }
    };
    return ce
}

function Qn(e) {
    if (Rn(e)) return e = rt(e), e.children = null, e
}

function co(e) {
    return Rn(e) ? e.children ? e.children[0] : void 0 : e
}

function hs(e, t) {
    e.shapeFlag & 6 && e.component ? hs(e.component.subTree, t) : e.shapeFlag & 128 ? (e.ssContent.transition = t.clone(e.ssContent), e.ssFallback.transition = t.clone(e.ssFallback)) : e.transition = t
}

function wi(e, t = !1, n) {
    let s = [],
        o = 0;
    for (let i = 0; i < e.length; i++) {
        let r = e[i];
        const c = n == null ? r.key : String(n) + String(r.key != null ? r.key : i);
        r.type === xe ? (r.patchFlag & 128 && o++, s = s.concat(wi(r.children, t, c))) : (t || r.type !== Pe) && s.push(c != null ? rt(r, {
            key: c
        }) : r)
    }
    if (o > 1)
        for (let i = 0; i < s.length; i++) s[i].patchFlag = -2;
    return s
}
const mn = e => !!e.type.__asyncLoader,
    Rn = e => e.type.__isKeepAlive;

function oc(e, t) {
    Ti(e, "a", t)
}

function ic(e, t) {
    Ti(e, "da", t)
}

function Ti(e, t, n = de) {
    const s = e.__wdc || (e.__wdc = () => {
        let o = n;
        for (; o;) {
            if (o.isDeactivated) return;
            o = o.parent
        }
        return e()
    });
    if (kn(t, s, n), n) {
        let o = n.parent;
        for (; o && o.parent;) Rn(o.parent.vnode) && rc(s, t, n, o), o = o.parent
    }
}

function rc(e, t, n, s) {
    const o = kn(t, e, s, !0);
    Ei(() => {
        Es(s[t], o)
    }, n)
}

function kn(e, t, n = de, s = !1) {
    if (n) {
        const o = n[e] || (n[e] = []),
            i = t.__weh || (t.__weh = (...r) => {
                if (n.isUnmounted) return;
                bt();
                const c = Zt(n),
                    l = Ee(t, n, e, r);
                return c(), yt(), l
            });
        return s ? o.unshift(i) : o.push(i), i
    }
}
const We = e => (t, n = de) => (!Dn || e === "sp") && kn(e, (...s) => t(...s), n),
    cc = We("bm"),
    Ds = We("m"),
    lc = We("bu"),
    ac = We("u"),
    Ii = We("bum"),
    Ei = We("um"),
    uc = We("sp"),
    fc = We("rtg"),
    dc = We("rtc");

function hc(e, t = de) {
    kn("ec", e, t)
}

function Sn(e, t, n, s) {
    let o;
    const i = n && n[s];
    if (L(e) || le(e)) {
        o = new Array(e.length);
        for (let r = 0, c = e.length; r < c; r++) o[r] = t(e[r], r, void 0, i && i[r])
    } else if (typeof e == "number") {
        o = new Array(e);
        for (let r = 0; r < e; r++) o[r] = t(r + 1, r, void 0, i && i[r])
    } else if (ee(e))
        if (e[Symbol.iterator]) o = Array.from(e, (r, c) => t(r, c, void 0, i && i[c]));
        else {
            const r = Object.keys(e);
            o = new Array(r.length);
            for (let c = 0, l = r.length; c < l; c++) {
                const f = r[c];
                o[c] = t(e[f], f, c, i && i[c])
            }
        }
    else o = [];
    return n && (n[s] = o), o
}
const ps = e => e ? Di(e) ? Bn(e) || e.proxy : ps(e.parent) : null,
    Dt = he(Object.create(null), {
        $: e => e,
        $el: e => e.vnode.el,
        $data: e => e.data,
        $props: e => e.props,
        $attrs: e => e.attrs,
        $slots: e => e.slots,
        $refs: e => e.refs,
        $parent: e => ps(e.parent),
        $root: e => ps(e.root),
        $emit: e => e.emit,
        $options: e => Bs(e),
        $forceUpdate: e => e.f || (e.f = () => {
            e.effect.dirty = !0, js(e.update)
        }),
        $nextTick: e => e.n || (e.n = pi.bind(e.proxy)),
        $watch: e => ec.bind(e)
    }),
    es = (e, t) => e !== ne && !e.__isScriptSetup && q(e, t),
    pc = {
        get({
            _: e
        }, t) {
            const {
                ctx: n,
                setupState: s,
                data: o,
                props: i,
                accessCache: r,
                type: c,
                appContext: l
            } = e;
            let f;
            if (t[0] !== "$") {
                const S = r[t];
                if (S !== void 0) switch (S) {
                    case 1:
                        return s[t];
                    case 2:
                        return o[t];
                    case 4:
                        return n[t];
                    case 3:
                        return i[t]
                } else {
                    if (es(s, t)) return r[t] = 1, s[t];
                    if (o !== ne && q(o, t)) return r[t] = 2, o[t];
                    if ((f = e.propsOptions[0]) && q(f, t)) return r[t] = 3, i[t];
                    if (n !== ne && q(n, t)) return r[t] = 4, n[t];
                    _s && (r[t] = 0)
                }
            }
            const d = Dt[t];
            let p, m;
            if (d) return t === "$attrs" && $e(e, "get", t), d(e);
            if ((p = c.__cssModules) && (p = p[t])) return p;
            if (n !== ne && q(n, t)) return r[t] = 4, n[t];
            if (m = l.config.globalProperties, q(m, t)) return m[t]
        },
        set({
            _: e
        }, t, n) {
            const {
                data: s,
                setupState: o,
                ctx: i
            } = e;
            return es(o, t) ? (o[t] = n, !0) : s !== ne && q(s, t) ? (s[t] = n, !0) : q(e.props, t) || t[0] === "$" && t.slice(1) in e ? !1 : (i[t] = n, !0)
        },
        has({
            _: {
                data: e,
                setupState: t,
                accessCache: n,
                ctx: s,
                appContext: o,
                propsOptions: i
            }
        }, r) {
            let c;
            return !!n[r] || e !== ne && q(e, r) || es(t, r) || (c = i[0]) && q(c, r) || q(s, r) || q(Dt, r) || q(o.config.globalProperties, r)
        },
        defineProperty(e, t, n) {
            return n.get != null ? e._.accessCache[t] = 0 : q(n, "value") && this.set(e, t, n.value, null), Reflect.defineProperty(e, t, n)
        }
    };

function lo(e) {
    return L(e) ? e.reduce((t, n) => (t[n] = null, t), {}) : e
}
let _s = !0;

function _c(e) {
    const t = Bs(e),
        n = e.proxy,
        s = e.ctx;
    _s = !1, t.beforeCreate && ao(t.beforeCreate, e, "bc");
    const {
        data: o,
        computed: i,
        methods: r,
        watch: c,
        provide: l,
        inject: f,
        created: d,
        beforeMount: p,
        mounted: m,
        beforeUpdate: S,
        updated: N,
        activated: O,
        deactivated: W,
        beforeDestroy: z,
        beforeUnmount: ue,
        destroyed: D,
        unmounted: M,
        render: U,
        renderTracked: H,
        renderTriggered: ce,
        errorCaptured: T,
        serverPrefetch: P,
        expose: B,
        inheritAttrs: se,
        components: I,
        directives: te,
        filters: me
    } = t;
    if (f && mc(f, s, null), r)
        for (const re in r) {
            const Q = r[re];
            R(Q) && (s[re] = Q.bind(n))
        }
    if (o) {
        const re = o.call(n, n);
        ee(re) && (e.data = Nn(re))
    }
    if (_s = !0, i)
        for (const re in i) {
            const Q = i[re],
                ct = R(Q) ? Q.bind(n, n) : R(Q.get) ? Q.get.bind(n, n) : Te,
                nn = !R(Q) && R(Q.set) ? Q.set.bind(n) : Te,
                lt = Ve({
                    get: ct,
                    set: nn
                });
            Object.defineProperty(s, re, {
                enumerable: !0,
                configurable: !0,
                get: () => lt.value,
                set: ke => lt.value = ke
            })
        }
    if (c)
        for (const re in c) Mi(c[re], s, n, re);
    if (l) {
        const re = R(l) ? l.call(n) : l;
        Reflect.ownKeys(re).forEach(Q => {
            $c(Q, re[Q])
        })
    }
    d && ao(d, e, "c");

    function G(re, Q) {
        L(Q) ? Q.forEach(ct => re(ct.bind(n))) : Q && re(Q.bind(n))
    }
    if (G(cc, p), G(Ds, m), G(lc, S), G(ac, N), G(oc, O), G(ic, W), G(hc, T), G(dc, H), G(fc, ce), G(Ii, ue), G(Ei, M), G(uc, P), L(B))
        if (B.length) {
            const re = e.exposed || (e.exposed = {});
            B.forEach(Q => {
                Object.defineProperty(re, Q, {
                    get: () => n[Q],
                    set: ct => n[Q] = ct
                })
            })
        } else e.exposed || (e.exposed = {});
    U && e.render === Te && (e.render = U), se != null && (e.inheritAttrs = se), I && (e.components = I), te && (e.directives = te)
}

function mc(e, t, n = Te) {
    L(e) && (e = ms(e));
    for (const s in e) {
        const o = e[s];
        let i;
        ee(o) ? "default" in o ? i = Bt(o.from || s, o.default, !0) : i = Bt(o.from || s) : i = Bt(o), ae(i) ? Object.defineProperty(t, s, {
            enumerable: !0,
            configurable: !0,
            get: () => i.value,
            set: r => i.value = r
        }) : t[s] = i
    }
}

function ao(e, t, n) {
    Ee(L(e) ? e.map(s => s.bind(t.proxy)) : e.bind(t.proxy), t, n)
}

function Mi(e, t, n, s) {
    const o = s.includes(".") ? $i(n, s) : () => n[s];
    if (le(e)) {
        const i = t[e];
        R(i) && _n(o, i)
    } else if (R(e)) _n(o, e.bind(n));
    else if (ee(e))
        if (L(e)) e.forEach(i => Mi(i, t, n, s));
        else {
            const i = R(e.handler) ? e.handler.bind(n) : t[e.handler];
            R(i) && _n(o, i, e)
        }
}

function Bs(e) {
    const t = e.type,
        {
            mixins: n,
            extends: s
        } = t,
        {
            mixins: o,
            optionsCache: i,
            config: {
                optionMergeStrategies: r
            }
        } = e.appContext,
        c = i.get(t);
    let l;
    return c ? l = c : !o.length && !n && !s ? l = t : (l = {}, o.length && o.forEach(f => Cn(l, f, r, !0)), Cn(l, t, r)), ee(t) && i.set(t, l), l
}

function Cn(e, t, n, s = !1) {
    const {
        mixins: o,
        extends: i
    } = t;
    i && Cn(e, i, n, !0), o && o.forEach(r => Cn(e, r, n, !0));
    for (const r in t)
        if (!(s && r === "expose")) {
            const c = gc[r] || n && n[r];
            e[r] = c ? c(e[r], t[r]) : t[r]
        } return e
}
const gc = {
    data: uo,
    props: fo,
    emits: fo,
    methods: kt,
    computed: kt,
    beforeCreate: ge,
    created: ge,
    beforeMount: ge,
    mounted: ge,
    beforeUpdate: ge,
    updated: ge,
    beforeDestroy: ge,
    beforeUnmount: ge,
    destroyed: ge,
    unmounted: ge,
    activated: ge,
    deactivated: ge,
    errorCaptured: ge,
    serverPrefetch: ge,
    components: kt,
    directives: kt,
    watch: bc,
    provide: uo,
    inject: vc
};

function uo(e, t) {
    return t ? e ? function() {
        return he(R(e) ? e.call(this, this) : e, R(t) ? t.call(this, this) : t)
    } : t : e
}

function vc(e, t) {
    return kt(ms(e), ms(t))
}

function ms(e) {
    if (L(e)) {
        const t = {};
        for (let n = 0; n < e.length; n++) t[e[n]] = e[n];
        return t
    }
    return e
}

function ge(e, t) {
    return e ? [...new Set([].concat(e, t))] : t
}

function kt(e, t) {
    return e ? he(Object.create(null), e, t) : t
}

function fo(e, t) {
    return e ? L(e) && L(t) ? [...new Set([...e, ...t])] : he(Object.create(null), lo(e), lo(t ?? {})) : t
}

function bc(e, t) {
    if (!e) return t;
    if (!t) return e;
    const n = he(Object.create(null), e);
    for (const s in t) n[s] = ge(e[s], t[s]);
    return n
}

function Ai() {
    return {
        app: null,
        config: {
            isNativeTag: Yi,
            performance: !1,
            globalProperties: {},
            optionMergeStrategies: {},
            errorHandler: void 0,
            warnHandler: void 0,
            compilerOptions: {}
        },
        mixins: [],
        components: {},
        directives: {},
        provides: Object.create(null),
        optionsCache: new WeakMap,
        propsCache: new WeakMap,
        emitsCache: new WeakMap
    }
}
let yc = 0;

function xc(e, t) {
    return function(s, o = null) {
        R(s) || (s = he({}, s)), o != null && !ee(o) && (o = null);
        const i = Ai(),
            r = new WeakSet;
        let c = !1;
        const l = i.app = {
            _uid: yc++,
            _component: s,
            _props: o,
            _container: null,
            _context: i,
            _instance: null,
            version: zc,
            get config() {
                return i.config
            },
            set config(f) {},
            use(f, ...d) {
                return r.has(f) || (f && R(f.install) ? (r.add(f), f.install(l, ...d)) : R(f) && (r.add(f), f(l, ...d))), l
            },
            mixin(f) {
                return i.mixins.includes(f) || i.mixins.push(f), l
            },
            component(f, d) {
                return d ? (i.components[f] = d, l) : i.components[f]
            },
            directive(f, d) {
                return d ? (i.directives[f] = d, l) : i.directives[f]
            },
            mount(f, d, p) {
                if (!c) {
                    const m = Z(s, o);
                    return m.appContext = i, p === !0 ? p = "svg" : p === !1 && (p = void 0), d && t ? t(m, f) : e(m, f, p), c = !0, l._container = f, f.__vue_app__ = l, Bn(m.component) || m.component.proxy
                }
            },
            unmount() {
                c && (e(null, l._container), delete l._container.__vue_app__)
            },
            provide(f, d) {
                return i.provides[f] = d, l
            },
            runWithContext(f) {
                const d = Et;
                Et = l;
                try {
                    return f()
                } finally {
                    Et = d
                }
            }
        };
        return l
    }
}
let Et = null;

function $c(e, t) {
    if (de) {
        let n = de.provides;
        const s = de.parent && de.parent.provides;
        s === n && (n = de.provides = Object.create(s)), n[e] = t
    }
}

function Bt(e, t, n = !1) {
    const s = de || _e;
    if (s || Et) {
        const o = s ? s.parent == null ? s.vnode.appContext && s.vnode.appContext.provides : s.parent.provides : Et._context.provides;
        if (o && e in o) return o[e];
        if (arguments.length > 1) return n && R(t) ? t.call(s && s.proxy) : t
    }
}

function Sc() {
    return !!(de || _e || Et)
}

function Cc(e, t, n, s = !1) {
    const o = {},
        i = {};
    bn(i, jn, 1), e.propsDefaults = Object.create(null), Ni(e, t, o, i);
    for (const r in e.propsOptions[0]) r in o || (o[r] = void 0);
    n ? e.props = s ? o : Ar(o) : e.type.props ? e.props = o : e.props = i, e.attrs = i
}

function wc(e, t, n, s) {
    const {
        props: o,
        attrs: i,
        vnode: {
            patchFlag: r
        }
    } = e, c = K(o), [l] = e.propsOptions;
    let f = !1;
    if ((s || r > 0) && !(r & 16)) {
        if (r & 8) {
            const d = e.vnode.dynamicProps;
            for (let p = 0; p < d.length; p++) {
                let m = d[p];
                if (On(e.emitsOptions, m)) continue;
                const S = t[m];
                if (l)
                    if (q(i, m)) S !== i[m] && (i[m] = S, f = !0);
                    else {
                        const N = Ue(m);
                        o[N] = gs(l, c, N, S, e, !1)
                    }
                else S !== i[m] && (i[m] = S, f = !0)
            }
        }
    } else {
        Ni(e, t, o, i) && (f = !0);
        let d;
        for (const p in c)(!t || !q(t, p) && ((d = Nt(p)) === p || !q(t, d))) && (l ? n && (n[p] !== void 0 || n[d] !== void 0) && (o[p] = gs(l, c, p, void 0, e, !0)) : delete o[p]);
        if (i !== c)
            for (const p in i)(!t || !q(t, p)) && (delete i[p], f = !0)
    }
    f && qe(e, "set", "$attrs")
}

function Ni(e, t, n, s) {
    const [o, i] = e.propsOptions;
    let r = !1,
        c;
    if (t)
        for (let l in t) {
            if (Ht(l)) continue;
            const f = t[l];
            let d;
            o && q(o, d = Ue(l)) ? !i || !i.includes(d) ? n[d] = f : (c || (c = {}))[d] = f : On(e.emitsOptions, l) || (!(l in s) || f !== s[l]) && (s[l] = f, r = !0)
        }
    if (i) {
        const l = K(n),
            f = c || ne;
        for (let d = 0; d < i.length; d++) {
            const p = i[d];
            n[p] = gs(o, l, p, f[p], e, !q(f, p))
        }
    }
    return r
}

function gs(e, t, n, s, o, i) {
    const r = e[n];
    if (r != null) {
        const c = q(r, "default");
        if (c && s === void 0) {
            const l = r.default;
            if (r.type !== Function && !r.skipFactory && R(l)) {
                const {
                    propsDefaults: f
                } = o;
                if (n in f) s = f[n];
                else {
                    const d = Zt(o);
                    s = f[n] = l.call(null, t), d()
                }
            } else s = l
        }
        r[0] && (i && !c ? s = !1 : r[1] && (s === "" || s === Nt(n)) && (s = !0))
    }
    return s
}

function Pi(e, t, n = !1) {
    const s = t.propsCache,
        o = s.get(e);
    if (o) return o;
    const i = e.props,
        r = {},
        c = [];
    let l = !1;
    if (!R(e)) {
        const d = p => {
            l = !0;
            const [m, S] = Pi(p, t, !0);
            he(r, m), S && c.push(...S)
        };
        !n && t.mixins.length && t.mixins.forEach(d), e.extends && d(e.extends), e.mixins && e.mixins.forEach(d)
    }
    if (!i && !l) return ee(e) && s.set(e, wt), wt;
    if (L(i))
        for (let d = 0; d < i.length; d++) {
            const p = Ue(i[d]);
            ho(p) && (r[p] = ne)
        } else if (i)
            for (const d in i) {
                const p = Ue(d);
                if (ho(p)) {
                    const m = i[d],
                        S = r[p] = L(m) || R(m) ? {
                            type: m
                        } : he({}, m);
                    if (S) {
                        const N = mo(Boolean, S.type),
                            O = mo(String, S.type);
                        S[0] = N > -1, S[1] = O < 0 || N < O, (N > -1 || q(S, "default")) && c.push(p)
                    }
                }
            }
    const f = [r, c];
    return ee(e) && s.set(e, f), f
}

function ho(e) {
    return e[0] !== "$" && !Ht(e)
}

function po(e) {
    return e === null ? "null" : typeof e == "function" ? e.name || "" : typeof e == "object" && e.constructor && e.constructor.name || ""
}

function _o(e, t) {
    return po(e) === po(t)
}

function mo(e, t) {
    return L(t) ? t.findIndex(n => _o(n, e)) : R(t) && _o(t, e) ? 0 : -1
}
const Li = e => e[0] === "_" || e === "$stable",
    Vs = e => L(e) ? e.map(De) : [De(e)],
    Tc = (e, t, n) => {
        if (t._n) return t;
        const s = Yt((...o) => Vs(t(...o)), n);
        return s._c = !1, s
    },
    Oi = (e, t, n) => {
        const s = e._ctx;
        for (const o in e) {
            if (Li(o)) continue;
            const i = e[o];
            if (R(i)) t[o] = Tc(o, i, s);
            else if (i != null) {
                const r = Vs(i);
                t[o] = () => r
            }
        }
    },
    Fi = (e, t) => {
        const n = Vs(t);
        e.slots.default = () => n
    },
    Ic = (e, t) => {
        if (e.vnode.shapeFlag & 32) {
            const n = t._;
            n ? (e.slots = K(t), bn(t, "_", n)) : Oi(t, e.slots = {})
        } else e.slots = {}, t && Fi(e, t);
        bn(e.slots, jn, 1)
    },
    Ec = (e, t, n) => {
        const {
            vnode: s,
            slots: o
        } = e;
        let i = !0,
            r = ne;
        if (s.shapeFlag & 32) {
            const c = t._;
            c ? n && c === 1 ? i = !1 : (he(o, t), !n && c === 1 && delete o._) : (i = !t.$stable, Oi(t, o)), r = t
        } else t && (Fi(e, t), r = {
            default: 1
        });
        if (i)
            for (const c in o) !Li(c) && r[c] == null && delete o[c]
    };

function vs(e, t, n, s, o = !1) {
    if (L(e)) {
        e.forEach((m, S) => vs(m, t && (L(t) ? t[S] : t), n, s, o));
        return
    }
    if (mn(s) && !o) return;
    const i = s.shapeFlag & 4 ? Bn(s.component) || s.component.proxy : s.el,
        r = o ? null : i,
        {
            i: c,
            r: l
        } = e,
        f = t && t.r,
        d = c.refs === ne ? c.refs = {} : c.refs,
        p = c.setupState;
    if (f != null && f !== l && (le(f) ? (d[f] = null, q(p, f) && (p[f] = null)) : ae(f) && (f.value = null)), R(l)) ot(l, c, 12, [r, d]);
    else {
        const m = le(l),
            S = ae(l);
        if (m || S) {
            const N = () => {
                if (e.f) {
                    const O = m ? q(p, l) ? p[l] : d[l] : l.value;
                    o ? L(O) && Es(O, i) : L(O) ? O.includes(i) || O.push(i) : m ? (d[l] = [i], q(p, l) && (p[l] = d[l])) : (l.value = [i], e.k && (d[e.k] = l.value))
                } else m ? (d[l] = r, q(p, l) && (p[l] = r)) : S && (l.value = r, e.k && (d[e.k] = r))
            };
            r ? (N.id = -1, ye(N, n)) : N()
        }
    }
}
const ye = Zr;

function Mc(e) {
    return Ac(e)
}

function Ac(e, t) {
    const n = Ko();
    n.__VUE__ = !0;
    const {
        insert: s,
        remove: o,
        patchProp: i,
        createElement: r,
        createText: c,
        createComment: l,
        setText: f,
        setElementText: d,
        parentNode: p,
        nextSibling: m,
        setScopeId: S = Te,
        insertStaticContent: N
    } = e, O = (a, u, _, g = null, v = null, x = null, C = void 0, y = null, $ = !!u.dynamicChildren) => {
        if (a === u) return;
        a && !pt(a, u) && (g = sn(a), ke(a, v, x, !0), a = null), u.patchFlag === -2 && ($ = !1, u.dynamicChildren = null);
        const {
            type: b,
            ref: w,
            shapeFlag: A
        } = u;
        switch (b) {
            case Hn:
                W(a, u, _, g);
                break;
            case Pe:
                z(a, u, _, g);
                break;
            case ns:
                a == null && ue(u, _, g, C);
                break;
            case xe:
                I(a, u, _, g, v, x, C, y, $);
                break;
            default:
                A & 1 ? U(a, u, _, g, v, x, C, y, $) : A & 6 ? te(a, u, _, g, v, x, C, y, $) : (A & 64 || A & 128) && b.process(a, u, _, g, v, x, C, y, $, xt)
        }
        w != null && v && vs(w, a && a.ref, x, u || a, !u)
    }, W = (a, u, _, g) => {
        if (a == null) s(u.el = c(u.children), _, g);
        else {
            const v = u.el = a.el;
            u.children !== a.children && f(v, u.children)
        }
    }, z = (a, u, _, g) => {
        a == null ? s(u.el = l(u.children || ""), _, g) : u.el = a.el
    }, ue = (a, u, _, g) => {
        [a.el, a.anchor] = N(a.children, u, _, g, a.el, a.anchor)
    }, D = ({
        el: a,
        anchor: u
    }, _, g) => {
        let v;
        for (; a && a !== u;) v = m(a), s(a, _, g), a = v;
        s(u, _, g)
    }, M = ({
        el: a,
        anchor: u
    }) => {
        let _;
        for (; a && a !== u;) _ = m(a), o(a), a = _;
        o(u)
    }, U = (a, u, _, g, v, x, C, y, $) => {
        u.type === "svg" ? C = "svg" : u.type === "math" && (C = "mathml"), a == null ? H(u, _, g, v, x, C, y, $) : P(a, u, v, x, C, y, $)
    }, H = (a, u, _, g, v, x, C, y) => {
        let $, b;
        const {
            props: w,
            shapeFlag: A,
            transition: E,
            dirs: F
        } = a;
        if ($ = a.el = r(a.type, x, w && w.is, w), A & 8 ? d($, a.children) : A & 16 && T(a.children, $, null, g, v, ts(a, x), C, y), F && at(a, null, g, "created"), ce($, a, a.scopeId, C, g), w) {
            for (const Y in w) Y !== "value" && !Ht(Y) && i($, Y, null, w[Y], x, a.children, g, v, Ke);
            "value" in w && i($, "value", null, w.value, x), (b = w.onVnodeBeforeMount) && je(b, g, a)
        }
        F && at(a, null, g, "beforeMount");
        const V = Nc(v, E);
        V && E.beforeEnter($), s($, u, _), ((b = w && w.onVnodeMounted) || V || F) && ye(() => {
            b && je(b, g, a), V && E.enter($), F && at(a, null, g, "mounted")
        }, v)
    }, ce = (a, u, _, g, v) => {
        if (_ && S(a, _), g)
            for (let x = 0; x < g.length; x++) S(a, g[x]);
        if (v) {
            let x = v.subTree;
            if (u === x) {
                const C = v.vnode;
                ce(a, C, C.scopeId, C.slotScopeIds, v.parent)
            }
        }
    }, T = (a, u, _, g, v, x, C, y, $ = 0) => {
        for (let b = $; b < a.length; b++) {
            const w = a[b] = y ? tt(a[b]) : De(a[b]);
            O(null, w, u, _, g, v, x, C, y)
        }
    }, P = (a, u, _, g, v, x, C) => {
        const y = u.el = a.el;
        let {
            patchFlag: $,
            dynamicChildren: b,
            dirs: w
        } = u;
        $ |= a.patchFlag & 16;
        const A = a.props || ne,
            E = u.props || ne;
        let F;
        if (_ && ut(_, !1), (F = E.onVnodeBeforeUpdate) && je(F, _, u, a), w && at(u, a, _, "beforeUpdate"), _ && ut(_, !0), b ? B(a.dynamicChildren, b, y, _, g, ts(u, v), x) : C || Q(a, u, y, null, _, g, ts(u, v), x, !1), $ > 0) {
            if ($ & 16) se(y, u, A, E, _, g, v);
            else if ($ & 2 && A.class !== E.class && i(y, "class", null, E.class, v), $ & 4 && i(y, "style", A.style, E.style, v), $ & 8) {
                const V = u.dynamicProps;
                for (let Y = 0; Y < V.length; Y++) {
                    const oe = V[Y],
                        fe = A[oe],
                        Ae = E[oe];
                    (Ae !== fe || oe === "value") && i(y, oe, fe, Ae, v, a.children, _, g, Ke)
                }
            }
            $ & 1 && a.children !== u.children && d(y, u.children)
        } else !C && b == null && se(y, u, A, E, _, g, v);
        ((F = E.onVnodeUpdated) || w) && ye(() => {
            F && je(F, _, u, a), w && at(u, a, _, "updated")
        }, g)
    }, B = (a, u, _, g, v, x, C) => {
        for (let y = 0; y < u.length; y++) {
            const $ = a[y],
                b = u[y],
                w = $.el && ($.type === xe || !pt($, b) || $.shapeFlag & 70) ? p($.el) : _;
            O($, b, w, null, g, v, x, C, !0)
        }
    }, se = (a, u, _, g, v, x, C) => {
        if (_ !== g) {
            if (_ !== ne)
                for (const y in _) !Ht(y) && !(y in g) && i(a, y, _[y], null, C, u.children, v, x, Ke);
            for (const y in g) {
                if (Ht(y)) continue;
                const $ = g[y],
                    b = _[y];
                $ !== b && y !== "value" && i(a, y, b, $, C, u.children, v, x, Ke)
            }
            "value" in g && i(a, "value", _.value, g.value, C)
        }
    }, I = (a, u, _, g, v, x, C, y, $) => {
        const b = u.el = a ? a.el : c(""),
            w = u.anchor = a ? a.anchor : c("");
        let {
            patchFlag: A,
            dynamicChildren: E,
            slotScopeIds: F
        } = u;
        F && (y = y ? y.concat(F) : F), a == null ? (s(b, _, g), s(w, _, g), T(u.children || [], _, w, v, x, C, y, $)) : A > 0 && A & 64 && E && a.dynamicChildren ? (B(a.dynamicChildren, E, _, v, x, C, y), (u.key != null || v && u === v.subTree) && Ri(a, u, !0)) : Q(a, u, _, w, v, x, C, y, $)
    }, te = (a, u, _, g, v, x, C, y, $) => {
        u.slotScopeIds = y, a == null ? u.shapeFlag & 512 ? v.ctx.activate(u, _, g, C, $) : me(u, _, g, v, x, C, $) : Me(a, u, $)
    }, me = (a, u, _, g, v, x, C) => {
        const y = a.component = Dc(a, g, v);
        if (Rn(a) && (y.ctx.renderer = xt), Vc(y), y.asyncDep) {
            if (v && v.registerDep(y, G), !a.el) {
                const $ = y.subTree = Z(Pe);
                z(null, $, u, _)
            }
        } else G(y, a, u, _, v, x, C)
    }, Me = (a, u, _) => {
        const g = u.component = a.component;
        if (Wr(a, u, _))
            if (g.asyncDep && !g.asyncResolved) {
                re(g, u, _);
                return
            } else g.next = u, Br(g.update), g.effect.dirty = !0, g.update();
        else u.el = a.el, g.vnode = u
    }, G = (a, u, _, g, v, x, C) => {
        const y = () => {
                if (a.isMounted) {
                    let {
                        next: w,
                        bu: A,
                        u: E,
                        parent: F,
                        vnode: V
                    } = a;
                    {
                        const $t = ki(a);
                        if ($t) {
                            w && (w.el = V.el, re(a, w, C)), $t.asyncDep.then(() => {
                                a.isUnmounted || y()
                            });
                            return
                        }
                    }
                    let Y = w,
                        oe;
                    ut(a, !1), w ? (w.el = V.el, re(a, w, C)) : w = V, A && hn(A), (oe = w.props && w.props.onVnodeBeforeUpdate) && je(oe, F, w, V), ut(a, !0);
                    const fe = Xn(a),
                        Ae = a.subTree;
                    a.subTree = fe, O(Ae, fe, p(Ae.el), sn(Ae), a, v, x), w.el = fe.el, Y === null && zr(a, fe.el), E && ye(E, v), (oe = w.props && w.props.onVnodeUpdated) && ye(() => je(oe, F, w, V), v)
                } else {
                    let w;
                    const {
                        el: A,
                        props: E
                    } = u, {
                        bm: F,
                        m: V,
                        parent: Y
                    } = a, oe = mn(u);
                    if (ut(a, !1), F && hn(F), !oe && (w = E && E.onVnodeBeforeMount) && je(w, Y, u), ut(a, !0), A && Jn) {
                        const fe = () => {
                            a.subTree = Xn(a), Jn(A, a.subTree, a, v, null)
                        };
                        oe ? u.type.__asyncLoader().then(() => !a.isUnmounted && fe()) : fe()
                    } else {
                        const fe = a.subTree = Xn(a);
                        O(null, fe, _, g, a, v, x), u.el = fe.el
                    }
                    if (V && ye(V, v), !oe && (w = E && E.onVnodeMounted)) {
                        const fe = u;
                        ye(() => je(w, Y, fe), v)
                    }(u.shapeFlag & 256 || Y && mn(Y.vnode) && Y.vnode.shapeFlag & 256) && a.a && ye(a.a, v), a.isMounted = !0, u = _ = g = null
                }
            },
            $ = a.effect = new Ns(y, Te, () => js(b), a.scope),
            b = a.update = () => {
                $.dirty && $.run()
            };
        b.id = a.uid, ut(a, !0), b()
    }, re = (a, u, _) => {
        u.component = a;
        const g = a.vnode.props;
        a.vnode = u, a.next = null, wc(a, u.props, g, _), Ec(a, u.children, _), bt(), oo(a), yt()
    }, Q = (a, u, _, g, v, x, C, y, $ = !1) => {
        const b = a && a.children,
            w = a ? a.shapeFlag : 0,
            A = u.children,
            {
                patchFlag: E,
                shapeFlag: F
            } = u;
        if (E > 0) {
            if (E & 128) {
                nn(b, A, _, g, v, x, C, y, $);
                return
            } else if (E & 256) {
                ct(b, A, _, g, v, x, C, y, $);
                return
            }
        }
        F & 8 ? (w & 16 && Ke(b, v, x), A !== b && d(_, A)) : w & 16 ? F & 16 ? nn(b, A, _, g, v, x, C, y, $) : Ke(b, v, x, !0) : (w & 8 && d(_, ""), F & 16 && T(A, _, g, v, x, C, y, $))
    }, ct = (a, u, _, g, v, x, C, y, $) => {
        a = a || wt, u = u || wt;
        const b = a.length,
            w = u.length,
            A = Math.min(b, w);
        let E;
        for (E = 0; E < A; E++) {
            const F = u[E] = $ ? tt(u[E]) : De(u[E]);
            O(a[E], F, _, null, v, x, C, y, $)
        }
        b > w ? Ke(a, v, x, !0, !1, A) : T(u, _, g, v, x, C, y, $, A)
    }, nn = (a, u, _, g, v, x, C, y, $) => {
        let b = 0;
        const w = u.length;
        let A = a.length - 1,
            E = w - 1;
        for (; b <= A && b <= E;) {
            const F = a[b],
                V = u[b] = $ ? tt(u[b]) : De(u[b]);
            if (pt(F, V)) O(F, V, _, null, v, x, C, y, $);
            else break;
            b++
        }
        for (; b <= A && b <= E;) {
            const F = a[A],
                V = u[E] = $ ? tt(u[E]) : De(u[E]);
            if (pt(F, V)) O(F, V, _, null, v, x, C, y, $);
            else break;
            A--, E--
        }
        if (b > A) {
            if (b <= E) {
                const F = E + 1,
                    V = F < w ? u[F].el : g;
                for (; b <= E;) O(null, u[b] = $ ? tt(u[b]) : De(u[b]), _, V, v, x, C, y, $), b++
            }
        } else if (b > E)
            for (; b <= A;) ke(a[b], v, x, !0), b++;
        else {
            const F = b,
                V = b,
                Y = new Map;
            for (b = V; b <= E; b++) {
                const Se = u[b] = $ ? tt(u[b]) : De(u[b]);
                Se.key != null && Y.set(Se.key, b)
            }
            let oe, fe = 0;
            const Ae = E - V + 1;
            let $t = !1,
                Ws = 0;
            const Ft = new Array(Ae);
            for (b = 0; b < Ae; b++) Ft[b] = 0;
            for (b = F; b <= A; b++) {
                const Se = a[b];
                if (fe >= Ae) {
                    ke(Se, v, x, !0);
                    continue
                }
                let He;
                if (Se.key != null) He = Y.get(Se.key);
                else
                    for (oe = V; oe <= E; oe++)
                        if (Ft[oe - V] === 0 && pt(Se, u[oe])) {
                            He = oe;
                            break
                        } He === void 0 ? ke(Se, v, x, !0) : (Ft[He - V] = b + 1, He >= Ws ? Ws = He : $t = !0, O(Se, u[He], _, null, v, x, C, y, $), fe++)
            }
            const zs = $t ? Pc(Ft) : wt;
            for (oe = zs.length - 1, b = Ae - 1; b >= 0; b--) {
                const Se = V + b,
                    He = u[Se],
                    Js = Se + 1 < w ? u[Se + 1].el : g;
                Ft[b] === 0 ? O(null, He, _, Js, v, x, C, y, $) : $t && (oe < 0 || b !== zs[oe] ? lt(He, _, Js, 2) : oe--)
            }
        }
    }, lt = (a, u, _, g, v = null) => {
        const {
            el: x,
            type: C,
            transition: y,
            children: $,
            shapeFlag: b
        } = a;
        if (b & 6) {
            lt(a.component.subTree, u, _, g);
            return
        }
        if (b & 128) {
            a.suspense.move(u, _, g);
            return
        }
        if (b & 64) {
            C.move(a, u, _, xt);
            return
        }
        if (C === xe) {
            s(x, u, _);
            for (let A = 0; A < $.length; A++) lt($[A], u, _, g);
            s(a.anchor, u, _);
            return
        }
        if (C === ns) {
            D(a, u, _);
            return
        }
        if (g !== 2 && b & 1 && y)
            if (g === 0) y.beforeEnter(x), s(x, u, _), ye(() => y.enter(x), v);
            else {
                const {
                    leave: A,
                    delayLeave: E,
                    afterLeave: F
                } = y, V = () => s(x, u, _), Y = () => {
                    A(x, () => {
                        V(), F && F()
                    })
                };
                E ? E(x, V, Y) : Y()
            }
        else s(x, u, _)
    }, ke = (a, u, _, g = !1, v = !1) => {
        const {
            type: x,
            props: C,
            ref: y,
            children: $,
            dynamicChildren: b,
            shapeFlag: w,
            patchFlag: A,
            dirs: E
        } = a;
        if (y != null && vs(y, null, _, a, !0), w & 256) {
            u.ctx.deactivate(a);
            return
        }
        const F = w & 1 && E,
            V = !mn(a);
        let Y;
        if (V && (Y = C && C.onVnodeBeforeUnmount) && je(Y, u, a), w & 6) Ji(a.component, _, g);
        else {
            if (w & 128) {
                a.suspense.unmount(_, g);
                return
            }
            F && at(a, null, u, "beforeUnmount"), w & 64 ? a.type.remove(a, u, _, v, xt, g) : b && (x !== xe || A > 0 && A & 64) ? Ke(b, u, _, !1, !0) : (x === xe && A & 384 || !v && w & 16) && Ke($, u, _), g && qs(a)
        }(V && (Y = C && C.onVnodeUnmounted) || F) && ye(() => {
            Y && je(Y, u, a), F && at(a, null, u, "unmounted")
        }, _)
    }, qs = a => {
        const {
            type: u,
            el: _,
            anchor: g,
            transition: v
        } = a;
        if (u === xe) {
            zi(_, g);
            return
        }
        if (u === ns) {
            M(a);
            return
        }
        const x = () => {
            o(_), v && !v.persisted && v.afterLeave && v.afterLeave()
        };
        if (a.shapeFlag & 1 && v && !v.persisted) {
            const {
                leave: C,
                delayLeave: y
            } = v, $ = () => C(_, x);
            y ? y(a.el, x, $) : $()
        } else x()
    }, zi = (a, u) => {
        let _;
        for (; a !== u;) _ = m(a), o(a), a = _;
        o(u)
    }, Ji = (a, u, _) => {
        const {
            bum: g,
            scope: v,
            update: x,
            subTree: C,
            um: y
        } = a;
        g && hn(g), v.stop(), x && (x.active = !1, ke(C, a, u, _)), y && ye(y, u), ye(() => {
            a.isUnmounted = !0
        }, u), u && u.pendingBranch && !u.isUnmounted && a.asyncDep && !a.asyncResolved && a.suspenseId === u.pendingId && (u.deps--, u.deps === 0 && u.resolve())
    }, Ke = (a, u, _, g = !1, v = !1, x = 0) => {
        for (let C = x; C < a.length; C++) ke(a[C], u, _, g, v)
    }, sn = a => a.shapeFlag & 6 ? sn(a.component.subTree) : a.shapeFlag & 128 ? a.suspense.next() : m(a.anchor || a.el);
    let Wn = !1;
    const Gs = (a, u, _) => {
            a == null ? u._vnode && ke(u._vnode, null, null, !0) : O(u._vnode || null, a, u, null, null, null, _), Wn || (Wn = !0, oo(), mi(), Wn = !1), u._vnode = a
        },
        xt = {
            p: O,
            um: ke,
            m: lt,
            r: qs,
            mt: me,
            mc: T,
            pc: Q,
            pbc: B,
            n: sn,
            o: e
        };
    let zn, Jn;
    return t && ([zn, Jn] = t(xt)), {
        render: Gs,
        hydrate: zn,
        createApp: xc(Gs, zn)
    }
}

function ts({
    type: e,
    props: t
}, n) {
    return n === "svg" && e === "foreignObject" || n === "mathml" && e === "annotation-xml" && t && t.encoding && t.encoding.includes("html") ? void 0 : n
}

function ut({
    effect: e,
    update: t
}, n) {
    e.allowRecurse = t.allowRecurse = n
}

function Nc(e, t) {
    return (!e || e && !e.pendingBranch) && t && !t.persisted
}

function Ri(e, t, n = !1) {
    const s = e.children,
        o = t.children;
    if (L(s) && L(o))
        for (let i = 0; i < s.length; i++) {
            const r = s[i];
            let c = o[i];
            c.shapeFlag & 1 && !c.dynamicChildren && ((c.patchFlag <= 0 || c.patchFlag === 32) && (c = o[i] = tt(o[i]), c.el = r.el), n || Ri(r, c)), c.type === Hn && (c.el = r.el)
        }
}

function Pc(e) {
    const t = e.slice(),
        n = [0];
    let s, o, i, r, c;
    const l = e.length;
    for (s = 0; s < l; s++) {
        const f = e[s];
        if (f !== 0) {
            if (o = n[n.length - 1], e[o] < f) {
                t[s] = o, n.push(s);
                continue
            }
            for (i = 0, r = n.length - 1; i < r;) c = i + r >> 1, e[n[c]] < f ? i = c + 1 : r = c;
            f < e[n[i]] && (i > 0 && (t[s] = n[i - 1]), n[i] = s)
        }
    }
    for (i = n.length, r = n[i - 1]; i-- > 0;) n[i] = r, r = t[r];
    return n
}

function ki(e) {
    const t = e.subTree.component;
    if (t) return t.asyncDep && !t.asyncResolved ? t : ki(t)
}
const Lc = e => e.__isTeleport,
    xe = Symbol.for("v-fgt"),
    Hn = Symbol.for("v-txt"),
    Pe = Symbol.for("v-cmt"),
    ns = Symbol.for("v-stc"),
    Vt = [];
let Ne = null;

function j(e = !1) {
    Vt.push(Ne = e ? null : [])
}

function Oc() {
    Vt.pop(), Ne = Vt[Vt.length - 1] || null
}
let zt = 1;

function go(e) {
    zt += e
}

function Hi(e) {
    return e.dynamicChildren = zt > 0 ? Ne || wt : null, Oc(), zt > 0 && Ne && Ne.push(e), e
}

function X(e, t, n, s, o, i) {
    return Hi(h(e, t, n, s, o, i, !0))
}

function Le(e, t, n, s, o) {
    return Hi(Z(e, t, n, s, o, !0))
}

function bs(e) {
    return e ? e.__v_isVNode === !0 : !1
}

function pt(e, t) {
    return e.type === t.type && e.key === t.key
}
const jn = "__vInternal",
    ji = ({
        key: e
    }) => e ?? null,
    gn = ({
        ref: e,
        ref_key: t,
        ref_for: n
    }) => (typeof e == "number" && (e = "" + e), e != null ? le(e) || ae(e) || R(e) ? {
        i: _e,
        r: e,
        k: t,
        f: !!n
    } : e : null);

function h(e, t = null, n = null, s = 0, o = null, i = e === xe ? 0 : 1, r = !1, c = !1) {
    const l = {
        __v_isVNode: !0,
        __v_skip: !0,
        type: e,
        props: t,
        key: t && ji(t),
        ref: t && gn(t),
        scopeId: Fn,
        slotScopeIds: null,
        children: n,
        component: null,
        suspense: null,
        ssContent: null,
        ssFallback: null,
        dirs: null,
        transition: null,
        el: null,
        anchor: null,
        target: null,
        targetAnchor: null,
        staticCount: 0,
        shapeFlag: i,
        patchFlag: s,
        dynamicProps: o,
        dynamicChildren: null,
        appContext: null,
        ctx: _e
    };
    return c ? (Us(l, n), i & 128 && e.normalize(l)) : n && (l.shapeFlag |= le(n) ? 8 : 16), zt > 0 && !r && Ne && (l.patchFlag > 0 || i & 6) && l.patchFlag !== 32 && Ne.push(l), l
}
const Z = Fc;

function Fc(e, t = null, n = null, s = 0, o = null, i = !1) {
    if ((!e || e === yi) && (e = Pe), bs(e)) {
        const c = rt(e, t, !0);
        return n && Us(c, n), zt > 0 && !i && Ne && (c.shapeFlag & 6 ? Ne[Ne.indexOf(e)] = c : Ne.push(c)), c.patchFlag |= -2, c
    }
    if (Wc(e) && (e = e.__vccOpts), t) {
        t = Rc(t);
        let {
            class: c,
            style: l
        } = t;
        c && !le(c) && (t.class = Ie(c)), ee(l) && (li(l) && !L(l) && (l = he({}, l)), t.style = As(l))
    }
    const r = le(e) ? 1 : Yr(e) ? 128 : Lc(e) ? 64 : ee(e) ? 4 : R(e) ? 2 : 0;
    return h(e, t, n, s, o, r, i, !0)
}

function Rc(e) {
    return e ? li(e) || jn in e ? he({}, e) : e : null
}

function rt(e, t, n = !1) {
    const {
        props: s,
        ref: o,
        patchFlag: i,
        children: r
    } = e, c = t ? kc(s || {}, t) : s;
    return {
        __v_isVNode: !0,
        __v_skip: !0,
        type: e.type,
        props: c,
        key: c && ji(c),
        ref: t && t.ref ? n && o ? L(o) ? o.concat(gn(t)) : [o, gn(t)] : gn(t) : o,
        scopeId: e.scopeId,
        slotScopeIds: e.slotScopeIds,
        children: r,
        target: e.target,
        targetAnchor: e.targetAnchor,
        staticCount: e.staticCount,
        shapeFlag: e.shapeFlag,
        patchFlag: t && e.type !== xe ? i === -1 ? 16 : i | 16 : i,
        dynamicProps: e.dynamicProps,
        dynamicChildren: e.dynamicChildren,
        appContext: e.appContext,
        dirs: e.dirs,
        transition: e.transition,
        component: e.component,
        suspense: e.suspense,
        ssContent: e.ssContent && rt(e.ssContent),
        ssFallback: e.ssFallback && rt(e.ssFallback),
        el: e.el,
        anchor: e.anchor,
        ctx: e.ctx,
        ce: e.ce
    }
}

function ys(e = " ", t = 0) {
    return Z(Hn, null, e, t)
}

function xs(e = "", t = !1) {
    return t ? (j(), Le(Pe, null, e)) : Z(Pe, null, e)
}

function De(e) {
    return e == null || typeof e == "boolean" ? Z(Pe) : L(e) ? Z(xe, null, e.slice()) : typeof e == "object" ? tt(e) : Z(Hn, null, String(e))
}

function tt(e) {
    return e.el === null && e.patchFlag !== -1 || e.memo ? e : rt(e)
}

function Us(e, t) {
    let n = 0;
    const {
        shapeFlag: s
    } = e;
    if (t == null) t = null;
    else if (L(t)) n = 16;
    else if (typeof t == "object")
        if (s & 65) {
            const o = t.default;
            o && (o._c && (o._d = !1), Us(e, o()), o._c && (o._d = !0));
            return
        } else {
            n = 32;
            const o = t._;
            !o && !(jn in t) ? t._ctx = _e : o === 3 && _e && (_e.slots._ === 1 ? t._ = 1 : (t._ = 2, e.patchFlag |= 1024))
        }
    else R(t) ? (t = {
        default: t,
        _ctx: _e
    }, n = 32) : (t = String(t), s & 64 ? (n = 16, t = [ys(t)]) : n = 8);
    e.children = t, e.shapeFlag |= n
}

function kc(...e) {
    const t = {};
    for (let n = 0; n < e.length; n++) {
        const s = e[n];
        for (const o in s)
            if (o === "class") t.class !== s.class && (t.class = Ie([t.class, s.class]));
            else if (o === "style") t.style = As([t.style, s.style]);
        else if (Tn(o)) {
            const i = t[o],
                r = s[o];
            r && i !== r && !(L(i) && i.includes(r)) && (t[o] = i ? [].concat(i, r) : r)
        } else o !== "" && (t[o] = s[o])
    }
    return t
}

function je(e, t, n, s = null) {
    Ee(e, t, 7, [n, s])
}
const Hc = Ai();
let jc = 0;

function Dc(e, t, n) {
    const s = e.type,
        o = (t ? t.appContext : e.appContext) || Hc,
        i = {
            uid: jc++,
            vnode: e,
            type: s,
            parent: t,
            appContext: o,
            root: null,
            next: null,
            subTree: null,
            effect: null,
            update: null,
            scope: new Wo(!0),
            render: null,
            proxy: null,
            exposed: null,
            exposeProxy: null,
            withProxy: null,
            provides: t ? t.provides : Object.create(o.provides),
            accessCache: null,
            renderCache: [],
            components: null,
            directives: null,
            propsOptions: Pi(s, o),
            emitsOptions: vi(s, o),
            emit: null,
            emitted: null,
            propsDefaults: ne,
            inheritAttrs: s.inheritAttrs,
            ctx: ne,
            data: ne,
            props: ne,
            attrs: ne,
            slots: ne,
            refs: ne,
            setupState: ne,
            setupContext: null,
            attrsProxy: null,
            slotsProxy: null,
            suspense: n,
            suspenseId: n ? n.pendingId : 0,
            asyncDep: null,
            asyncResolved: !1,
            isMounted: !1,
            isUnmounted: !1,
            isDeactivated: !1,
            bc: null,
            c: null,
            bm: null,
            m: null,
            bu: null,
            u: null,
            um: null,
            bum: null,
            da: null,
            a: null,
            rtg: null,
            rtc: null,
            ec: null,
            sp: null
        };
    return i.ctx = {
        _: i
    }, i.root = t ? t.root : i, i.emit = Kr.bind(null, i), e.ce && e.ce(i), i
}
let de = null;
const Bc = () => de || _e;
let wn, $s;
{
    const e = Ko(),
        t = (n, s) => {
            let o;
            return (o = e[n]) || (o = e[n] = []), o.push(s), i => {
                o.length > 1 ? o.forEach(r => r(i)) : o[0](i)
            }
        };
    wn = t("__VUE_INSTANCE_SETTERS__", n => de = n), $s = t("__VUE_SSR_SETTERS__", n => Dn = n)
}
const Zt = e => {
        const t = de;
        return wn(e), e.scope.on(), () => {
            e.scope.off(), wn(t)
        }
    },
    vo = () => {
        de && de.scope.off(), wn(null)
    };

function Di(e) {
    return e.vnode.shapeFlag & 4
}
let Dn = !1;

function Vc(e, t = !1) {
    t && $s(t);
    const {
        props: n,
        children: s
    } = e.vnode, o = Di(e);
    Cc(e, n, o, t), Ic(e, s);
    const i = o ? Uc(e, t) : void 0;
    return t && $s(!1), i
}

function Uc(e, t) {
    const n = e.type;
    e.accessCache = Object.create(null), e.proxy = Pn(new Proxy(e.ctx, pc));
    const {
        setup: s
    } = n;
    if (s) {
        const o = e.setupContext = s.length > 1 ? qc(e) : null,
            i = Zt(e);
        bt();
        const r = ot(s, e, 0, [e.props, o]);
        if (yt(), i(), Bo(r)) {
            if (r.then(vo, vo), t) return r.then(c => {
                bo(e, c, t)
            }).catch(c => {
                Ln(c, e, 0)
            });
            e.asyncDep = r
        } else bo(e, r, t)
    } else Bi(e, t)
}

function bo(e, t, n) {
    R(t) ? e.type.__ssrInlineRender ? e.ssrRender = t : e.render = t : ee(t) && (e.setupState = fi(t)), Bi(e, n)
}
let yo;

function Bi(e, t, n) {
    const s = e.type;
    if (!e.render) {
        if (!t && yo && !s.render) {
            const o = s.template || Bs(e).template;
            if (o) {
                const {
                    isCustomElement: i,
                    compilerOptions: r
                } = e.appContext.config, {
                    delimiters: c,
                    compilerOptions: l
                } = s, f = he(he({
                    isCustomElement: i,
                    delimiters: c
                }, r), l);
                s.render = yo(o, f)
            }
        }
        e.render = s.render || Te
    } {
        const o = Zt(e);
        bt();
        try {
            _c(e)
        } finally {
            yt(), o()
        }
    }
}

function Kc(e) {
    return e.attrsProxy || (e.attrsProxy = new Proxy(e.attrs, {
        get(t, n) {
            return $e(e, "get", "$attrs"), t[n]
        }
    }))
}

function qc(e) {
    const t = n => {
        e.exposed = n || {}
    };
    return {
        get attrs() {
            return Kc(e)
        },
        slots: e.slots,
        emit: e.emit,
        expose: t
    }
}

function Bn(e) {
    if (e.exposed) return e.exposeProxy || (e.exposeProxy = new Proxy(fi(Pn(e.exposed)), {
        get(t, n) {
            if (n in t) return t[n];
            if (n in Dt) return Dt[n](e)
        },
        has(t, n) {
            return n in t || n in Dt
        }
    }))
}

function Gc(e, t = !0) {
    return R(e) ? e.displayName || e.name : e.name || t && e.__name
}

function Wc(e) {
    return R(e) && "__vccOpts" in e
}
const Ve = (e, t) => Nr(e, t, Dn);

function Ss(e, t, n) {
    const s = arguments.length;
    return s === 2 ? ee(t) && !L(t) ? bs(t) ? Z(e, null, [t]) : Z(e, t) : Z(e, null, t) : (s > 3 ? n = Array.prototype.slice.call(arguments, 2) : s === 3 && bs(n) && (n = [n]), Z(e, t, n))
}
const zc = "3.4.21";
/**
 * @vue/runtime-dom v3.4.21
 * (c) 2018-present Yuxi (Evan) You and Vue contributors
 * @license MIT
 **/
const Jc = "http://www.w3.org/2000/svg",
    Yc = "http://www.w3.org/1998/Math/MathML",
    nt = typeof document < "u" ? document : null,
    xo = nt && nt.createElement("template"),
    Zc = {
        insert: (e, t, n) => {
            t.insertBefore(e, n || null)
        },
        remove: e => {
            const t = e.parentNode;
            t && t.removeChild(e)
        },
        createElement: (e, t, n, s) => {
            const o = t === "svg" ? nt.createElementNS(Jc, e) : t === "mathml" ? nt.createElementNS(Yc, e) : nt.createElement(e, n ? {
                is: n
            } : void 0);
            return e === "select" && s && s.multiple != null && o.setAttribute("multiple", s.multiple), o
        },
        createText: e => nt.createTextNode(e),
        createComment: e => nt.createComment(e),
        setText: (e, t) => {
            e.nodeValue = t
        },
        setElementText: (e, t) => {
            e.textContent = t
        },
        parentNode: e => e.parentNode,
        nextSibling: e => e.nextSibling,
        querySelector: e => nt.querySelector(e),
        setScopeId(e, t) {
            e.setAttribute(t, "")
        },
        insertStaticContent(e, t, n, s, o, i) {
            const r = n ? n.previousSibling : t.lastChild;
            if (o && (o === i || o.nextSibling))
                for (; t.insertBefore(o.cloneNode(!0), n), !(o === i || !(o = o.nextSibling)););
            else {
                xo.innerHTML = s === "svg" ? `<svg>${e}</svg>` : s === "mathml" ? `<math>${e}</math>` : e;
                const c = xo.content;
                if (s === "svg" || s === "mathml") {
                    const l = c.firstChild;
                    for (; l.firstChild;) c.appendChild(l.firstChild);
                    c.removeChild(l)
                }
                t.insertBefore(c, n)
            }
            return [r ? r.nextSibling : t.firstChild, n ? n.previousSibling : t.lastChild]
        }
    },
    Ye = "transition",
    Rt = "animation",
    Jt = Symbol("_vtc"),
    Pt = (e, {
        slots: t
    }) => Ss(sc, Xc(e), t);
Pt.displayName = "Transition";
const Vi = {
    name: String,
    type: String,
    css: {
        type: Boolean,
        default: !0
    },
    duration: [String, Number, Object],
    enterFromClass: String,
    enterActiveClass: String,
    enterToClass: String,
    appearFromClass: String,
    appearActiveClass: String,
    appearToClass: String,
    leaveFromClass: String,
    leaveActiveClass: String,
    leaveToClass: String
};
Pt.props = he({}, Si, Vi);
const ft = (e, t = []) => {
        L(e) ? e.forEach(n => n(...t)) : e && e(...t)
    },
    $o = e => e ? L(e) ? e.some(t => t.length > 1) : e.length > 1 : !1;

function Xc(e) {
    const t = {};
    for (const I in e) I in Vi || (t[I] = e[I]);
    if (e.css === !1) return t;
    const {
        name: n = "v",
        type: s,
        duration: o,
        enterFromClass: i = `${n}-enter-from`,
        enterActiveClass: r = `${n}-enter-active`,
        enterToClass: c = `${n}-enter-to`,
        appearFromClass: l = i,
        appearActiveClass: f = r,
        appearToClass: d = c,
        leaveFromClass: p = `${n}-leave-from`,
        leaveActiveClass: m = `${n}-leave-active`,
        leaveToClass: S = `${n}-leave-to`
    } = e, N = Qc(o), O = N && N[0], W = N && N[1], {
        onBeforeEnter: z,
        onEnter: ue,
        onEnterCancelled: D,
        onLeave: M,
        onLeaveCancelled: U,
        onBeforeAppear: H = z,
        onAppear: ce = ue,
        onAppearCancelled: T = D
    } = t, P = (I, te, me) => {
        dt(I, te ? d : c), dt(I, te ? f : r), me && me()
    }, B = (I, te) => {
        I._isLeaving = !1, dt(I, p), dt(I, S), dt(I, m), te && te()
    }, se = I => (te, me) => {
        const Me = I ? ce : ue,
            G = () => P(te, I, me);
        ft(Me, [te, G]), So(() => {
            dt(te, I ? l : i), Ze(te, I ? d : c), $o(Me) || Co(te, s, O, G)
        })
    };
    return he(t, {
        onBeforeEnter(I) {
            ft(z, [I]), Ze(I, i), Ze(I, r)
        },
        onBeforeAppear(I) {
            ft(H, [I]), Ze(I, l), Ze(I, f)
        },
        onEnter: se(!1),
        onAppear: se(!0),
        onLeave(I, te) {
            I._isLeaving = !0;
            const me = () => B(I, te);
            Ze(I, p), nl(), Ze(I, m), So(() => {
                I._isLeaving && (dt(I, p), Ze(I, S), $o(M) || Co(I, s, W, me))
            }), ft(M, [I, me])
        },
        onEnterCancelled(I) {
            P(I, !1), ft(D, [I])
        },
        onAppearCancelled(I) {
            P(I, !0), ft(T, [I])
        },
        onLeaveCancelled(I) {
            B(I), ft(U, [I])
        }
    })
}

function Qc(e) {
    if (e == null) return null;
    if (ee(e)) return [ss(e.enter), ss(e.leave)];
    {
        const t = ss(e);
        return [t, t]
    }
}

function ss(e) {
    return tr(e)
}

function Ze(e, t) {
    t.split(/\s+/).forEach(n => n && e.classList.add(n)), (e[Jt] || (e[Jt] = new Set)).add(t)
}

function dt(e, t) {
    t.split(/\s+/).forEach(s => s && e.classList.remove(s));
    const n = e[Jt];
    n && (n.delete(t), n.size || (e[Jt] = void 0))
}

function So(e) {
    requestAnimationFrame(() => {
        requestAnimationFrame(e)
    })
}
let el = 0;

function Co(e, t, n, s) {
    const o = e._endId = ++el,
        i = () => {
            o === e._endId && s()
        };
    if (n) return setTimeout(i, n);
    const {
        type: r,
        timeout: c,
        propCount: l
    } = tl(e, t);
    if (!r) return s();
    const f = r + "end";
    let d = 0;
    const p = () => {
            e.removeEventListener(f, m), i()
        },
        m = S => {
            S.target === e && ++d >= l && p()
        };
    setTimeout(() => {
        d < l && p()
    }, c + 1), e.addEventListener(f, m)
}

function tl(e, t) {
    const n = window.getComputedStyle(e),
        s = N => (n[N] || "").split(", "),
        o = s(`${Ye}Delay`),
        i = s(`${Ye}Duration`),
        r = wo(o, i),
        c = s(`${Rt}Delay`),
        l = s(`${Rt}Duration`),
        f = wo(c, l);
    let d = null,
        p = 0,
        m = 0;
    t === Ye ? r > 0 && (d = Ye, p = r, m = i.length) : t === Rt ? f > 0 && (d = Rt, p = f, m = l.length) : (p = Math.max(r, f), d = p > 0 ? r > f ? Ye : Rt : null, m = d ? d === Ye ? i.length : l.length : 0);
    const S = d === Ye && /\b(transform|all)(,|$)/.test(s(`${Ye}Property`).toString());
    return {
        type: d,
        timeout: p,
        propCount: m,
        hasTransform: S
    }
}

function wo(e, t) {
    for (; e.length < t.length;) e = e.concat(e);
    return Math.max(...t.map((n, s) => To(n) + To(e[s])))
}

function To(e) {
    return e === "auto" ? 0 : Number(e.slice(0, -1).replace(",", ".")) * 1e3
}

function nl() {
    return document.body.offsetHeight
}

function sl(e, t, n) {
    const s = e[Jt];
    s && (t = (t ? [t, ...s] : [...s]).join(" ")), t == null ? e.removeAttribute("class") : n ? e.setAttribute("class", t) : e.className = t
}
const Io = Symbol("_vod"),
    ol = Symbol("_vsh"),
    il = Symbol(""),
    rl = /(^|;)\s*display\s*:/;

function cl(e, t, n) {
    const s = e.style,
        o = le(n);
    let i = !1;
    if (n && !o) {
        if (t)
            if (le(t))
                for (const r of t.split(";")) {
                    const c = r.slice(0, r.indexOf(":")).trim();
                    n[c] == null && vn(s, c, "")
                } else
                    for (const r in t) n[r] == null && vn(s, r, "");
        for (const r in n) r === "display" && (i = !0), vn(s, r, n[r])
    } else if (o) {
        if (t !== n) {
            const r = s[il];
            r && (n += ";" + r), s.cssText = n, i = rl.test(n)
        }
    } else t && e.removeAttribute("style");
    Io in e && (e[Io] = i ? s.display : "", e[ol] && (s.display = "none"))
}
const Eo = /\s*!important$/;

function vn(e, t, n) {
    if (L(n)) n.forEach(s => vn(e, t, s));
    else if (n == null && (n = ""), t.startsWith("--")) e.setProperty(t, n);
    else {
        const s = ll(e, t);
        Eo.test(n) ? e.setProperty(Nt(s), n.replace(Eo, ""), "important") : e[s] = n
    }
}
const Mo = ["Webkit", "Moz", "ms"],
    os = {};

function ll(e, t) {
    const n = os[t];
    if (n) return n;
    let s = Ue(t);
    if (s !== "filter" && s in e) return os[t] = s;
    s = Mn(s);
    for (let o = 0; o < Mo.length; o++) {
        const i = Mo[o] + s;
        if (i in e) return os[t] = i
    }
    return t
}
const Ao = "http://www.w3.org/1999/xlink";

function al(e, t, n, s, o) {
    if (s && t.startsWith("xlink:")) n == null ? e.removeAttributeNS(Ao, t.slice(6, t.length)) : e.setAttributeNS(Ao, t, n);
    else {
        const i = cr(t);
        n == null || i && !qo(n) ? e.removeAttribute(t) : e.setAttribute(t, i ? "" : n)
    }
}

function ul(e, t, n, s, o, i, r) {
    if (t === "innerHTML" || t === "textContent") {
        s && r(s, o, i), e[t] = n ?? "";
        return
    }
    const c = e.tagName;
    if (t === "value" && c !== "PROGRESS" && !c.includes("-")) {
        const f = c === "OPTION" ? e.getAttribute("value") || "" : e.value,
            d = n ?? "";
        (f !== d || !("_value" in e)) && (e.value = d), n == null && e.removeAttribute(t), e._value = n;
        return
    }
    let l = !1;
    if (n === "" || n == null) {
        const f = typeof e[t];
        f === "boolean" ? n = qo(n) : n == null && f === "string" ? (n = "", l = !0) : f === "number" && (n = 0, l = !0)
    }
    try {
        e[t] = n
    } catch {}
    l && e.removeAttribute(t)
}

function Ct(e, t, n, s) {
    e.addEventListener(t, n, s)
}

function fl(e, t, n, s) {
    e.removeEventListener(t, n, s)
}
const No = Symbol("_vei");

function dl(e, t, n, s, o = null) {
    const i = e[No] || (e[No] = {}),
        r = i[t];
    if (s && r) r.value = s;
    else {
        const [c, l] = hl(t);
        if (s) {
            const f = i[t] = ml(s, o);
            Ct(e, c, f, l)
        } else r && (fl(e, c, r, l), i[t] = void 0)
    }
}
const Po = /(?:Once|Passive|Capture)$/;

function hl(e) {
    let t;
    if (Po.test(e)) {
        t = {};
        let s;
        for (; s = e.match(Po);) e = e.slice(0, e.length - s[0].length), t[s[0].toLowerCase()] = !0
    }
    return [e[2] === ":" ? e.slice(3) : Nt(e.slice(2)), t]
}
let is = 0;
const pl = Promise.resolve(),
    _l = () => is || (pl.then(() => is = 0), is = Date.now());

function ml(e, t) {
    const n = s => {
        if (!s._vts) s._vts = Date.now();
        else if (s._vts <= n.attached) return;
        Ee(gl(s, n.value), t, 5, [s])
    };
    return n.value = e, n.attached = _l(), n
}

function gl(e, t) {
    if (L(t)) {
        const n = e.stopImmediatePropagation;
        return e.stopImmediatePropagation = () => {
            n.call(e), e._stopped = !0
        }, t.map(s => o => !o._stopped && s && s(o))
    } else return t
}
const Lo = e => e.charCodeAt(0) === 111 && e.charCodeAt(1) === 110 && e.charCodeAt(2) > 96 && e.charCodeAt(2) < 123,
    vl = (e, t, n, s, o, i, r, c, l) => {
        const f = o === "svg";
        t === "class" ? sl(e, s, f) : t === "style" ? cl(e, n, s) : Tn(t) ? Is(t) || dl(e, t, n, s, r) : (t[0] === "." ? (t = t.slice(1), !0) : t[0] === "^" ? (t = t.slice(1), !1) : bl(e, t, s, f)) ? ul(e, t, s, i, r, c, l) : (t === "true-value" ? e._trueValue = s : t === "false-value" && (e._falseValue = s), al(e, t, s, f))
    };

function bl(e, t, n, s) {
    if (s) return !!(t === "innerHTML" || t === "textContent" || t in e && Lo(t) && R(n));
    if (t === "spellcheck" || t === "draggable" || t === "translate" || t === "form" || t === "list" && e.tagName === "INPUT" || t === "type" && e.tagName === "TEXTAREA") return !1;
    if (t === "width" || t === "height") {
        const o = e.tagName;
        if (o === "IMG" || o === "VIDEO" || o === "CANVAS" || o === "SOURCE") return !1
    }
    return Lo(t) && le(n) ? !1 : t in e
}
const Oo = e => {
    const t = e.props["onUpdate:modelValue"] || !1;
    return L(t) ? n => hn(t, n) : t
};

function yl(e) {
    e.target.composing = !0
}

function Fo(e) {
    const t = e.target;
    t.composing && (t.composing = !1, t.dispatchEvent(new Event("input")))
}
const rs = Symbol("_assign"),
    Ut = {
        created(e, {
            modifiers: {
                lazy: t,
                trim: n,
                number: s
            }
        }, o) {
            e[rs] = Oo(o);
            const i = s || o.props && o.props.type === "number";
            Ct(e, t ? "change" : "input", r => {
                if (r.target.composing) return;
                let c = e.value;
                n && (c = c.trim()), i && (c = cs(c)), e[rs](c)
            }), n && Ct(e, "change", () => {
                e.value = e.value.trim()
            }), t || (Ct(e, "compositionstart", yl), Ct(e, "compositionend", Fo), Ct(e, "change", Fo))
        },
        mounted(e, {
            value: t
        }) {
            e.value = t ?? ""
        },
        beforeUpdate(e, {
            value: t,
            modifiers: {
                lazy: n,
                trim: s,
                number: o
            }
        }, i) {
            if (e[rs] = Oo(i), e.composing) return;
            const r = o || e.type === "number" ? cs(e.value) : e.value,
                c = t ?? "";
            r !== c && (document.activeElement === e && e.type !== "range" && (n || s && e.value.trim() === c) || (e.value = c))
        }
    },
    xl = he({
        patchProp: vl
    }, Zc);
let Ro;

function $l() {
    return Ro || (Ro = Mc(xl))
}
const Sl = (...e) => {
    const t = $l().createApp(...e),
        {
            mount: n
        } = t;
    return t.mount = s => {
        const o = wl(s);
        if (!o) return;
        const i = t._component;
        !R(i) && !i.render && !i.template && (i.template = o.innerHTML), o.innerHTML = "";
        const r = n(o, !1, Cl(o));
        return o instanceof Element && (o.removeAttribute("v-cloak"), o.setAttribute("data-v-app", "")), r
    }, t
};

function Cl(e) {
    if (e instanceof SVGElement) return "svg";
    if (typeof MathMLElement == "function" && e instanceof MathMLElement) return "mathml"
}

function wl(e) {
    return le(e) ? document.querySelector(e) : e
}
var Tl = !1;
/*!
 * pinia v2.1.7
 * (c) 2023 Eduardo San Martin Morote
 * @license MIT
 */
let Ui;
const Vn = e => Ui = e,
    Ki = Symbol();

function Cs(e) {
    return e && typeof e == "object" && Object.prototype.toString.call(e) === "[object Object]" && typeof e.toJSON != "function"
}
var Kt;
(function(e) {
    e.direct = "direct", e.patchObject = "patch object", e.patchFunction = "patch function"
})(Kt || (Kt = {}));

function Il() {
    const e = zo(!0),
        t = e.run(() => ie({}));
    let n = [],
        s = [];
    const o = Pn({
        install(i) {
            Vn(o), o._a = i, i.provide(Ki, o), i.config.globalProperties.$pinia = o, s.forEach(r => n.push(r)), s = []
        },
        use(i) {
            return !this._a && !Tl ? s.push(i) : n.push(i), this
        },
        _p: n,
        _a: null,
        _e: e,
        _s: new Map,
        state: t
    });
    return o
}
const qi = () => {};

function ko(e, t, n, s = qi) {
    e.push(t);
    const o = () => {
        const i = e.indexOf(t);
        i > -1 && (e.splice(i, 1), s())
    };
    return !n && Jo() && ar(o), o
}

function St(e, ...t) {
    e.slice().forEach(n => {
        n(...t)
    })
}
const El = e => e();

function ws(e, t) {
    e instanceof Map && t instanceof Map && t.forEach((n, s) => e.set(s, n)), e instanceof Set && t instanceof Set && t.forEach(e.add, e);
    for (const n in t) {
        if (!t.hasOwnProperty(n)) continue;
        const s = t[n],
            o = e[n];
        Cs(o) && Cs(s) && e.hasOwnProperty(n) && !ae(s) && !Ge(s) ? e[n] = ws(o, s) : e[n] = s
    }
    return e
}
const Ml = Symbol();

function Al(e) {
    return !Cs(e) || !e.hasOwnProperty(Ml)
}
const {
    assign: Xe
} = Object;

function Nl(e) {
    return !!(ae(e) && e.effect)
}

function Pl(e, t, n, s) {
    const {
        state: o,
        actions: i,
        getters: r
    } = t, c = n.state.value[e];
    let l;

    function f() {
        c || (n.state.value[e] = o ? o() : {});
        const d = Fr(n.state.value[e]);
        return Xe(d, i, Object.keys(r || {}).reduce((p, m) => (p[m] = Pn(Ve(() => {
            Vn(n);
            const S = n._s.get(e);
            return r[m].call(S, S)
        })), p), {}))
    }
    return l = Gi(e, f, t, n, s, !0), l
}

function Gi(e, t, n = {}, s, o, i) {
    let r;
    const c = Xe({
            actions: {}
        }, n),
        l = {
            deep: !0
        };
    let f, d, p = [],
        m = [],
        S;
    const N = s.state.value[e];
    !i && !N && (s.state.value[e] = {}), ie({});
    let O;

    function W(T) {
        let P;
        f = d = !1, typeof T == "function" ? (T(s.state.value[e]), P = {
            type: Kt.patchFunction,
            storeId: e,
            events: S
        }) : (ws(s.state.value[e], T), P = {
            type: Kt.patchObject,
            payload: T,
            storeId: e,
            events: S
        });
        const B = O = Symbol();
        pi().then(() => {
            O === B && (f = !0)
        }), d = !0, St(p, P, s.state.value[e])
    }
    const z = i ? function() {
        const {
            state: P
        } = n, B = P ? P() : {};
        this.$patch(se => {
            Xe(se, B)
        })
    } : qi;

    function ue() {
        r.stop(), p = [], m = [], s._s.delete(e)
    }

    function D(T, P) {
        return function() {
            Vn(s);
            const B = Array.from(arguments),
                se = [],
                I = [];

            function te(G) {
                se.push(G)
            }

            function me(G) {
                I.push(G)
            }
            St(m, {
                args: B,
                name: T,
                store: U,
                after: te,
                onError: me
            });
            let Me;
            try {
                Me = P.apply(this && this.$id === e ? this : U, B)
            } catch (G) {
                throw St(I, G), G
            }
            return Me instanceof Promise ? Me.then(G => (St(se, G), G)).catch(G => (St(I, G), Promise.reject(G))) : (St(se, Me), Me)
        }
    }
    const M = {
            _p: s,
            $id: e,
            $onAction: ko.bind(null, m),
            $patch: W,
            $reset: z,
            $subscribe(T, P = {}) {
                const B = ko(p, T, P.detached, () => se()),
                    se = r.run(() => _n(() => s.state.value[e], I => {
                        (P.flush === "sync" ? d : f) && T({
                            storeId: e,
                            type: Kt.direct,
                            events: S
                        }, I)
                    }, Xe({}, l, P)));
                return B
            },
            $dispose: ue
        },
        U = Nn(M);
    s._s.set(e, U);
    const ce = (s._a && s._a.runWithContext || El)(() => s._e.run(() => (r = zo()).run(t)));
    for (const T in ce) {
        const P = ce[T];
        if (ae(P) && !Nl(P) || Ge(P)) i || (N && Al(P) && (ae(P) ? P.value = N[T] : ws(P, N[T])), s.state.value[e][T] = P);
        else if (typeof P == "function") {
            const B = D(T, P);
            ce[T] = B, c.actions[T] = P
        }
    }
    return Xe(U, ce), Xe(K(U), ce), Object.defineProperty(U, "$state", {
        get: () => s.state.value[e],
        set: T => {
            W(P => {
                Xe(P, T)
            })
        }
    }), s._p.forEach(T => {
        Xe(U, r.run(() => T({
            store: U,
            app: s._a,
            pinia: s,
            options: c
        })))
    }), N && i && n.hydrate && n.hydrate(U.$state, N), f = !0, d = !0, U
}

function Ll(e, t, n) {
    let s, o;
    const i = typeof t == "function";
    typeof e == "string" ? (s = e, o = i ? n : t) : (o = e, s = e.id);

    function r(c, l) {
        const f = Sc();
        return c = c || (f ? Bt(Ki, null) : null), c && Vn(c), c = Ui, c._s.has(s) || (i ? Gi(s, t, o, c) : Pl(s, o, c)), c._s.get(s)
    }
    return r.$id = s, r
}

function Un(e) {
    {
        e = K(e);
        const t = {};
        for (const n in e) {
            const s = e[n];
            (ae(s) || Ge(s)) && (t[n] = Hr(e, n))
        }
        return t
    }
}
const ve = Ll("banking", () => {
    const e = ie(!0);

    function t(M) {
        e.value = M
    }
    const n = ie({
        section: null,
        subsection: null,
        data: null
    });
    async function s() {
        let M = await fetchNui("banking:getData");
        D(M)
    }

    function o({
        section: M = null,
        subsection: U = null,
        data: H = null
    }) {
        n.value = {
            section: M,
            subsection: U,
            data: H
        }
    }
    const i = ie({
            id: 0,
            name: ""
        }),
        r = ie(0),
        c = ie(0),
        l = ie([]),
        f = ie(0),
        d = ie(0),
        p = ie(0),
        m = ie([]);

    function S(M) {
        i.value = {
            id: M.id,
            name: M.name
        }
    }

    function N(M) {
        r.value = M
    }

    function O(M) {
        c.value = M
    }

    function W(M) {
        l.value = M
    }

    function z(M) {
        m.value = M
    }

    function ue(M) {
        m.value.push(M)
    }

    function D(M) {
        S(M.account), N(M.balance), O(M.fines), W(M.invoices), z(M.historyItems)
    }
    return {
        refreshData: s,
        preLoading: e,
        currentTab: n,
        account: i,
        balance: r,
        fines: c,
        invoices: l,
        historyItems: m,
        houseTaxes: f,
        hospitalTaxes: d,
        extrasTaxes: p,
        setPreloading: t,
        setCurrentTab: o,
        setAccount: S,
        setBalance: N,
        setFines: O,
        setInvoices: W,
        setHistoryItems: z,
        addHistoryItem: ue,
        setBankingData: D
    }
});
/**
 * @license lucide-vue-next v0.363.0 - ISC
 *
 * This source code is licensed under the ISC license.
 * See the LICENSE file in the root directory of this source tree.
 */
var dn = {
    xmlns: "http://www.w3.org/2000/svg",
    width: 24,
    height: 24,
    viewBox: "0 0 24 24",
    fill: "none",
    stroke: "currentColor",
    "stroke-width": 2,
    "stroke-linecap": "round",
    "stroke-linejoin": "round"
};
/**
 * @license lucide-vue-next v0.363.0 - ISC
 *
 * This source code is licensed under the ISC license.
 * See the LICENSE file in the root directory of this source tree.
 */
const Ol = e => e.replace(/([a-z0-9])([A-Z])/g, "$1-$2").toLowerCase();
/**
 * @license lucide-vue-next v0.363.0 - ISC
 *
 * This source code is licensed under the ISC license.
 * See the LICENSE file in the root directory of this source tree.
 */
const Re = (e, t) => ({
    size: n,
    strokeWidth: s = 2,
    absoluteStrokeWidth: o,
    color: i,
    class: r,
    ...c
}, {
    attrs: l,
    slots: f
}) => Ss("svg", {
    ...dn,
    width: n || dn.width,
    height: n || dn.height,
    stroke: i || dn.stroke,
    "stroke-width": o ? Number(s) * 24 / Number(n) : s,
    ...l,
    class: ["lucide", `lucide-${Ol(e)}`],
    ...c
}, [...t.map(d => Ss(...d)), ...f.default ? [f.default()] : []]);
/**
 * @license lucide-vue-next v0.363.0 - ISC
 *
 * This source code is licensed under the ISC license.
 * See the LICENSE file in the root directory of this source tree.
 */
const Fl = Re("ArrowDownIcon", [
    ["path", {
        d: "M12 5v14",
        key: "s699le"
    }],
    ["path", {
        d: "m19 12-7 7-7-7",
        key: "1idqje"
    }]
]);
/**
 * @license lucide-vue-next v0.363.0 - ISC
 *
 * This source code is licensed under the ISC license.
 * See the LICENSE file in the root directory of this source tree.
 */
const ze = Re("ArrowLeftIcon", [
    ["path", {
        d: "m12 19-7-7 7-7",
        key: "1l729n"
    }],
    ["path", {
        d: "M19 12H5",
        key: "x3x0zl"
    }]
]);
/**
 * @license lucide-vue-next v0.363.0 - ISC
 *
 * This source code is licensed under the ISC license.
 * See the LICENSE file in the root directory of this source tree.
 */
const Rl = Re("ArrowUpToLineIcon", [
    ["path", {
        d: "M5 3h14",
        key: "7usisc"
    }],
    ["path", {
        d: "m18 13-6-6-6 6",
        key: "1kf1n9"
    }],
    ["path", {
        d: "M12 7v14",
        key: "1akyts"
    }]
]);
/**
 * @license lucide-vue-next v0.363.0 - ISC
 *
 * This source code is licensed under the ISC license.
 * See the LICENSE file in the root directory of this source tree.
 */
const kl = Re("ArrowUpIcon", [
    ["path", {
        d: "m5 12 7-7 7 7",
        key: "hav0vg"
    }],
    ["path", {
        d: "M12 19V5",
        key: "x0mq9r"
    }]
]);
/**
 * @license lucide-vue-next v0.363.0 - ISC
 *
 * This source code is licensed under the ISC license.
 * See the LICENSE file in the root directory of this source tree.
 */
const Hl = Re("CarIcon", [
    ["path", {
        d: "M19 17h2c.6 0 1-.4 1-1v-3c0-.9-.7-1.7-1.5-1.9C18.7 10.6 16 10 16 10s-1.3-1.4-2.2-2.3c-.5-.4-1.1-.7-1.8-.7H5c-.6 0-1.1.4-1.4.9l-1.4 2.9A3.7 3.7 0 0 0 2 12v4c0 .6.4 1 1 1h2",
        key: "5owen"
    }],
    ["circle", {
        cx: "7",
        cy: "17",
        r: "2",
        key: "u2ysq9"
    }],
    ["path", {
        d: "M9 17h6",
        key: "r8uit2"
    }],
    ["circle", {
        cx: "17",
        cy: "17",
        r: "2",
        key: "axvx0g"
    }]
]);
/**
 * @license lucide-vue-next v0.363.0 - ISC
 *
 * This source code is licensed under the ISC license.
 * See the LICENSE file in the root directory of this source tree.
 */
const jl = Re("CreditCardIcon", [
    ["rect", {
        width: "20",
        height: "14",
        x: "2",
        y: "5",
        rx: "2",
        key: "ynyp8z"
    }],
    ["line", {
        x1: "2",
        x2: "22",
        y1: "10",
        y2: "10",
        key: "1b3vmo"
    }]
]);
/**
 * @license lucide-vue-next v0.363.0 - ISC
 *
 * This source code is licensed under the ISC license.
 * See the LICENSE file in the root directory of this source tree.
 */
const Dl = Re("HistoryIcon", [
    ["path", {
        d: "M3 12a9 9 0 1 0 9-9 9.75 9.75 0 0 0-6.74 2.74L3 8",
        key: "1357e3"
    }],
    ["path", {
        d: "M3 3v5h5",
        key: "1xhq8a"
    }],
    ["path", {
        d: "M12 7v5l4 2",
        key: "1fdv2h"
    }]
]);
/**
 * @license lucide-vue-next v0.363.0 - ISC
 *
 * This source code is licensed under the ISC license.
 * See the LICENSE file in the root directory of this source tree.
 */
const Bl = Re("HomeIcon", [
    ["path", {
        d: "m3 9 9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z",
        key: "y5dka4"
    }],
    ["polyline", {
        points: "9 22 9 12 15 12 15 22",
        key: "e2us08"
    }]
]);
/**
 * @license lucide-vue-next v0.363.0 - ISC
 *
 * This source code is licensed under the ISC license.
 * See the LICENSE file in the root directory of this source tree.
 */
const Ho = Re("LandmarkIcon", [
    ["line", {
        x1: "3",
        x2: "21",
        y1: "22",
        y2: "22",
        key: "j8o0r"
    }],
    ["line", {
        x1: "6",
        x2: "6",
        y1: "18",
        y2: "11",
        key: "10tf0k"
    }],
    ["line", {
        x1: "10",
        x2: "10",
        y1: "18",
        y2: "11",
        key: "54lgf6"
    }],
    ["line", {
        x1: "14",
        x2: "14",
        y1: "18",
        y2: "11",
        key: "380y"
    }],
    ["line", {
        x1: "18",
        x2: "18",
        y1: "18",
        y2: "11",
        key: "1kevvc"
    }],
    ["polygon", {
        points: "12 2 20 7 4 7",
        key: "jkujk7"
    }]
]);
/**
 * @license lucide-vue-next v0.363.0 - ISC
 *
 * This source code is licensed under the ISC license.
 * See the LICENSE file in the root directory of this source tree.
 */
const jo = Re("ScrollTextIcon", [
    ["path", {
        d: "M8 21h12a2 2 0 0 0 2-2v-2H10v2a2 2 0 1 1-4 0V5a2 2 0 1 0-4 0v3h4",
        key: "13a6an"
    }],
    ["path", {
        d: "M19 17V5a2 2 0 0 0-2-2H4",
        key: "zz82l3"
    }],
    ["path", {
        d: "M15 8h-5",
        key: "1khuty"
    }],
    ["path", {
        d: "M15 12h-5",
        key: "r7krc0"
    }]
]);
/**
 * @license lucide-vue-next v0.363.0 - ISC
 *
 * This source code is licensed under the ISC license.
 * See the LICENSE file in the root directory of this source tree.
 */
const Vl = Re("SquareArrowUpRightIcon", [
        ["rect", {
            width: "18",
            height: "18",
            x: "3",
            y: "3",
            rx: "2",
            key: "afitv7"
        }],
        ["path", {
            d: "M8 8h8v8",
            key: "b65dnt"
        }],
        ["path", {
            d: "m8 16 8-8",
            key: "13b9ih"
        }]
    ]),
    be = (e, t) => {
        const n = e.__vccOpts || e;
        for (const [s, o] of t) n[s] = o;
        return n
    },
    Ul = {
        class: "list__item"
    },
    Kl = {
        class: "purpose"
    },
    ql = {
        class: "purpose__desc"
    },
    Gl = {
        class: "purpose__recipient"
    },
    Wl = {
        class: "info"
    },
    zl = {
        class: "info__date"
    },
    Jl = {
        __name: "HistoryItem",
        props: {
            item: {
                type: Object,
                required: !0
            }
        },
        setup(e) {
            /**
             * created_at title[Transferência/Fatura/Saque/Multas/Salário] sender_id transaction_type[1/2] description get * from history where user_id = passport
             */
            const t = ve(),
                n = e,
                s = Ve(() => {
                    const r = new Date(n.item.created_at),
                        c = r.getDate().toString().padStart(2, "0"),
                        l = (r.getMonth() + 1).toString().padStart(2, "0"),
                        f = r.getFullYear();
                    return `${c}/${l}/${f} ${r.getHours()}:${r.getMinutes()}`
                }),
                o = Ve(() => {
                    return n.item.title == "Transferência" || n.item.title == "Fatura" ? n.item.transaction_type == 1 ? "-" : "+" : n.item.transaction_type == 1 ? "-" : "+"
                }), 
                i = Ve(() => {
                    // let r = Number(n.item.sender_id) == Number(t.account.id);
                    let r = n.item.transaction_type == 1
                    if (n.item.transaction_type == 1) switch (n.item.title) {
                        case "Transferência":
                            // return `${r?"Para":"De"} ${n.item.description.split("|")[r?1:0]}`;
                            return `${r?"Para":"De"} ${n.item.description}`;
                        case "Fatura":
                            return `${r?"Pagou para":"Recebeu de"} ${n.item.description.split("|")[0]}`;
                        case "Saque":
                            return "NuBank";
                        case "Multas":
                            return "A Prefeitura agradece.";
                        default:
                            return n.item.description
                    } else if (n.item.transaction_type == 2) switch (n.item.title) {
                        case "Transferência":
                            // return `${r?"Para":"De"} ${n.item.description.split("|")[r?1:0]}`;
                            return `${r?"Para":"De"} ${n.item.description}`;
                        case "Fatura":
                            return `${r?"Pagou para":"Recebeu de"} ${n.item.description.split("|")[0]}`;
                        case "Depósito":
                            return "NuBank";
                        case "Salário":
                            return "Salário recebido";
                        default:
                            return n.item.description
                    } else return n.item.description
                });
            return (r, c) => (j(), X("div", Ul, [h("div", {
                class: Ie([{
                    in: o.value == "+",
                    out: o.value == "-"
                }, "icon"])
            }, [o.value == "+" ? (j(), Le(k(kl), {
                key: 0,
                size: 14,
                color: "green"
            })) : xs("", !0), o.value == "-" ? (j(), Le(k(Fl), {
                key: 1,
                size: 14,
                color: "red"
            })) : xs("", !0)], 2), h("div", Kl, [h("p", ql, J(e.item.title), 1), h("p", Gl, J(i.value), 1)]), h("div", Wl, [h("p", {
                class: Ie(["info__value", [{
                    in: o.value == "+",
                    out: o.value == "-"
                }]])
            }, J(r.BRLreal.format(e.item.amount)), 3), h("p", zl, J(s.value), 1)])]))
        }
    },
    Yl = be(Jl, [
        ["__scopeId", "data-v-577e9525"]
    ]),
    Zl = e => (Oe("data-v-4f1160ed"), e = e(), Fe(), e),
    Xl = {
        class: "general-section"
    },
    Ql = {
        class: "main"
    },
    ea = {
        class: "main__number"
    },
    ta = {
        class: "main__name"
    },
    na = {
        class: "main__balance"
    },
    sa = Zl(() => h("p", {
        class: "title"
    }, "Saldo da conta", -1)),
    oa = {
        class: "value"
    },
    ia = ["onClick"],
    ra = {
        class: "btn__icon"
    },
    ca = {
        class: "btn__text"
    },
    la = {
        class: "title"
    },
    aa = {
        class: "list"
    },
    ua = {
        style: {
            position: "relative"
        }
    },
    fa = {
        key: 0,
        class: "text"
    },
    da = {
        key: 1,
        class: "inner"
    },
    ha = {
        class: "inner__text"
    },
    pa = {
        __name: "GeneralSection",
        setup(e) {
            const t = ve(),
                {
                    setCurrentTab: n
                } = t,
                s = ie(!1),
                o = ie([{
                    title: "Transferir",
                    icon: Vl,
                    section: "TransferSection",
                    subsection: "GeneralSubsection"
                }, {
                    title: "Pagamentos",
                    icon: jl,
                    section: "ServicesSection",
                    subsection: "GeneralSubsection"
                }]);
            return (i, r) => (j(), X("div", Xl, [h("div", {
                class: Ie([{
                    hidden: s.value
                }, "general-section__card"])
            }, [h("div", Ql, [h("span", ea, J(k(t).account.id), 1), h("span", ta, J(k(t).account.name), 1), h("div", na, [sa, h("p", oa, J(i.BRLreal.format(k(t).balance)), 1)])])], 2), h("div", {
                class: Ie([{
                    hidden: s.value
                }, "general-section__actions"])
            }, [(j(!0), X(xe, null, Sn(o.value, (c, l) => (j(), X("button", {
                class: "btn",
                key: l,
                onClick: f => k(n)({
                    section: c.section,
                    subsection: c.subsection
                })
            }, [h("div", ra, [(j(), Le(vt(c.icon)))]), h("span", ca, J(c.title), 1)], 8, ia))), 128))], 2), h("div", {
                class: Ie([{
                    full: s.value
                }, "general-section__history"])
            }, [h("span", la, [Z(k(Dl), {
                size: 18
            }), ys("Transações ")]), h("div", aa, [h("div", ua, [(j(!0), X(xe, null, Sn(k(t).historyItems, (c, l) => (j(), Le(Yl, {
                key: l,
                item: c
            }, null, 8, ["item"]))), 128))])])], 2), h("button", {
                class: "general-section__btn",
                onClick: r[0] || (r[0] = c => s.value = !s.value)
            }, [s.value ? (j(), X("div", da, [h("span", ha, [Z(k(Rl), {
                color: "white",
                size: 15
            }), ys(" Colapsar ")])])) : (j(), X("span", fa, "Ver tudo"))])]))
        }
    },
    _a = be(pa, [
        ["__scopeId", "data-v-4f1160ed"]
    ]),
    Xt = "data:image/svg+xml,%3csvg%20width='32'%20height='32'%20viewBox='0%200%2032%2032'%20fill='none'%20xmlns='http://www.w3.org/2000/svg'%3e%3cpath%20d='M3.33331%205.33331H28.6666C30.5076%205.33331%2031.9999%206.82568%2031.9999%208.66662V23.3333C31.9999%2025.1742%2030.5076%2026.6666%2028.6666%2026.6666H3.33331C1.49237%2026.6667%200%2025.1743%200%2023.3333V8.66668C0%206.82568%201.49237%205.33331%203.33331%205.33331Z'%20fill='%2362E69F'/%3e%3cpath%20d='M32%209.3333H0V14.6666H32V9.3333Z'%20fill='%232798C6'/%3e%3cpath%20d='M10%2020H4.66669C4.2985%2020%204%2019.7015%204%2019.3333C4%2018.9651%204.2985%2018.6666%204.66669%2018.6666H10C10.3682%2018.6666%2010.6667%2018.9651%2010.6667%2019.3333C10.6667%2019.7015%2010.3682%2020%2010%2020Z'%20fill='%23FAFAFA'/%3e%3cpath%20d='M14%2022.6667H4.66669C4.2985%2022.6667%204%2022.3682%204%2022C4%2021.6318%204.2985%2021.3333%204.66669%2021.3333H14C14.3682%2021.3333%2014.6667%2021.6318%2014.6667%2022C14.6667%2022.3682%2014.3682%2022.6667%2014%2022.6667Z'%20fill='%23FAFAFA'/%3e%3c/svg%3e",
    Lt = e => (Oe("data-v-d8fd2e0c"), e = e(), Fe(), e),
    ma = {
        class: "general-subsection"
    },
    ga = {
        class: "general-subsection__header"
    },
    va = Lt(() => h("div", {
        class: "title"
    }, "Transferência", -1)),
    ba = {
        class: "general-subsection__cards"
    },
    ya = {
        class: "main"
    },
    xa = Lt(() => h("img", {
        src: Xt,
        alt: "card",
        class: "main__icon"
    }, null, -1)),
    $a = {
        class: "main__info"
    },
    Sa = Lt(() => h("p", {
        class: "desc"
    }, "Saldo na conta", -1)),
    Ca = {
        class: "value"
    },
    wa = {
        class: "recipient"
    },
    Ta = Lt(() => h("img", {
        src: Xt,
        alt: "card",
        class: "recipient__icon"
    }, null, -1)),
    Ia = {
        class: "recipient__infos"
    },
    Ea = {
        class: "recipient"
    },
    Ma = {
        class: "general-subsection__input"
    },
    Aa = Lt(() => h("span", {
        class: "title"
    }, "Insira o valor", -1)),
    Na = {
        class: "label"
    },
    Pa = Lt(() => h("p", {
        class: "desc"
    }, " Confira o nome da pessoa que está transferindo. Não nos responsabilizamos por transferências erradas. ", -1)),
    La = ["disabled"],
    Oa = {
        __name: "GeneralSubsection",
        props: {
            transferModel: {
                type: Object,
                required: !0
            }
        },
        emits: ["input"],
        setup(e, {
            emit: t
        }) {
            const n = ve(),
                {
                    setCurrentTab: s,
                    refreshData: o
                } = n,
                i = t,
                r = e,
                c = Ve({
                    get() {
                        return r.transferModel
                    },
                    set(S) {
                        i("input", S)
                    }
                }),
                l = ie(!1),
                f = ie(!1);
            async function d() {
                f.value || (m.value && (f.value = !0, (await fetchNui("banking:transferMoney", {
                    targetId: c.value.cardNumber,
                    amount: c.value.sum
                })).success == !0 ? (await o(), s({
                    section: n.currentTab.section,
                    subsection: "NotifySubsection"
                })) : (f.value = !1, l.value = !1, c.value.accountName = "Erro ao transferir")), f.value = !1)
            }
            async function p() {
                if (!(c.value.cardNumber == "" || c.value.cardNumber < 1)) {
                    l.value = !1, c.value.accountName = "Carregando Destinatário...";
                    try {
                        let S = await fetchNui("banking:getSenderInfo", c.value.cardNumber);
                        S.name !== void 0 ? (c.value.accountName = S.name, l.value = !0) : c.value.accountName = "Não encontrado"
                    } catch {
                        c.value.accountName = "Erro ao buscar destinatário", l.value = !1
                    }
                }
            }
            const m = Ve(() => c.value.sum && l.value && n.balance >= c.value.sum && n.account.id != c.value.cardNumber);
            return (S, N) => (j(), X("div", ma, [h("div", ga, [h("div", {
                class: "btn",
                onClick: N[0] || (N[0] = O => k(s)({
                    section: "GeneralSection"
                }))
            }, [Z(k(ze), {
                color: "white",
                size: 20
            })]), va]), h("div", ba, [h("div", ya, [xa, h("div", $a, [Sa, h("p", Ca, J(S.BRLreal.format(k(n).balance)), 1)])]), h("div", wa, [Ta, h("div", Ia, [jt(h("input", {
                type: "number",
                class: "recipient__input",
                placeholder: "Destinatário",
                "onUpdate:modelValue": N[1] || (N[1] = O => c.value.cardNumber = O),
                onChange: p
            }, null, 544), [
                [Ut, c.value.cardNumber]
            ])])]), h("div", Ea, [h("span", {
                class: Ie(["recipient__name", {
                    found: c.value.accountName,
                    "not-found": !c.value.accountName || c.value.accountName == "Não encontrado",
                    error: c.value.accountName == "Erro ao transferir"
                }])
            }, J(c.value.accountName || ""), 3)])]), h("div", Ma, [Aa, h("label", Na, [h("span", {
                class: Ie([{
                    active: c.value.sum
                }, "label__icon"])
            }, "R$", 2), jt(h("input", {
                type: "number",
                placeholder: "0",
                class: "label__field",
                "onUpdate:modelValue": N[2] || (N[2] = O => c.value.sum = O)
            }, null, 512), [
                [Ut, c.value.sum]
            ])]), Pa]), h("button", {
                class: Ie(["general-subsection__btn", [{
                    "general-subsection__btn__canTransfer": !m.value
                }]]),
                onClick: d,
                disabled: !m.value
            }, " Transferir ", 10, La)]))
        }
    },
    Fa = be(Oa, [
        ["__scopeId", "data-v-d8fd2e0c"]
    ]),
    Kn = "/ui/dist/assets/sucess_1-C3HIS-Wg.webm",
    Qt = e => (Oe("data-v-79dd8382"), e = e(), Fe(), e),
    Ra = {
        class: "notify-section"
    },
    ka = Qt(() => h("video", {
        src: Kn,
        type: "video/webm",
        autoplay: "",
        muted: "",
        loop: ""
    }, null, -1)),
    Ha = Qt(() => h("span", {
        class: "notify-section__title"
    }, "Transferência concluída", -1)),
    ja = {
        class: "notify-section__sum"
    },
    Da = {
        class: "notify-section__footer"
    },
    Ba = {
        class: "destintion"
    },
    Va = Qt(() => h("p", {
        class: "destintion__title"
    }, "Destinatário", -1)),
    Ua = Qt(() => h("span", {
        class: "destintion__desc"
    }, "Conta", -1)),
    Ka = {
        class: "destintion__value"
    },
    qa = Qt(() => h("span", {
        class: "destintion__desc"
    }, "Destinatário", -1)),
    Ga = {
        class: "destintion__name"
    },
    Wa = {
        __name: "NotifySubsection",
        props: {
            transferModel: {
                type: Object,
                required: !0
            }
        },
        setup(e) {
            const t = ve(),
                {
                    setCurrentTab: n
                } = t,
                s = e;
            return (o, i) => (j(), X("div", Ra, [ka, Ha, h("span", ja, J(o.BRLreal.format(s.transferModel.sum)), 1), h("div", Da, [h("div", Ba, [Va, Ua, h("p", Ka, J(s.transferModel.cardNumber), 1), qa, h("p", Ga, J(s.transferModel.accountName), 1)])]), h("div", {
                class: "btn",
                onClick: i[0] || (i[0] = r => k(n)({
                    section: "GeneralSection"
                }))
            }, [Z(k(ze))])]))
        }
    },
    za = be(Wa, [
        ["__scopeId", "data-v-79dd8382"]
    ]),
    Ja = {
        components: {
            GeneralSubsection: Fa,
            NotifySubsection: za
        },
        setup() {
            const e = ve(),
                {
                    currentTab: t
                } = Un(e),
                n = ie({
                    sum: "",
                    cardNumber: "",
                    accountName: ""
                });
            return {
                currentTab: t,
                transferModel: n
            }
        }
    },
    Ya = {
        class: "transfer-section"
    };

function Za(e, t, n, s, o, i) {
    return j(), X("div", Ya, [Z(Pt, {
        name: "transfer-section"
    }, {
        default: Yt(() => [(j(), Le(vt(s.currentTab.subsection), {
            transferModel: s.transferModel,
            onInput: t[0] || (t[0] = r => {
                s.transferModel = r
            })
        }, null, 40, ["transferModel"]))]),
        _: 1
    })])
}
const Xa = be(Ja, [
        ["render", Za],
        ["__scopeId", "data-v-09aa38b4"]
    ]),
    Qa = e => (Oe("data-v-0be0ddf0"), e = e(), Fe(), e),
    eu = {
        class: "general-subsection"
    },
    tu = {
        class: "general-subsection__header"
    },
    nu = Qa(() => h("div", {
        class: "title"
    }, "Pagamentos", -1)),
    su = {
        class: "general-subsection__main"
    },
    ou = ["onClick"],
    iu = {
        class: "item-filled__icon"
    },
    ru = {
        class: "item-filled__text"
    },
    cu = {
        key: 1,
        class: "item-empty"
    },
    lu = {
        class: "item-empty__icon"
    },
    au = {
        class: "item-empty__text"
    },
    uu = {
        __name: "GeneralSubsection",
        setup(e) {
            const t = ve(),
                {
                    setCurrentTab: n
                } = t;

            function s(i) {
                switch (i) {
                    case "createInvoices":
                    case "charge":
                        return !0;
                    case "house":
                        return t.houseTaxes > 0;
                    case "car":
                        return t.carTaxes > 0;
                    case "invoices":
                        return t.invoices.length > 0;
                    case "penalty":
                        return t.fines > 0;
                    case "tributes":
                        return t.tributes > 0
                }
                return !1
            }
            const o = ie([{
                text: "Criar fatura",
                iconName: "createInvoices",
                icon: jo,
                subsection: "InvoicesSubsection"
            }, {
                text: "Faturas",
                iconName: "invoices",
                icon: jo,
                subsection: "InvoicesListSubsection"
            }, {
                text: "Multas",
                iconName: "penalty",
                icon: Ho,
                subsection: "PenaltySubsection"
            }, {
                text: "Tributos",
                iconName: "tributes",
                icon: Ho,
                subsection: "TributesSubsection"
            }, {
                text: "Casas",
                iconName: "house",
                icon: Bl,
                subsection: "HouseSubsection"
            }, {
                text: "Carros",
                iconName: "car",
                icon: Hl,
                subsection: "CarSubsection"
            }]);
            return (i, r) => (j(), X("div", eu, [h("div", tu, [h("div", {
                class: "btn",
                onClick: r[0] || (r[0] = c => k(n)({
                    section: "GeneralSection"
                }))
            }, [Z(k(ze), {
                color: "white",
                size: 20
            })]), nu]), h("div", su, [(j(!0), X(xe, null, Sn(o.value, (c, l) => (j(), X("div", {
                class: "item",
                key: l
            }, [s(c.iconName) ? (j(), X("button", {
                key: 0,
                class: "item-filled",
                onClick: f => k(n)({
                    section: k(t).currentTab.section,
                    subsection: c.subsection
                })
            }, [h("div", iu, [(j(), Le(vt(c.icon), {
                color: "#fff"
            }))]), h("p", ru, J(c.text), 1)], 8, ou)) : (j(), X("div", cu, [h("div", lu, [(j(), Le(vt(c.icon), {
                color: "#cecece"
            }))]), h("p", au, J(c.text), 1)]))]))), 128))])]))
        }
    },
    fu = be(uu, [
        ["__scopeId", "data-v-0be0ddf0"]
    ]),
    Wi = e => (Oe("data-v-1348054f"), e = e(), Fe(), e),
    du = {
        class: "notify-section"
    },
    hu = Wi(() => h("video", {
        src: Kn,
        type: "video/webm",
        autoplay: "",
        muted: "",
        loop: ""
    }, null, -1)),
    pu = {
        class: "notify-section__title"
    },
    _u = {
        class: "notify-section__footer"
    },
    mu = {
        class: "destintion"
    },
    gu = Wi(() => h("p", {
        class: "destintion__title"
    }, "Total de multas pagas", -1)),
    vu = {
        class: "destintion__value"
    },
    bu = {
        __name: "NotifySubsection",
        props: {
            sumModel: {
                type: Object,
                required: !0
            }
        },
        setup(e) {
            const t = ve(),
                {
                    setCurrentTab: n
                } = t,
                s = e;
            return (o, i) => (j(), X("div", du, [hu, h("span", pu, "Pagamento realizado hoje, " + J(new Date().toLocaleDateString("pt-br")), 1), h("div", _u, [h("div", mu, [gu, h("p", vu, J(o.BRLreal.format(s.sumModel.amount)), 1)])]), h("div", {
                class: "btn",
                onClick: i[0] || (i[0] = r => k(n)({
                    section: "GeneralSection"
                }))
            }, [Z(k(ze))])]))
        }
    },
    yu = be(bu, [
        ["__scopeId", "data-v-1348054f"]
    ]),
    qn = e => (Oe("data-v-bb06617b"), e = e(), Fe(), e),
    xu = {
        class: "notify-section"
    },
    $u = qn(() => h("video", {
        src: Kn,
        type: "video/webm",
        autoplay: "",
        muted: "",
        loop: ""
    }, null, -1)),
    Su = qn(() => h("span", {
        class: "notify-section__title"
    }, "Fatura gerada com sucesso!", -1)),
    Cu = {
        class: "notify-section__sum"
    },
    wu = {
        class: "notify-section__footer"
    },
    Tu = {
        class: "destintion"
    },
    Iu = qn(() => h("p", {
        class: "destintion__name"
    }, "Destinatário", -1)),
    Eu = {
        class: "destintion__desc"
    },
    Mu = qn(() => h("p", {
        class: "destintion__name"
    }, "Descrição da fatura", -1)),
    Au = {
        class: "destintion__desc"
    },
    Nu = {
        __name: "NotifyInvoiceSubsection",
        props: {
            sumModel: {
                type: Object,
                required: !0
            }
        },
        setup(e) {
            const t = ve(),
                {
                    setCurrentTab: n
                } = t,
                s = e;
            return (o, i) => (j(), X("div", xu, [$u, Su, h("span", Cu, J(o.BRLreal.format(s.sumModel.amount)), 1), h("div", wu, [h("div", Tu, [Iu, h("span", Eu, J(s.sumModel.accountName), 1), Mu, h("p", Au, J(s.sumModel.description), 1)])]), h("div", {
                class: "btn",
                onClick: i[0] || (i[0] = r => k(n)({
                    section: k(t).currentTab.section,
                    subsection: "GeneralSubsection"
                }))
            }, [Z(k(ze))])]))
        }
    },
    Pu = be(Nu, [
        ["__scopeId", "data-v-bb06617b"]
    ]),
    Gn = e => (Oe("data-v-7cce0a2d"), e = e(), Fe(), e),
    Lu = {
        class: "notify-section"
    },
    Ou = Gn(() => h("video", {
        src: Kn,
        type: "video/webm",
        autoplay: "",
        muted: "",
        loop: ""
    }, null, -1)),
    Fu = Gn(() => h("span", {
        class: "notify-section__title"
    }, "Fatura paga com sucesso!", -1)),
    Ru = {
        class: "notify-section__sum"
    },
    ku = {
        class: "notify-section__footer"
    },
    Hu = {
        class: "destintion"
    },
    ju = Gn(() => h("p", {
        class: "destintion__name"
    }, "Destinatário", -1)),
    Du = {
        class: "destintion__desc"
    },
    Bu = Gn(() => h("p", {
        class: "destintion__name"
    }, "Descrição da fatura", -1)),
    Vu = {
        class: "destintion__desc"
    },
    Uu = {
        __name: "NotifyInvoicePaySubsection",
        props: {
            sumModel: {
                type: Object,
                required: !0
            }
        },
        setup(e) {
            const t = ve(),
                {
                    setCurrentTab: n
                } = t,
                s = e;
            return (o, i) => (j(), X("div", Lu, [Ou, Fu, h("span", Ru, J(o.BRLreal.format(s.sumModel.amount)), 1), h("div", ku, [h("div", Hu, [ju, h("span", Du, J(s.sumModel.accountName), 1), Bu, h("p", Vu, J(s.sumModel.description), 1)])]), h("div", {
                class: "btn",
                onClick: i[0] || (i[0] = r => k(n)({
                    section: k(t).currentTab.section,
                    subsection: "InvoicesListSubsection"
                }))
            }, [Z(k(ze))])]))
        }
    },
    Ku = be(Uu, [
        ["__scopeId", "data-v-7cce0a2d"]
    ]),
    en = e => (Oe("data-v-d9f44951"), e = e(), Fe(), e),
    qu = {
        class: "general-subsection"
    },
    Gu = {
        class: "general-subsection__header"
    },
    Wu = en(() => h("div", {
        class: "title"
    }, "Pagar multas", -1)),
    zu = {
        class: "general-subsection__cards"
    },
    Ju = {
        class: "main"
    },
    Yu = en(() => h("img", {
        src: Xt,
        alt: "card",
        class: "main__icon"
    }, null, -1)),
    Zu = {
        class: "main__info"
    },
    Xu = en(() => h("p", {
        class: "desc"
    }, "Saldo na conta", -1)),
    Qu = {
        class: "value"
    },
    ef = {
        class: "general-subsection__input"
    },
    tf = en(() => h("span", {
        class: "title"
    }, "Multas no total de", -1)),
    nf = {
        class: "label"
    },
    sf = {
        class: "label__field"
    },
    of = en(() => h("p", {
        class: "desc"
    }, "Para não reconhecimento de multas, procure um agente da lei.", -1)),
    rf = {
        __name: "PenaltySubsection",
        props: {
            sumModel: {
                type: Object,
                required: !0
            }
        },
        emits: ["input"],
        setup(e, {
            emit: t
        }) {
            const n = ve(),
                {
                    setCurrentTab: s,
                    refreshData: o
                } = n,
                i = t,
                r = e,
                c = Ve({
                    get() {
                        return r.sumModel
                    },
                    set(d) {
                        i("input", d)
                    }
                }),
                l = ie(!1);
            async function f() {
                if (n.fines <= 0 || n.balance < n.fines || l.value) return;
                l.value = !0, (await fetchNui("banking:payFines")).success == !0 ? (c.value.amount = n.fines, await o(), l.value = !1, s({
                    section: n.currentTab.section,
                    subsection: "NotifySubsection"
                })) : (l.value = !1, s({
                    section: "GeneralSection"
                }))
            }
            return (d, p) => (j(), X("div", qu, [h("div", Gu, [h("div", {
                class: "btn",
                onClick: p[0] || (p[0] = m => k(s)({
                    section: k(n).currentTab.section,
                    subsection: "GeneralSubsection"
                }))
            }, [Z(k(ze), {
                color: "white",
                size: 20
            })]), Wu]), h("div", zu, [h("div", Ju, [Yu, h("div", Zu, [Xu, h("p", Qu, J(d.BRLreal.format(k(n).balance)), 1)])])]), h("div", ef, [tf, h("label", nf, [h("span", sf, J(d.BRLreal.format(k(n).fines)), 1)]), of]), h("button", {
                class: "general-subsection__btn",
                onClick: f
            }, "Pagar")]))
        }
    },
    cf = be(rf, [
        ["__scopeId", "data-v-d9f44951"]
    ]),
    tn = e => (Oe("data-v-7e692832"), e = e(), Fe(), e),
    lf = {
        class: "general-subsection"
    },
    af = {
        class: "general-subsection__header"
    },
    uf = tn(() => h("div", {
        class: "title"
    }, "Gerar fatura", -1)),
    ff = {
        class: "general-subsection__cards"
    },
    df = {
        class: "recipient"
    },
    hf = tn(() => h("img", {
        src: Xt,
        alt: "card",
        class: "recipient__icon"
    }, null, -1)),
    pf = {
        class: "recipient__infos"
    },
    _f = {
        class: "recipient"
    },
    mf = {
        class: "general-subsection__input"
    },
    gf = tn(() => h("span", {
        class: "title"
    }, "Insira o valor", -1)),
    vf = {
        class: "label"
    },
    bf = tn(() => h("span", {
        class: "label__icon"
    }, "R$", -1)),
    yf = tn(() => h("p", {
        class: "desc"
    }, "Atente-se a pessoa que você irá gerar a fatura, erros não serão reembolsáveis.", -1)),
    xf = {
        __name: "InvoicesSubsection",
        props: {
            sumModel: {
                type: Object,
                required: !0
            }
        },
        emits: ["input"],
        setup(e, {
            emit: t
        }) {
            const n = ve(),
                {
                    setCurrentTab: s,
                    refreshData: o
                } = n,
                i = t,
                r = e,
                c = Ve({
                    get() {
                        return r.sumModel
                    },
                    set(d) {
                        i("input", d)
                    }
                }),
                l = ie(!1);
            async function f() {
                if (c.value.amount <= 0 || c.value.id <= 0 || c.value.description.length <= 0 || c.value.amount > n.balance || l.value) return;
                l.value = !0;
                let d = await fetchNui("banking:generateInvoice", {
                    id: c.value.id,
                    description: c.value.description,
                    amount: c.value.amount
                });
                d.success == !0 ? (l.value = !1, c.value.accountName = d.accountName || "", await o(), s({
                    section: n.currentTab.section,
                    subsection: "NotifyInvoiceSubsection"
                })) : (l.value = !1, s({
                    section: "GeneralSection"
                }))
            }
            return (d, p) => (j(), X("div", lf, [h("div", af, [h("div", {
                class: "btn",
                onClick: p[0] || (p[0] = m => k(s)({
                    section: k(n).currentTab.section,
                    subsection: "GeneralSubsection"
                }))
            }, [Z(k(ze), {
                color: "white",
                size: 20
            })]), uf]), h("div", ff, [h("div", df, [hf, h("div", pf, [jt(h("input", {
                type: "number",
                class: "recipient__input",
                "onUpdate:modelValue": p[1] || (p[1] = m => c.value.id = m),
                placeholder: "Para quem vai a fatura?"
            }, null, 512), [
                [Ut, c.value.id]
            ])])]), h("div", _f, [jt(h("textarea", {
                class: "recipient__textarea",
                placeholder: "Descrição da fatura",
                "onUpdate:modelValue": p[2] || (p[2] = m => c.value.description = m)
            }, null, 512), [
                [Ut, c.value.description]
            ])])]), h("div", mf, [gf, h("label", vf, [bf, jt(h("input", {
                type: "number",
                placeholder: "0",
                "onUpdate:modelValue": p[3] || (p[3] = m => c.value.amount = m),
                class: "label__field"
            }, null, 512), [
                [Ut, c.value.amount]
            ])]), yf]), h("button", {
                class: "general-subsection__btn",
                onClick: f
            }, "Gerar Fatura")]))
        }
    },
    $f = be(xf, [
        ["__scopeId", "data-v-7e692832"]
    ]),
    Ot = e => (Oe("data-v-0d735c0a"), e = e(), Fe(), e),
    Sf = {
        class: "general-subsection"
    },
    Cf = {
        class: "general-subsection__header"
    },
    wf = Ot(() => h("div", {
        class: "title"
    }, "Pagar Faturas", -1)),
    Tf = {
        class: "general-subsection__cards"
    },
    If = {
        class: "main"
    },
    Ef = Ot(() => h("img", {
        src: Xt,
        alt: "card",
        class: "main__icon"
    }, null, -1)),
    Mf = {
        class: "main__info"
    },
    Af = Ot(() => h("p", {
        class: "desc"
    }, "Saldo na conta", -1)),
    Nf = {
        class: "value"
    },
    Pf = {
        class: "general-subsection__cards"
    },
    Lf = {
        class: "list"
    },
    Of = ["item"],
    Ff = {
        class: "fatura-info"
    },
    Rf = Ot(() => h("p", {
        class: "title"
    }, "Valor da fatura", -1)),
    kf = Ot(() => h("p", {
        class: "title"
    }, "Descrição", -1)),
    Hf = Ot(() => h("p", {
        class: "title"
    }, "Gerada por:", -1)),
    jf = ["onClick"],
    Df = {
        __name: "InvoicesListSubsection",
        props: {
            sumModel: {
                type: Object,
                required: !0
            }
        },
        emits: ["input"],
        setup(e, {
            emit: t
        }) {
            const n = ve(),
                {
                    setCurrentTab: s,
                    refreshData: o
                } = n,
                i = t,
                r = e,
                c = Ve({
                    get() {
                        return r.sumModel
                    },
                    set(d) {
                        i("input", d)
                    }
                }),
                l = ie(!1);
            async function f(d) {
                const p = n.invoices.find(S => S.id === d);
                if (!p || n.balance < p.value || l.value) return;
                l.value = !0, (await fetchNui("banking:payInvoice", {
                    invoiceId: d
                })).success == !0 ? (l.value = !1, c.value.accountName = p.payee_name || "", c.value.amount = p.amount, c.value.description = p.description, await o(), s({
                    section: n.currentTab.section,
                    subsection: "NotifyInvoicePaySubsection"
                })) : (l.value = !1, s({
                    section: "GeneralSection"
                }))
            }
            return (d, p) => (j(), X("div", Sf, [h("div", Cf, [h("div", {
                class: "btn",
                onClick: p[0] || (p[0] = m => k(s)({
                    section: k(n).currentTab.section,
                    subsection: "GeneralSubsection"
                }))
            }, [Z(k(ze), {
                color: "white",
                size: 20
            })]), wf]), h("div", Tf, [h("div", If, [Ef, h("div", Mf, [Af, h("p", Nf, J(d.BRLreal.format(k(n).balance)), 1)])])]), h("div", Pf, [h("div", Lf, [(j(!0), X(xe, null, Sn(k(n).invoices, (m, S) => (j(), X("div", {
                class: "fatura-card",
                key: S,
                item: m
            }, [h("div", Ff, [Rf, h("span", null, J(d.BRLreal.format(m.amount)), 1), kf, h("span", null, J(m.description), 1), Hf, h("span", null, J(m.payee_name), 1)]), h("button", {
                class: "btn",
                onClick: N => f(m.id)
            }, "Pagar", 8, jf)], 8, Of))), 128))])])]))
        }
    },
    Bf = be(Df, [
        ["__scopeId", "data-v-0d735c0a"]
    ]),
    Vf = {
        components: {
            GeneralSubsection: fu,
            NotifySubsection: yu,
            NotifyInvoiceSubsection: Pu,
            PenaltySubsection: cf,
            InvoicesSubsection: $f,
            InvoicesListSubsection: Bf,
            NotifyInvoicePaySubsection: Ku
        },
        setup() {
            const e = ve(),
                {
                    currentTab: t
                } = Un(e),
                n = ie({
                    amount: 0,
                    id: 0,
                    description: "",
                    accountName: ""
                });
            return {
                currentTab: t,
                sumModel: n
            }
        }
    },
    Uf = {
        class: "services-section"
    };

function Kf(e, t, n, s, o, i) {
    return j(), X("div", Uf, [Z(Pt, {
        name: "services-section"
    }, {
        default: Yt(() => [(j(), Le(vt(s.currentTab.subsection), {
            sumModel: s.sumModel,
            onInput: t[0] || (t[0] = r => {
                s.sumModel = r
            })
        }, null, 40, ["sumModel"]))]),
        _: 1
    })])
}
const qf = be(Vf, [
        ["render", Kf],
        ["__scopeId", "data-v-e82877d0"]
    ]),
    Gf = {
        components: {
            GeneralSection: _a,
            TransferSection: Xa,
            ServicesSection: qf
        },
        setup() {
            const e = ve(),
                {
                    currentTab: t
                } = Un(e);
            return {
                currentTab: t
            }
        }
    },
    Wf = {
        class: "main-content"
    };

function zf(e, t, n, s, o, i) {
    return j(), X("div", Wf, [Z(Pt, {
        name: "main-content"
    }, {
        default: Yt(() => [(j(), Le(vt(s.currentTab.section)))]),
        _: 1
    })])
}
const Jf = be(Gf, [
        ["render", zf],
        ["__scopeId", "data-v-934cb4c4"]
    ]),
    Yf = "/ui/dist/assets/logo-animated-ClPlQEcg.webm",
    Zf = {},
    Xf = e => (Oe("data-v-86b732e2"), e = e(), Fe(), e),
    Qf = {
        class: "preloader-content"
    },
    ed = Xf(() => h("video", {
        class: "preloader-content__video",
        src: Yf,
        type: "video/webm",
        autoplay: "",
        muted: "",
        loop: ""
    }, null, -1)),
    td = [ed];

function nd(e, t) {
    return j(), X("div", Qf, td)
}
const sd = be(Zf, [
        ["render", nd],
        ["__scopeId", "data-v-86b732e2"]
    ]),
    od = {
        class: "app-wrapper"
    },
    id = {
        __name: "App",
        setup(e) {
            const t = ve(),
                {
                    preLoading: n
                } = Un(t),
                {
                    setPreloading: s,
                    setCurrentTab: o,
                    refreshData: i
                } = t,
                r = !window.invokeNative,
                c = ie(!1);
            return (window.name === "" || r) && Ds(() => {
                r ? (c.value = !0, setTimeout(() => {
                    s(!1), o({
                        section: "GeneralSection"
                    })
                }, 2e3)) : window.addEventListener("message", async l => {
                    l.data === "componentsLoaded" && (c.value = !0, await i(), s(!1), o({
                        section: "GeneralSection",
                        subsection: ""
                    }))
                })
            }), (l, f) => c.value ? (j(), X("div", {
                key: 0,
                class: Ie(["app", [r ? "dev-wrapper" : ""]])
            }, [h("div", od, [Z(Pt, {
                name: "app-wrapper"
            }, {
                default: Yt(() => [(j(), Le(vt(k(n) ? sd : Jf)))]),
                _: 1
            })])], 2)) : xs("", !0)
        }
    },
    Ks = Sl(id),
    rd = new Intl.NumberFormat("pt-BR", {
        style: "currency",
        currency: "BRL",
        minimumFractionDigits: 2,
        maximumFractionDigits: 2
    });
Ks.config.globalProperties.BRLreal = rd;
Ks.use(Il());
Ks.mount("#app");