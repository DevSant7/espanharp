var lp = Object.defineProperty;
var op = (e, t, n) => t in e ? lp(e, t, {
   enumerable: !0,
   configurable: !0,
   writable: !0,
   value: n
}) : e[t] = n;
var lt = (e, t, n) => op(e, typeof t != "symbol" ? t + "" : t, n);
(function () {
   const t = document.createElement("link").relList;
   if (t && t.supports && t.supports("modulepreload")) return;
   for (const l of document.querySelectorAll('link[rel="modulepreload"]')) r(l);
   new MutationObserver(l => {
      for (const o of l)
         if (o.type === "childList")
            for (const i of o.addedNodes) i.tagName === "LINK" && i.rel === "modulepreload" && r(i)
   }).observe(document, {
      childList: !0,
      subtree: !0
   });

   function n(l) {
      const o = {};
      return l.integrity && (o.integrity = l.integrity), l.referrerPolicy && (o.referrerPolicy = l.referrerPolicy), l.crossOrigin === "use-credentials" ? o.credentials = "include" : l.crossOrigin === "anonymous" ? o.credentials = "omit" : o.credentials = "same-origin", o
   }

   function r(l) {
      if (l.ep) return;
      l.ep = !0;
      const o = n(l);
      fetch(l.href, o)
   }
})();

function rc(e) {
   return e && e.__esModule && Object.prototype.hasOwnProperty.call(e, "default") ? e.default : e
}
var lc = {
      exports: {}
   },
   go = {},
   oc = {
      exports: {}
   },
   M = {};
/**
 * @license React
 * react.production.min.js
 *
 * Copyright (c) Facebook, Inc. and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */
var Gr = Symbol.for("react.element"),
   ip = Symbol.for("react.portal"),
   up = Symbol.for("react.fragment"),
   sp = Symbol.for("react.strict_mode"),
   ap = Symbol.for("react.profiler"),
   cp = Symbol.for("react.provider"),
   fp = Symbol.for("react.context"),
   dp = Symbol.for("react.forward_ref"),
   pp = Symbol.for("react.suspense"),
   hp = Symbol.for("react.memo"),
   vp = Symbol.for("react.lazy"),
   Os = Symbol.iterator;

function mp(e) {
   return e === null || typeof e != "object" ? null : (e = Os && e[Os] || e["@@iterator"], typeof e == "function" ? e : null)
}
var ic = {
      isMounted: function () {
         return !1
      },
      enqueueForceUpdate: function () {},
      enqueueReplaceState: function () {},
      enqueueSetState: function () {}
   },
   uc = Object.assign,
   sc = {};

function Gn(e, t, n) {
   this.props = e, this.context = t, this.refs = sc, this.updater = n || ic
}
Gn.prototype.isReactComponent = {};
Gn.prototype.setState = function (e, t) {
   if (typeof e != "object" && typeof e != "function" && e != null) throw Error("setState(...): takes an object of state variables to update or a function which returns an object of state variables.");
   this.updater.enqueueSetState(this, e, t, "setState")
};
Gn.prototype.forceUpdate = function (e) {
   this.updater.enqueueForceUpdate(this, e, "forceUpdate")
};

function ac() {}
ac.prototype = Gn.prototype;

function gu(e, t, n) {
   this.props = e, this.context = t, this.refs = sc, this.updater = n || ic
}
var yu = gu.prototype = new ac;
yu.constructor = gu;
uc(yu, Gn.prototype);
yu.isPureReactComponent = !0;
var zs = Array.isArray,
   cc = Object.prototype.hasOwnProperty,
   wu = {
      current: null
   },
   fc = {
      key: !0,
      ref: !0,
      __self: !0,
      __source: !0
   };

function dc(e, t, n) {
   var r, l = {},
      o = null,
      i = null;
   if (t != null)
      for (r in t.ref !== void 0 && (i = t.ref), t.key !== void 0 && (o = "" + t.key), t) cc.call(t, r) && !fc.hasOwnProperty(r) && (l[r] = t[r]);
   var u = arguments.length - 2;
   if (u === 1) l.children = n;
   else if (1 < u) {
      for (var s = Array(u), a = 0; a < u; a++) s[a] = arguments[a + 2];
      l.children = s
   }
   if (e && e.defaultProps)
      for (r in u = e.defaultProps, u) l[r] === void 0 && (l[r] = u[r]);
   return {
      $$typeof: Gr,
      type: e,
      key: o,
      ref: i,
      props: l,
      _owner: wu.current
   }
}

function gp(e, t) {
   return {
      $$typeof: Gr,
      type: e.type,
      key: t,
      ref: e.ref,
      props: e.props,
      _owner: e._owner
   }
}

function Su(e) {
   return typeof e == "object" && e !== null && e.$$typeof === Gr
}

function yp(e) {
   var t = {
      "=": "=0",
      ":": "=2"
   };
   return "$" + e.replace(/[=:]/g, function (n) {
      return t[n]
   })
}
var Ls = /\/+/g;

function Ho(e, t) {
   return typeof e == "object" && e !== null && e.key != null ? yp("" + e.key) : t.toString(36)
}

function Nl(e, t, n, r, l) {
   var o = typeof e;
   (o === "undefined" || o === "boolean") && (e = null);
   var i = !1;
   if (e === null) i = !0;
   else switch (o) {
      case "string":
      case "number":
         i = !0;
         break;
      case "object":
         switch (e.$$typeof) {
            case Gr:
            case ip:
               i = !0
         }
   }
   if (i) return i = e, l = l(i), e = r === "" ? "." + Ho(i, 0) : r, zs(l) ? (n = "", e != null && (n = e.replace(Ls, "$&/") + "/"), Nl(l, t, n, "", function (a) {
      return a
   })) : l != null && (Su(l) && (l = gp(l, n + (!l.key || i && i.key === l.key ? "" : ("" + l.key).replace(Ls, "$&/") + "/") + e)), t.push(l)), 1;
   if (i = 0, r = r === "" ? "." : r + ":", zs(e))
      for (var u = 0; u < e.length; u++) {
         o = e[u];
         var s = r + Ho(o, u);
         i += Nl(o, t, n, s, l)
      } else if (s = mp(e), typeof s == "function")
         for (e = s.call(e), u = 0; !(o = e.next()).done;) o = o.value, s = r + Ho(o, u++), i += Nl(o, t, n, s, l);
      else if (o === "object") throw t = String(e), Error("Objects are not valid as a React child (found: " + (t === "[object Object]" ? "object with keys {" + Object.keys(e).join(", ") + "}" : t) + "). If you meant to render a collection of children, use an array instead.");
   return i
}

function sl(e, t, n) {
   if (e == null) return e;
   var r = [],
      l = 0;
   return Nl(e, r, "", "", function (o) {
      return t.call(n, o, l++)
   }), r
}

function wp(e) {
   if (e._status === -1) {
      var t = e._result;
      t = t(), t.then(function (n) {
         (e._status === 0 || e._status === -1) && (e._status = 1, e._result = n)
      }, function (n) {
         (e._status === 0 || e._status === -1) && (e._status = 2, e._result = n)
      }), e._status === -1 && (e._status = 0, e._result = t)
   }
   if (e._status === 1) return e._result.default;
   throw e._result
}
var ye = {
      current: null
   },
   Dl = {
      transition: null
   },
   Sp = {
      ReactCurrentDispatcher: ye,
      ReactCurrentBatchConfig: Dl,
      ReactCurrentOwner: wu
   };

function pc() {
   throw Error("act(...) is not supported in production builds of React.")
}
M.Children = {
   map: sl,
   forEach: function (e, t, n) {
      sl(e, function () {
         t.apply(this, arguments)
      }, n)
   },
   count: function (e) {
      var t = 0;
      return sl(e, function () {
         t++
      }), t
   },
   toArray: function (e) {
      return sl(e, function (t) {
         return t
      }) || []
   },
   only: function (e) {
      if (!Su(e)) throw Error("React.Children.only expected to receive a single React element child.");
      return e
   }
};
M.Component = Gn;
M.Fragment = up;
M.Profiler = ap;
M.PureComponent = gu;
M.StrictMode = sp;
M.Suspense = pp;
M.__SECRET_INTERNALS_DO_NOT_USE_OR_YOU_WILL_BE_FIRED = Sp;
M.act = pc;
M.cloneElement = function (e, t, n) {
   if (e == null) throw Error("React.cloneElement(...): The argument must be a React element, but you passed " + e + ".");
   var r = uc({}, e.props),
      l = e.key,
      o = e.ref,
      i = e._owner;
   if (t != null) {
      if (t.ref !== void 0 && (o = t.ref, i = wu.current), t.key !== void 0 && (l = "" + t.key), e.type && e.type.defaultProps) var u = e.type.defaultProps;
      for (s in t) cc.call(t, s) && !fc.hasOwnProperty(s) && (r[s] = t[s] === void 0 && u !== void 0 ? u[s] : t[s])
   }
   var s = arguments.length - 2;
   if (s === 1) r.children = n;
   else if (1 < s) {
      u = Array(s);
      for (var a = 0; a < s; a++) u[a] = arguments[a + 2];
      r.children = u
   }
   return {
      $$typeof: Gr,
      type: e.type,
      key: l,
      ref: o,
      props: r,
      _owner: i
   }
};
M.createContext = function (e) {
   return e = {
      $$typeof: fp,
      _currentValue: e,
      _currentValue2: e,
      _threadCount: 0,
      Provider: null,
      Consumer: null,
      _defaultValue: null,
      _globalName: null
   }, e.Provider = {
      $$typeof: cp,
      _context: e
   }, e.Consumer = e
};
M.createElement = dc;
M.createFactory = function (e) {
   var t = dc.bind(null, e);
   return t.type = e, t
};
M.createRef = function () {
   return {
      current: null
   }
};
M.forwardRef = function (e) {
   return {
      $$typeof: dp,
      render: e
   }
};
M.isValidElement = Su;
M.lazy = function (e) {
   return {
      $$typeof: vp,
      _payload: {
         _status: -1,
         _result: e
      },
      _init: wp
   }
};
M.memo = function (e, t) {
   return {
      $$typeof: hp,
      type: e,
      compare: t === void 0 ? null : t
   }
};
M.startTransition = function (e) {
   var t = Dl.transition;
   Dl.transition = {};
   try {
      e()
   } finally {
      Dl.transition = t
   }
};
M.unstable_act = pc;
M.useCallback = function (e, t) {
   return ye.current.useCallback(e, t)
};
M.useContext = function (e) {
   return ye.current.useContext(e)
};
M.useDebugValue = function () {};
M.useDeferredValue = function (e) {
   return ye.current.useDeferredValue(e)
};
M.useEffect = function (e, t) {
   return ye.current.useEffect(e, t)
};
M.useId = function () {
   return ye.current.useId()
};
M.useImperativeHandle = function (e, t, n) {
   return ye.current.useImperativeHandle(e, t, n)
};
M.useInsertionEffect = function (e, t) {
   return ye.current.useInsertionEffect(e, t)
};
M.useLayoutEffect = function (e, t) {
   return ye.current.useLayoutEffect(e, t)
};
M.useMemo = function (e, t) {
   return ye.current.useMemo(e, t)
};
M.useReducer = function (e, t, n) {
   return ye.current.useReducer(e, t, n)
};
M.useRef = function (e) {
   return ye.current.useRef(e)
};
M.useState = function (e) {
   return ye.current.useState(e)
};
M.useSyncExternalStore = function (e, t, n) {
   return ye.current.useSyncExternalStore(e, t, n)
};
M.useTransition = function () {
   return ye.current.useTransition()
};
M.version = "18.3.1";
oc.exports = M;
var g = oc.exports;
const F = rc(g);
/**
 * @license React
 * react-jsx-runtime.production.min.js
 *
 * Copyright (c) Facebook, Inc. and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */
var xp = g,
   kp = Symbol.for("react.element"),
   Ep = Symbol.for("react.fragment"),
   Cp = Object.prototype.hasOwnProperty,
   Np = xp.__SECRET_INTERNALS_DO_NOT_USE_OR_YOU_WILL_BE_FIRED.ReactCurrentOwner,
   Dp = {
      key: !0,
      ref: !0,
      __self: !0,
      __source: !0
   };

function hc(e, t, n) {
   var r, l = {},
      o = null,
      i = null;
   n !== void 0 && (o = "" + n), t.key !== void 0 && (o = "" + t.key), t.ref !== void 0 && (i = t.ref);
   for (r in t) Cp.call(t, r) && !Dp.hasOwnProperty(r) && (l[r] = t[r]);
   if (e && e.defaultProps)
      for (r in t = e.defaultProps, t) l[r] === void 0 && (l[r] = t[r]);
   return {
      $$typeof: kp,
      type: e,
      key: o,
      ref: i,
      props: l,
      _owner: Np.current
   }
}
go.Fragment = Ep;
go.jsx = hc;
go.jsxs = hc;
lc.exports = go;
var R = lc.exports;
const Pr = () => !window.invokeNative,
   _p = () => {};
class Pp {
   constructor(t, n) {
      lt(this, "events");
      lt(this, "timer", 1e3);
      this.events = t, n && (this.timer = n), Pr() && this.startProcessing()
   }
   startProcessing() {
      this.events.forEach(t => {
         setTimeout(() => {
            this.handleEvent(t)
         }, this.timer)
      })
   }
   handleEvent(t) {
      console.log("Processing event:", t), setTimeout(() => {
         window.dispatchEvent(new MessageEvent("message", {
            data: {
               ...t
            }
         }))
      })
   }
}
const Rp = {},
   Ms = e => {
      let t;
      const n = new Set,
         r = (p, d) => {
            const v = typeof p == "function" ? p(t) : p;
            if (!Object.is(v, t)) {
               const m = t;
               t = d ?? (typeof v != "object" || v === null) ? v : Object.assign({}, t, v), n.forEach(w => w(t, m))
            }
         },
         l = () => t,
         s = {
            setState: r,
            getState: l,
            getInitialState: () => a,
            subscribe: p => (n.add(p), () => n.delete(p)),
            destroy: () => {
               (Rp ? "production" : void 0) !== "production" && console.warn("[DEPRECATED] The `destroy` method will be unsupported in a future version. Instead use unsubscribe function returned by subscribe. Everything will be garbage-collected if store is garbage-collected."), n.clear()
            }
         },
         a = t = e(r, l, s);
      return s
   },
   Tp = e => e ? Ms(e) : Ms;
var vc = {
      exports: {}
   },
   mc = {},
   gc = {
      exports: {}
   },
   yc = {};
/**
 * @license React
 * use-sync-external-store-shim.production.js
 *
 * Copyright (c) Meta Platforms, Inc. and affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */
var Bn = g;

function Op(e, t) {
   return e === t && (e !== 0 || 1 / e === 1 / t) || e !== e && t !== t
}
var zp = typeof Object.is == "function" ? Object.is : Op,
   Lp = Bn.useState,
   Mp = Bn.useEffect,
   jp = Bn.useLayoutEffect,
   Ip = Bn.useDebugValue;

function Fp(e, t) {
   var n = t(),
      r = Lp({
         inst: {
            value: n,
            getSnapshot: t
         }
      }),
      l = r[0].inst,
      o = r[1];
   return jp(function () {
      l.value = n, l.getSnapshot = t, Qo(l) && o({
         inst: l
      })
   }, [e, n, t]), Mp(function () {
      return Qo(l) && o({
         inst: l
      }), e(function () {
         Qo(l) && o({
            inst: l
         })
      })
   }, [e]), Ip(n), n
}

function Qo(e) {
   var t = e.getSnapshot;
   e = e.value;
   try {
      var n = t();
      return !zp(e, n)
   } catch {
      return !0
   }
}

function Ap(e, t) {
   return t()
}
var $p = typeof window > "u" || typeof window.document > "u" || typeof window.document.createElement > "u" ? Ap : Fp;
yc.useSyncExternalStore = Bn.useSyncExternalStore !== void 0 ? Bn.useSyncExternalStore : $p;
gc.exports = yc;
var Up = gc.exports;
/**
 * @license React
 * use-sync-external-store-shim/with-selector.production.js
 *
 * Copyright (c) Meta Platforms, Inc. and affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */
var yo = g,
   Bp = Up;

function Vp(e, t) {
   return e === t && (e !== 0 || 1 / e === 1 / t) || e !== e && t !== t
}
var Wp = typeof Object.is == "function" ? Object.is : Vp,
   Hp = Bp.useSyncExternalStore,
   Qp = yo.useRef,
   Kp = yo.useEffect,
   Yp = yo.useMemo,
   Xp = yo.useDebugValue;
mc.useSyncExternalStoreWithSelector = function (e, t, n, r, l) {
   var o = Qp(null);
   if (o.current === null) {
      var i = {
         hasValue: !1,
         value: null
      };
      o.current = i
   } else i = o.current;
   o = Yp(function () {
      function s(m) {
         if (!a) {
            if (a = !0, p = m, m = r(m), l !== void 0 && i.hasValue) {
               var w = i.value;
               if (l(w, m)) return d = w
            }
            return d = m
         }
         if (w = d, Wp(p, m)) return w;
         var y = r(m);
         return l !== void 0 && l(w, y) ? (p = m, w) : (p = m, d = y)
      }
      var a = !1,
         p, d, v = n === void 0 ? null : n;
      return [function () {
         return s(t())
      }, v === null ? void 0 : function () {
         return s(v())
      }]
   }, [t, n, r, l]);
   var u = Hp(e, o[0], o[1]);
   return Kp(function () {
      i.hasValue = !0, i.value = u
   }, [u]), Xp(u), u
};
vc.exports = mc;
var Gp = vc.exports;
const Zp = rc(Gp),
   wc = {},
   {
      useDebugValue: Jp
   } = F,
   {
      useSyncExternalStoreWithSelector: qp
   } = Zp;
let js = !1;
const bp = e => e;

function eh(e, t = bp, n) {
   (wc ? "production" : void 0) !== "production" && n && !js && (console.warn("[DEPRECATED] Use `createWithEqualityFn` instead of `create` or use `useStoreWithEqualityFn` instead of `useStore`. They can be imported from 'zustand/traditional'. https://github.com/pmndrs/zustand/discussions/1937"), js = !0);
   const r = qp(e.subscribe, e.getState, e.getServerState || e.getInitialState, t, n);
   return Jp(r), r
}
const Is = e => {
      (wc ? "production" : void 0) !== "production" && typeof e != "function" && console.warn("[DEPRECATED] Passing a vanilla store will be unsupported in a future version. Instead use `import { useStore } from 'zustand'`.");
      const t = typeof e == "function" ? Tp(e) : e,
         n = (r, l) => eh(t, r, l);
      return Object.assign(n, t), n
   },
   wo = e => e ? Is(e) : Is,
   Sc = wo(e => ({
      current: {
         slot: 0,
         show: !1
      },
      set: t => e({
         current: t
      })
   })),
   xc = wo(e => ({
      item: {},
      set: t => {
         e(typeof t == "function" ? n => ({
            item: t(n.item)
         }) : {
            item: t
         })
      }
   })),
   kc = wo(e => ({
      item: {},
      set: t => {
         e(typeof t == "function" ? n => ({
            item: t(n.item)
         }) : {
            item: t
         })
      }
   })),
   xu = wo(e => ({
      current: {
         name: "",
         image: "",
         id: 0,
         dollar: 0,
         bank: 0,
         weight: 0,
         maxWeight: 0,
         suitCaseWeight: 0,
         suitCaseMaxWeight: 0
      },
      set: t => e({
         current: t
      })
   }));
var Ec = {
      exports: {}
   },
   Me = {},
   Cc = {
      exports: {}
   },
   Nc = {};
/**
 * @license React
 * scheduler.production.min.js
 *
 * Copyright (c) Facebook, Inc. and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */
(function (e) {
   function t(_, O) {
      var L = _.length;
      _.push(O);
      e: for (; 0 < L;) {
         var H = L - 1 >>> 1,
            U = _[H];
         if (0 < l(U, O)) _[H] = O, _[L] = U, L = H;
         else break e
      }
   }

   function n(_) {
      return _.length === 0 ? null : _[0]
   }

   function r(_) {
      if (_.length === 0) return null;
      var O = _[0],
         L = _.pop();
      if (L !== O) {
         _[0] = L;
         e: for (var H = 0, U = _.length, Ke = U >>> 1; H < Ke;) {
            var Ie = 2 * (H + 1) - 1,
               hn = _[Ie],
               q = Ie + 1,
               Gt = _[q];
            if (0 > l(hn, L)) q < U && 0 > l(Gt, hn) ? (_[H] = Gt, _[q] = L, H = q) : (_[H] = hn, _[Ie] = L, H = Ie);
            else if (q < U && 0 > l(Gt, L)) _[H] = Gt, _[q] = L, H = q;
            else break e
         }
      }
      return O
   }

   function l(_, O) {
      var L = _.sortIndex - O.sortIndex;
      return L !== 0 ? L : _.id - O.id
   }
   if (typeof performance == "object" && typeof performance.now == "function") {
      var o = performance;
      e.unstable_now = function () {
         return o.now()
      }
   } else {
      var i = Date,
         u = i.now();
      e.unstable_now = function () {
         return i.now() - u
      }
   }
   var s = [],
      a = [],
      p = 1,
      d = null,
      v = 3,
      m = !1,
      w = !1,
      y = !1,
      D = typeof setTimeout == "function" ? setTimeout : null,
      f = typeof clearTimeout == "function" ? clearTimeout : null,
      c = typeof setImmediate < "u" ? setImmediate : null;
   typeof navigator < "u" && navigator.scheduling !== void 0 && navigator.scheduling.isInputPending !== void 0 && navigator.scheduling.isInputPending.bind(navigator.scheduling);

   function h(_) {
      for (var O = n(a); O !== null;) {
         if (O.callback === null) r(a);
         else if (O.startTime <= _) r(a), O.sortIndex = O.expirationTime, t(s, O);
         else break;
         O = n(a)
      }
   }

   function S(_) {
      if (y = !1, h(_), !w)
         if (n(s) !== null) w = !0, pn(x);
         else {
            var O = n(a);
            O !== null && De(S, O.startTime - _)
         }
   }

   function x(_, O) {
      w = !1, y && (y = !1, f(C), C = -1), m = !0;
      var L = v;
      try {
         for (h(O), d = n(s); d !== null && (!(d.expirationTime > O) || _ && !I());) {
            var H = d.callback;
            if (typeof H == "function") {
               d.callback = null, v = d.priorityLevel;
               var U = H(d.expirationTime <= O);
               O = e.unstable_now(), typeof U == "function" ? d.callback = U : d === n(s) && r(s), h(O)
            } else r(s);
            d = n(s)
         }
         if (d !== null) var Ke = !0;
         else {
            var Ie = n(a);
            Ie !== null && De(S, Ie.startTime - O), Ke = !1
         }
         return Ke
      } finally {
         d = null, v = L, m = !1
      }
   }
   var N = !1,
      E = null,
      C = -1,
      z = 5,
      T = -1;

   function I() {
      return !(e.unstable_now() - T < z)
   }

   function he() {
      if (E !== null) {
         var _ = e.unstable_now();
         T = _;
         var O = !0;
         try {
            O = E(!0, _)
         } finally {
            O ? ve() : (N = !1, E = null)
         }
      } else N = !1
   }
   var ve;
   if (typeof c == "function") ve = function () {
      c(he)
   };
   else if (typeof MessageChannel < "u") {
      var Qe = new MessageChannel,
         ll = Qe.port2;
      Qe.port1.onmessage = he, ve = function () {
         ll.postMessage(null)
      }
   } else ve = function () {
      D(he, 0)
   };

   function pn(_) {
      E = _, N || (N = !0, ve())
   }

   function De(_, O) {
      C = D(function () {
         _(e.unstable_now())
      }, O)
   }
   e.unstable_IdlePriority = 5, e.unstable_ImmediatePriority = 1, e.unstable_LowPriority = 4, e.unstable_NormalPriority = 3, e.unstable_Profiling = null, e.unstable_UserBlockingPriority = 2, e.unstable_cancelCallback = function (_) {
      _.callback = null
   }, e.unstable_continueExecution = function () {
      w || m || (w = !0, pn(x))
   }, e.unstable_forceFrameRate = function (_) {
      0 > _ || 125 < _ ? console.error("forceFrameRate takes a positive int between 0 and 125, forcing frame rates higher than 125 fps is not supported") : z = 0 < _ ? Math.floor(1e3 / _) : 5
   }, e.unstable_getCurrentPriorityLevel = function () {
      return v
   }, e.unstable_getFirstCallbackNode = function () {
      return n(s)
   }, e.unstable_next = function (_) {
      switch (v) {
         case 1:
         case 2:
         case 3:
            var O = 3;
            break;
         default:
            O = v
      }
      var L = v;
      v = O;
      try {
         return _()
      } finally {
         v = L
      }
   }, e.unstable_pauseExecution = function () {}, e.unstable_requestPaint = function () {}, e.unstable_runWithPriority = function (_, O) {
      switch (_) {
         case 1:
         case 2:
         case 3:
         case 4:
         case 5:
            break;
         default:
            _ = 3
      }
      var L = v;
      v = _;
      try {
         return O()
      } finally {
         v = L
      }
   }, e.unstable_scheduleCallback = function (_, O, L) {
      var H = e.unstable_now();
      switch (typeof L == "object" && L !== null ? (L = L.delay, L = typeof L == "number" && 0 < L ? H + L : H) : L = H, _) {
         case 1:
            var U = -1;
            break;
         case 2:
            U = 250;
            break;
         case 5:
            U = 1073741823;
            break;
         case 4:
            U = 1e4;
            break;
         default:
            U = 5e3
      }
      return U = L + U, _ = {
         id: p++,
         callback: O,
         priorityLevel: _,
         startTime: L,
         expirationTime: U,
         sortIndex: -1
      }, L > H ? (_.sortIndex = L, t(a, _), n(s) === null && _ === n(a) && (y ? (f(C), C = -1) : y = !0, De(S, L - H))) : (_.sortIndex = U, t(s, _), w || m || (w = !0, pn(x))), _
   }, e.unstable_shouldYield = I, e.unstable_wrapCallback = function (_) {
      var O = v;
      return function () {
         var L = v;
         v = O;
         try {
            return _.apply(this, arguments)
         } finally {
            v = L
         }
      }
   }
})(Nc);
Cc.exports = Nc;
var th = Cc.exports;
/**
 * @license React
 * react-dom.production.min.js
 *
 * Copyright (c) Facebook, Inc. and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */
var nh = g,
   Le = th;

function k(e) {
   for (var t = "https://reactjs.org/docs/error-decoder.html?invariant=" + e, n = 1; n < arguments.length; n++) t += "&args[]=" + encodeURIComponent(arguments[n]);
   return "Minified React error #" + e + "; visit " + t + " for the full message or use the non-minified dev environment for full errors and additional helpful warnings."
}
var Dc = new Set,
   Rr = {};

function fn(e, t) {
   Vn(e, t), Vn(e + "Capture", t)
}

function Vn(e, t) {
   for (Rr[e] = t, e = 0; e < t.length; e++) Dc.add(t[e])
}
var mt = !(typeof window > "u" || typeof window.document > "u" || typeof window.document.createElement > "u"),
   xi = Object.prototype.hasOwnProperty,
   rh = /^[:A-Z_a-z\u00C0-\u00D6\u00D8-\u00F6\u00F8-\u02FF\u0370-\u037D\u037F-\u1FFF\u200C-\u200D\u2070-\u218F\u2C00-\u2FEF\u3001-\uD7FF\uF900-\uFDCF\uFDF0-\uFFFD][:A-Z_a-z\u00C0-\u00D6\u00D8-\u00F6\u00F8-\u02FF\u0370-\u037D\u037F-\u1FFF\u200C-\u200D\u2070-\u218F\u2C00-\u2FEF\u3001-\uD7FF\uF900-\uFDCF\uFDF0-\uFFFD\-.0-9\u00B7\u0300-\u036F\u203F-\u2040]*$/,
   Fs = {},
   As = {};

function lh(e) {
   return xi.call(As, e) ? !0 : xi.call(Fs, e) ? !1 : rh.test(e) ? As[e] = !0 : (Fs[e] = !0, !1)
}

function oh(e, t, n, r) {
   if (n !== null && n.type === 0) return !1;
   switch (typeof t) {
      case "function":
      case "symbol":
         return !0;
      case "boolean":
         return r ? !1 : n !== null ? !n.acceptsBooleans : (e = e.toLowerCase().slice(0, 5), e !== "data-" && e !== "aria-");
      default:
         return !1
   }
}

function ih(e, t, n, r) {
   if (t === null || typeof t > "u" || oh(e, t, n, r)) return !0;
   if (r) return !1;
   if (n !== null) switch (n.type) {
      case 3:
         return !t;
      case 4:
         return t === !1;
      case 5:
         return isNaN(t);
      case 6:
         return isNaN(t) || 1 > t
   }
   return !1
}

function we(e, t, n, r, l, o, i) {
   this.acceptsBooleans = t === 2 || t === 3 || t === 4, this.attributeName = r, this.attributeNamespace = l, this.mustUseProperty = n, this.propertyName = e, this.type = t, this.sanitizeURL = o, this.removeEmptyString = i
}
var se = {};
"children dangerouslySetInnerHTML defaultValue defaultChecked innerHTML suppressContentEditableWarning suppressHydrationWarning style".split(" ").forEach(function (e) {
   se[e] = new we(e, 0, !1, e, null, !1, !1)
});
[
   ["acceptCharset", "accept-charset"],
   ["className", "class"],
   ["htmlFor", "for"],
   ["httpEquiv", "http-equiv"]
].forEach(function (e) {
   var t = e[0];
   se[t] = new we(t, 1, !1, e[1], null, !1, !1)
});
["contentEditable", "draggable", "spellCheck", "value"].forEach(function (e) {
   se[e] = new we(e, 2, !1, e.toLowerCase(), null, !1, !1)
});
["autoReverse", "externalResourcesRequired", "focusable", "preserveAlpha"].forEach(function (e) {
   se[e] = new we(e, 2, !1, e, null, !1, !1)
});
"allowFullScreen async autoFocus autoPlay controls default defer disabled disablePictureInPicture disableRemotePlayback formNoValidate hidden loop noModule noValidate open playsInline readOnly required reversed scoped seamless itemScope".split(" ").forEach(function (e) {
   se[e] = new we(e, 3, !1, e.toLowerCase(), null, !1, !1)
});
["checked", "multiple", "muted", "selected"].forEach(function (e) {
   se[e] = new we(e, 3, !0, e, null, !1, !1)
});
["capture", "download"].forEach(function (e) {
   se[e] = new we(e, 4, !1, e, null, !1, !1)
});
["cols", "rows", "size", "span"].forEach(function (e) {
   se[e] = new we(e, 6, !1, e, null, !1, !1)
});
["rowSpan", "start"].forEach(function (e) {
   se[e] = new we(e, 5, !1, e.toLowerCase(), null, !1, !1)
});
var ku = /[\-:]([a-z])/g;

function Eu(e) {
   return e[1].toUpperCase()
}
"accent-height alignment-baseline arabic-form baseline-shift cap-height clip-path clip-rule color-interpolation color-interpolation-filters color-profile color-rendering dominant-baseline enable-background fill-opacity fill-rule flood-color flood-opacity font-family font-size font-size-adjust font-stretch font-style font-variant font-weight glyph-name glyph-orientation-horizontal glyph-orientation-vertical horiz-adv-x horiz-origin-x image-rendering letter-spacing lighting-color marker-end marker-mid marker-start overline-position overline-thickness paint-order panose-1 pointer-events rendering-intent shape-rendering stop-color stop-opacity strikethrough-position strikethrough-thickness stroke-dasharray stroke-dashoffset stroke-linecap stroke-linejoin stroke-miterlimit stroke-opacity stroke-width text-anchor text-decoration text-rendering underline-position underline-thickness unicode-bidi unicode-range units-per-em v-alphabetic v-hanging v-ideographic v-mathematical vector-effect vert-adv-y vert-origin-x vert-origin-y word-spacing writing-mode xmlns:xlink x-height".split(" ").forEach(function (e) {
   var t = e.replace(ku, Eu);
   se[t] = new we(t, 1, !1, e, null, !1, !1)
});
"xlink:actuate xlink:arcrole xlink:role xlink:show xlink:title xlink:type".split(" ").forEach(function (e) {
   var t = e.replace(ku, Eu);
   se[t] = new we(t, 1, !1, e, "http://www.w3.org/1999/xlink", !1, !1)
});
["xml:base", "xml:lang", "xml:space"].forEach(function (e) {
   var t = e.replace(ku, Eu);
   se[t] = new we(t, 1, !1, e, "http://www.w3.org/XML/1998/namespace", !1, !1)
});
["tabIndex", "crossOrigin"].forEach(function (e) {
   se[e] = new we(e, 1, !1, e.toLowerCase(), null, !1, !1)
});
se.xlinkHref = new we("xlinkHref", 1, !1, "xlink:href", "http://www.w3.org/1999/xlink", !0, !1);
["src", "href", "action", "formAction"].forEach(function (e) {
   se[e] = new we(e, 1, !1, e.toLowerCase(), null, !0, !0)
});

function Cu(e, t, n, r) {
   var l = se.hasOwnProperty(t) ? se[t] : null;
   (l !== null ? l.type !== 0 : r || !(2 < t.length) || t[0] !== "o" && t[0] !== "O" || t[1] !== "n" && t[1] !== "N") && (ih(t, n, l, r) && (n = null), r || l === null ? lh(t) && (n === null ? e.removeAttribute(t) : e.setAttribute(t, "" + n)) : l.mustUseProperty ? e[l.propertyName] = n === null ? l.type === 3 ? !1 : "" : n : (t = l.attributeName, r = l.attributeNamespace, n === null ? e.removeAttribute(t) : (l = l.type, n = l === 3 || l === 4 && n === !0 ? "" : "" + n, r ? e.setAttributeNS(r, t, n) : e.setAttribute(t, n))))
}
var xt = nh.__SECRET_INTERNALS_DO_NOT_USE_OR_YOU_WILL_BE_FIRED,
   al = Symbol.for("react.element"),
   xn = Symbol.for("react.portal"),
   kn = Symbol.for("react.fragment"),
   Nu = Symbol.for("react.strict_mode"),
   ki = Symbol.for("react.profiler"),
   _c = Symbol.for("react.provider"),
   Pc = Symbol.for("react.context"),
   Du = Symbol.for("react.forward_ref"),
   Ei = Symbol.for("react.suspense"),
   Ci = Symbol.for("react.suspense_list"),
   _u = Symbol.for("react.memo"),
   Pt = Symbol.for("react.lazy"),
   Rc = Symbol.for("react.offscreen"),
   $s = Symbol.iterator;

function lr(e) {
   return e === null || typeof e != "object" ? null : (e = $s && e[$s] || e["@@iterator"], typeof e == "function" ? e : null)
}
var X = Object.assign,
   Ko;

function dr(e) {
   if (Ko === void 0) try {
      throw Error()
   } catch (n) {
      var t = n.stack.trim().match(/\n( *(at )?)/);
      Ko = t && t[1] || ""
   }
   return `
` + Ko + e
}
var Yo = !1;

function Xo(e, t) {
   if (!e || Yo) return "";
   Yo = !0;
   var n = Error.prepareStackTrace;
   Error.prepareStackTrace = void 0;
   try {
      if (t)
         if (t = function () {
               throw Error()
            }, Object.defineProperty(t.prototype, "props", {
               set: function () {
                  throw Error()
               }
            }), typeof Reflect == "object" && Reflect.construct) {
            try {
               Reflect.construct(t, [])
            } catch (a) {
               var r = a
            }
            Reflect.construct(e, [], t)
         } else {
            try {
               t.call()
            } catch (a) {
               r = a
            }
            e.call(t.prototype)
         }
      else {
         try {
            throw Error()
         } catch (a) {
            r = a
         }
         e()
      }
   } catch (a) {
      if (a && r && typeof a.stack == "string") {
         for (var l = a.stack.split(`
`), o = r.stack.split(`
`), i = l.length - 1, u = o.length - 1; 1 <= i && 0 <= u && l[i] !== o[u];) u--;
         for (; 1 <= i && 0 <= u; i--, u--)
            if (l[i] !== o[u]) {
               if (i !== 1 || u !== 1)
                  do
                     if (i--, u--, 0 > u || l[i] !== o[u]) {
                        var s = `
` + l[i].replace(" at new ", " at ");
                        return e.displayName && s.includes("<anonymous>") && (s = s.replace("<anonymous>", e.displayName)), s
                     } while (1 <= i && 0 <= u);
               break
            }
      }
   } finally {
      Yo = !1, Error.prepareStackTrace = n
   }
   return (e = e ? e.displayName || e.name : "") ? dr(e) : ""
}

function uh(e) {
   switch (e.tag) {
      case 5:
         return dr(e.type);
      case 16:
         return dr("Lazy");
      case 13:
         return dr("Suspense");
      case 19:
         return dr("SuspenseList");
      case 0:
      case 2:
      case 15:
         return e = Xo(e.type, !1), e;
      case 11:
         return e = Xo(e.type.render, !1), e;
      case 1:
         return e = Xo(e.type, !0), e;
      default:
         return ""
   }
}

function Ni(e) {
   if (e == null) return null;
   if (typeof e == "function") return e.displayName || e.name || null;
   if (typeof e == "string") return e;
   switch (e) {
      case kn:
         return "Fragment";
      case xn:
         return "Portal";
      case ki:
         return "Profiler";
      case Nu:
         return "StrictMode";
      case Ei:
         return "Suspense";
      case Ci:
         return "SuspenseList"
   }
   if (typeof e == "object") switch (e.$$typeof) {
      case Pc:
         return (e.displayName || "Context") + ".Consumer";
      case _c:
         return (e._context.displayName || "Context") + ".Provider";
      case Du:
         var t = e.render;
         return e = e.displayName, e || (e = t.displayName || t.name || "", e = e !== "" ? "ForwardRef(" + e + ")" : "ForwardRef"), e;
      case _u:
         return t = e.displayName || null, t !== null ? t : Ni(e.type) || "Memo";
      case Pt:
         t = e._payload, e = e._init;
         try {
            return Ni(e(t))
         } catch {}
   }
   return null
}

function sh(e) {
   var t = e.type;
   switch (e.tag) {
      case 24:
         return "Cache";
      case 9:
         return (t.displayName || "Context") + ".Consumer";
      case 10:
         return (t._context.displayName || "Context") + ".Provider";
      case 18:
         return "DehydratedFragment";
      case 11:
         return e = t.render, e = e.displayName || e.name || "", t.displayName || (e !== "" ? "ForwardRef(" + e + ")" : "ForwardRef");
      case 7:
         return "Fragment";
      case 5:
         return t;
      case 4:
         return "Portal";
      case 3:
         return "Root";
      case 6:
         return "Text";
      case 16:
         return Ni(t);
      case 8:
         return t === Nu ? "StrictMode" : "Mode";
      case 22:
         return "Offscreen";
      case 12:
         return "Profiler";
      case 21:
         return "Scope";
      case 13:
         return "Suspense";
      case 19:
         return "SuspenseList";
      case 25:
         return "TracingMarker";
      case 1:
      case 0:
      case 17:
      case 2:
      case 14:
      case 15:
         if (typeof t == "function") return t.displayName || t.name || null;
         if (typeof t == "string") return t
   }
   return null
}

function Ht(e) {
   switch (typeof e) {
      case "boolean":
      case "number":
      case "string":
      case "undefined":
         return e;
      case "object":
         return e;
      default:
         return ""
   }
}

function Tc(e) {
   var t = e.type;
   return (e = e.nodeName) && e.toLowerCase() === "input" && (t === "checkbox" || t === "radio")
}

function ah(e) {
   var t = Tc(e) ? "checked" : "value",
      n = Object.getOwnPropertyDescriptor(e.constructor.prototype, t),
      r = "" + e[t];
   if (!e.hasOwnProperty(t) && typeof n < "u" && typeof n.get == "function" && typeof n.set == "function") {
      var l = n.get,
         o = n.set;
      return Object.defineProperty(e, t, {
         configurable: !0,
         get: function () {
            return l.call(this)
         },
         set: function (i) {
            r = "" + i, o.call(this, i)
         }
      }), Object.defineProperty(e, t, {
         enumerable: n.enumerable
      }), {
         getValue: function () {
            return r
         },
         setValue: function (i) {
            r = "" + i
         },
         stopTracking: function () {
            e._valueTracker = null, delete e[t]
         }
      }
   }
}

function cl(e) {
   e._valueTracker || (e._valueTracker = ah(e))
}

function Oc(e) {
   if (!e) return !1;
   var t = e._valueTracker;
   if (!t) return !0;
   var n = t.getValue(),
      r = "";
   return e && (r = Tc(e) ? e.checked ? "true" : "false" : e.value), e = r, e !== n ? (t.setValue(e), !0) : !1
}

function Al(e) {
   if (e = e || (typeof document < "u" ? document : void 0), typeof e > "u") return null;
   try {
      return e.activeElement || e.body
   } catch {
      return e.body
   }
}

function Di(e, t) {
   var n = t.checked;
   return X({}, t, {
      defaultChecked: void 0,
      defaultValue: void 0,
      value: void 0,
      checked: n ?? e._wrapperState.initialChecked
   })
}

function Us(e, t) {
   var n = t.defaultValue == null ? "" : t.defaultValue,
      r = t.checked != null ? t.checked : t.defaultChecked;
   n = Ht(t.value != null ? t.value : n), e._wrapperState = {
      initialChecked: r,
      initialValue: n,
      controlled: t.type === "checkbox" || t.type === "radio" ? t.checked != null : t.value != null
   }
}

function zc(e, t) {
   t = t.checked, t != null && Cu(e, "checked", t, !1)
}

function _i(e, t) {
   zc(e, t);
   var n = Ht(t.value),
      r = t.type;
   if (n != null) r === "number" ? (n === 0 && e.value === "" || e.value != n) && (e.value = "" + n) : e.value !== "" + n && (e.value = "" + n);
   else if (r === "submit" || r === "reset") {
      e.removeAttribute("value");
      return
   }
   t.hasOwnProperty("value") ? Pi(e, t.type, n) : t.hasOwnProperty("defaultValue") && Pi(e, t.type, Ht(t.defaultValue)), t.checked == null && t.defaultChecked != null && (e.defaultChecked = !!t.defaultChecked)
}

function Bs(e, t, n) {
   if (t.hasOwnProperty("value") || t.hasOwnProperty("defaultValue")) {
      var r = t.type;
      if (!(r !== "submit" && r !== "reset" || t.value !== void 0 && t.value !== null)) return;
      t = "" + e._wrapperState.initialValue, n || t === e.value || (e.value = t), e.defaultValue = t
   }
   n = e.name, n !== "" && (e.name = ""), e.defaultChecked = !!e._wrapperState.initialChecked, n !== "" && (e.name = n)
}

function Pi(e, t, n) {
   (t !== "number" || Al(e.ownerDocument) !== e) && (n == null ? e.defaultValue = "" + e._wrapperState.initialValue : e.defaultValue !== "" + n && (e.defaultValue = "" + n))
}
var pr = Array.isArray;

function Mn(e, t, n, r) {
   if (e = e.options, t) {
      t = {};
      for (var l = 0; l < n.length; l++) t["$" + n[l]] = !0;
      for (n = 0; n < e.length; n++) l = t.hasOwnProperty("$" + e[n].value), e[n].selected !== l && (e[n].selected = l), l && r && (e[n].defaultSelected = !0)
   } else {
      for (n = "" + Ht(n), t = null, l = 0; l < e.length; l++) {
         if (e[l].value === n) {
            e[l].selected = !0, r && (e[l].defaultSelected = !0);
            return
         }
         t !== null || e[l].disabled || (t = e[l])
      }
      t !== null && (t.selected = !0)
   }
}

function Ri(e, t) {
   if (t.dangerouslySetInnerHTML != null) throw Error(k(91));
   return X({}, t, {
      value: void 0,
      defaultValue: void 0,
      children: "" + e._wrapperState.initialValue
   })
}

function Vs(e, t) {
   var n = t.value;
   if (n == null) {
      if (n = t.children, t = t.defaultValue, n != null) {
         if (t != null) throw Error(k(92));
         if (pr(n)) {
            if (1 < n.length) throw Error(k(93));
            n = n[0]
         }
         t = n
      }
      t == null && (t = ""), n = t
   }
   e._wrapperState = {
      initialValue: Ht(n)
   }
}

function Lc(e, t) {
   var n = Ht(t.value),
      r = Ht(t.defaultValue);
   n != null && (n = "" + n, n !== e.value && (e.value = n), t.defaultValue == null && e.defaultValue !== n && (e.defaultValue = n)), r != null && (e.defaultValue = "" + r)
}

function Ws(e) {
   var t = e.textContent;
   t === e._wrapperState.initialValue && t !== "" && t !== null && (e.value = t)
}

function Mc(e) {
   switch (e) {
      case "svg":
         return "http://www.w3.org/2000/svg";
      case "math":
         return "http://www.w3.org/1998/Math/MathML";
      default:
         return "http://www.w3.org/1999/xhtml"
   }
}

function Ti(e, t) {
   return e == null || e === "http://www.w3.org/1999/xhtml" ? Mc(t) : e === "http://www.w3.org/2000/svg" && t === "foreignObject" ? "http://www.w3.org/1999/xhtml" : e
}
var fl, jc = function (e) {
   return typeof MSApp < "u" && MSApp.execUnsafeLocalFunction ? function (t, n, r, l) {
      MSApp.execUnsafeLocalFunction(function () {
         return e(t, n, r, l)
      })
   } : e
}(function (e, t) {
   if (e.namespaceURI !== "http://www.w3.org/2000/svg" || "innerHTML" in e) e.innerHTML = t;
   else {
      for (fl = fl || document.createElement("div"), fl.innerHTML = "<svg>" + t.valueOf().toString() + "</svg>", t = fl.firstChild; e.firstChild;) e.removeChild(e.firstChild);
      for (; t.firstChild;) e.appendChild(t.firstChild)
   }
});

function Tr(e, t) {
   if (t) {
      var n = e.firstChild;
      if (n && n === e.lastChild && n.nodeType === 3) {
         n.nodeValue = t;
         return
      }
   }
   e.textContent = t
}
var mr = {
      animationIterationCount: !0,
      aspectRatio: !0,
      borderImageOutset: !0,
      borderImageSlice: !0,
      borderImageWidth: !0,
      boxFlex: !0,
      boxFlexGroup: !0,
      boxOrdinalGroup: !0,
      columnCount: !0,
      columns: !0,
      flex: !0,
      flexGrow: !0,
      flexPositive: !0,
      flexShrink: !0,
      flexNegative: !0,
      flexOrder: !0,
      gridArea: !0,
      gridRow: !0,
      gridRowEnd: !0,
      gridRowSpan: !0,
      gridRowStart: !0,
      gridColumn: !0,
      gridColumnEnd: !0,
      gridColumnSpan: !0,
      gridColumnStart: !0,
      fontWeight: !0,
      lineClamp: !0,
      lineHeight: !0,
      opacity: !0,
      order: !0,
      orphans: !0,
      tabSize: !0,
      widows: !0,
      zIndex: !0,
      zoom: !0,
      fillOpacity: !0,
      floodOpacity: !0,
      stopOpacity: !0,
      strokeDasharray: !0,
      strokeDashoffset: !0,
      strokeMiterlimit: !0,
      strokeOpacity: !0,
      strokeWidth: !0
   },
   ch = ["Webkit", "ms", "Moz", "O"];
Object.keys(mr).forEach(function (e) {
   ch.forEach(function (t) {
      t = t + e.charAt(0).toUpperCase() + e.substring(1), mr[t] = mr[e]
   })
});

function Ic(e, t, n) {
   return t == null || typeof t == "boolean" || t === "" ? "" : n || typeof t != "number" || t === 0 || mr.hasOwnProperty(e) && mr[e] ? ("" + t).trim() : t + "px"
}

function Fc(e, t) {
   e = e.style;
   for (var n in t)
      if (t.hasOwnProperty(n)) {
         var r = n.indexOf("--") === 0,
            l = Ic(n, t[n], r);
         n === "float" && (n = "cssFloat"), r ? e.setProperty(n, l) : e[n] = l
      }
}
var fh = X({
   menuitem: !0
}, {
   area: !0,
   base: !0,
   br: !0,
   col: !0,
   embed: !0,
   hr: !0,
   img: !0,
   input: !0,
   keygen: !0,
   link: !0,
   meta: !0,
   param: !0,
   source: !0,
   track: !0,
   wbr: !0
});

function Oi(e, t) {
   if (t) {
      if (fh[e] && (t.children != null || t.dangerouslySetInnerHTML != null)) throw Error(k(137, e));
      if (t.dangerouslySetInnerHTML != null) {
         if (t.children != null) throw Error(k(60));
         if (typeof t.dangerouslySetInnerHTML != "object" || !("__html" in t.dangerouslySetInnerHTML)) throw Error(k(61))
      }
      if (t.style != null && typeof t.style != "object") throw Error(k(62))
   }
}

function zi(e, t) {
   if (e.indexOf("-") === -1) return typeof t.is == "string";
   switch (e) {
      case "annotation-xml":
      case "color-profile":
      case "font-face":
      case "font-face-src":
      case "font-face-uri":
      case "font-face-format":
      case "font-face-name":
      case "missing-glyph":
         return !1;
      default:
         return !0
   }
}
var Li = null;

function Pu(e) {
   return e = e.target || e.srcElement || window, e.correspondingUseElement && (e = e.correspondingUseElement), e.nodeType === 3 ? e.parentNode : e
}
var Mi = null,
   jn = null,
   In = null;

function Hs(e) {
   if (e = qr(e)) {
      if (typeof Mi != "function") throw Error(k(280));
      var t = e.stateNode;
      t && (t = Co(t), Mi(e.stateNode, e.type, t))
   }
}

function Ac(e) {
   jn ? In ? In.push(e) : In = [e] : jn = e
}

function $c() {
   if (jn) {
      var e = jn,
         t = In;
      if (In = jn = null, Hs(e), t)
         for (e = 0; e < t.length; e++) Hs(t[e])
   }
}

function Uc(e, t) {
   return e(t)
}

function Bc() {}
var Go = !1;

function Vc(e, t, n) {
   if (Go) return e(t, n);
   Go = !0;
   try {
      return Uc(e, t, n)
   } finally {
      Go = !1, (jn !== null || In !== null) && (Bc(), $c())
   }
}

function Or(e, t) {
   var n = e.stateNode;
   if (n === null) return null;
   var r = Co(n);
   if (r === null) return null;
   n = r[t];
   e: switch (t) {
      case "onClick":
      case "onClickCapture":
      case "onDoubleClick":
      case "onDoubleClickCapture":
      case "onMouseDown":
      case "onMouseDownCapture":
      case "onMouseMove":
      case "onMouseMoveCapture":
      case "onMouseUp":
      case "onMouseUpCapture":
      case "onMouseEnter":
         (r = !r.disabled) || (e = e.type, r = !(e === "button" || e === "input" || e === "select" || e === "textarea")), e = !r;
         break e;
      default:
         e = !1
   }
   if (e) return null;
   if (n && typeof n != "function") throw Error(k(231, t, typeof n));
   return n
}
var ji = !1;
if (mt) try {
   var or = {};
   Object.defineProperty(or, "passive", {
      get: function () {
         ji = !0
      }
   }), window.addEventListener("test", or, or), window.removeEventListener("test", or, or)
} catch {
   ji = !1
}

function dh(e, t, n, r, l, o, i, u, s) {
   var a = Array.prototype.slice.call(arguments, 3);
   try {
      t.apply(n, a)
   } catch (p) {
      this.onError(p)
   }
}
var gr = !1,
   $l = null,
   Ul = !1,
   Ii = null,
   ph = {
      onError: function (e) {
         gr = !0, $l = e
      }
   };

function hh(e, t, n, r, l, o, i, u, s) {
   gr = !1, $l = null, dh.apply(ph, arguments)
}

function vh(e, t, n, r, l, o, i, u, s) {
   if (hh.apply(this, arguments), gr) {
      if (gr) {
         var a = $l;
         gr = !1, $l = null
      } else throw Error(k(198));
      Ul || (Ul = !0, Ii = a)
   }
}

function dn(e) {
   var t = e,
      n = e;
   if (e.alternate)
      for (; t.return;) t = t.return;
   else {
      e = t;
      do t = e, t.flags & 4098 && (n = t.return), e = t.return; while (e)
   }
   return t.tag === 3 ? n : null
}

function Wc(e) {
   if (e.tag === 13) {
      var t = e.memoizedState;
      if (t === null && (e = e.alternate, e !== null && (t = e.memoizedState)), t !== null) return t.dehydrated
   }
   return null
}

function Qs(e) {
   if (dn(e) !== e) throw Error(k(188))
}

function mh(e) {
   var t = e.alternate;
   if (!t) {
      if (t = dn(e), t === null) throw Error(k(188));
      return t !== e ? null : e
   }
   for (var n = e, r = t;;) {
      var l = n.return;
      if (l === null) break;
      var o = l.alternate;
      if (o === null) {
         if (r = l.return, r !== null) {
            n = r;
            continue
         }
         break
      }
      if (l.child === o.child) {
         for (o = l.child; o;) {
            if (o === n) return Qs(l), e;
            if (o === r) return Qs(l), t;
            o = o.sibling
         }
         throw Error(k(188))
      }
      if (n.return !== r.return) n = l, r = o;
      else {
         for (var i = !1, u = l.child; u;) {
            if (u === n) {
               i = !0, n = l, r = o;
               break
            }
            if (u === r) {
               i = !0, r = l, n = o;
               break
            }
            u = u.sibling
         }
         if (!i) {
            for (u = o.child; u;) {
               if (u === n) {
                  i = !0, n = o, r = l;
                  break
               }
               if (u === r) {
                  i = !0, r = o, n = l;
                  break
               }
               u = u.sibling
            }
            if (!i) throw Error(k(189))
         }
      }
      if (n.alternate !== r) throw Error(k(190))
   }
   if (n.tag !== 3) throw Error(k(188));
   return n.stateNode.current === n ? e : t
}

function Hc(e) {
   return e = mh(e), e !== null ? Qc(e) : null
}

function Qc(e) {
   if (e.tag === 5 || e.tag === 6) return e;
   for (e = e.child; e !== null;) {
      var t = Qc(e);
      if (t !== null) return t;
      e = e.sibling
   }
   return null
}
var Kc = Le.unstable_scheduleCallback,
   Ks = Le.unstable_cancelCallback,
   gh = Le.unstable_shouldYield,
   yh = Le.unstable_requestPaint,
   Z = Le.unstable_now,
   wh = Le.unstable_getCurrentPriorityLevel,
   Ru = Le.unstable_ImmediatePriority,
   Yc = Le.unstable_UserBlockingPriority,
   Bl = Le.unstable_NormalPriority,
   Sh = Le.unstable_LowPriority,
   Xc = Le.unstable_IdlePriority,
   So = null,
   st = null;

function xh(e) {
   if (st && typeof st.onCommitFiberRoot == "function") try {
      st.onCommitFiberRoot(So, e, void 0, (e.current.flags & 128) === 128)
   } catch {}
}
var qe = Math.clz32 ? Math.clz32 : Ch,
   kh = Math.log,
   Eh = Math.LN2;

function Ch(e) {
   return e >>>= 0, e === 0 ? 32 : 31 - (kh(e) / Eh | 0) | 0
}
var dl = 64,
   pl = 4194304;

function hr(e) {
   switch (e & -e) {
      case 1:
         return 1;
      case 2:
         return 2;
      case 4:
         return 4;
      case 8:
         return 8;
      case 16:
         return 16;
      case 32:
         return 32;
      case 64:
      case 128:
      case 256:
      case 512:
      case 1024:
      case 2048:
      case 4096:
      case 8192:
      case 16384:
      case 32768:
      case 65536:
      case 131072:
      case 262144:
      case 524288:
      case 1048576:
      case 2097152:
         return e & 4194240;
      case 4194304:
      case 8388608:
      case 16777216:
      case 33554432:
      case 67108864:
         return e & 130023424;
      case 134217728:
         return 134217728;
      case 268435456:
         return 268435456;
      case 536870912:
         return 536870912;
      case 1073741824:
         return 1073741824;
      default:
         return e
   }
}

function Vl(e, t) {
   var n = e.pendingLanes;
   if (n === 0) return 0;
   var r = 0,
      l = e.suspendedLanes,
      o = e.pingedLanes,
      i = n & 268435455;
   if (i !== 0) {
      var u = i & ~l;
      u !== 0 ? r = hr(u) : (o &= i, o !== 0 && (r = hr(o)))
   } else i = n & ~l, i !== 0 ? r = hr(i) : o !== 0 && (r = hr(o));
   if (r === 0) return 0;
   if (t !== 0 && t !== r && !(t & l) && (l = r & -r, o = t & -t, l >= o || l === 16 && (o & 4194240) !== 0)) return t;
   if (r & 4 && (r |= n & 16), t = e.entangledLanes, t !== 0)
      for (e = e.entanglements, t &= r; 0 < t;) n = 31 - qe(t), l = 1 << n, r |= e[n], t &= ~l;
   return r
}

function Nh(e, t) {
   switch (e) {
      case 1:
      case 2:
      case 4:
         return t + 250;
      case 8:
      case 16:
      case 32:
      case 64:
      case 128:
      case 256:
      case 512:
      case 1024:
      case 2048:
      case 4096:
      case 8192:
      case 16384:
      case 32768:
      case 65536:
      case 131072:
      case 262144:
      case 524288:
      case 1048576:
      case 2097152:
         return t + 5e3;
      case 4194304:
      case 8388608:
      case 16777216:
      case 33554432:
      case 67108864:
         return -1;
      case 134217728:
      case 268435456:
      case 536870912:
      case 1073741824:
         return -1;
      default:
         return -1
   }
}

function Dh(e, t) {
   for (var n = e.suspendedLanes, r = e.pingedLanes, l = e.expirationTimes, o = e.pendingLanes; 0 < o;) {
      var i = 31 - qe(o),
         u = 1 << i,
         s = l[i];
      s === -1 ? (!(u & n) || u & r) && (l[i] = Nh(u, t)) : s <= t && (e.expiredLanes |= u), o &= ~u
   }
}

function Fi(e) {
   return e = e.pendingLanes & -1073741825, e !== 0 ? e : e & 1073741824 ? 1073741824 : 0
}

function Gc() {
   var e = dl;
   return dl <<= 1, !(dl & 4194240) && (dl = 64), e
}

function Zo(e) {
   for (var t = [], n = 0; 31 > n; n++) t.push(e);
   return t
}

function Zr(e, t, n) {
   e.pendingLanes |= t, t !== 536870912 && (e.suspendedLanes = 0, e.pingedLanes = 0), e = e.eventTimes, t = 31 - qe(t), e[t] = n
}

function _h(e, t) {
   var n = e.pendingLanes & ~t;
   e.pendingLanes = t, e.suspendedLanes = 0, e.pingedLanes = 0, e.expiredLanes &= t, e.mutableReadLanes &= t, e.entangledLanes &= t, t = e.entanglements;
   var r = e.eventTimes;
   for (e = e.expirationTimes; 0 < n;) {
      var l = 31 - qe(n),
         o = 1 << l;
      t[l] = 0, r[l] = -1, e[l] = -1, n &= ~o
   }
}

function Tu(e, t) {
   var n = e.entangledLanes |= t;
   for (e = e.entanglements; n;) {
      var r = 31 - qe(n),
         l = 1 << r;
      l & t | e[r] & t && (e[r] |= t), n &= ~l
   }
}
var A = 0;

function Zc(e) {
   return e &= -e, 1 < e ? 4 < e ? e & 268435455 ? 16 : 536870912 : 4 : 1
}
var Jc, Ou, qc, bc, ef, Ai = !1,
   hl = [],
   It = null,
   Ft = null,
   At = null,
   zr = new Map,
   Lr = new Map,
   Ot = [],
   Ph = "mousedown mouseup touchcancel touchend touchstart auxclick dblclick pointercancel pointerdown pointerup dragend dragstart drop compositionend compositionstart keydown keypress keyup input textInput copy cut paste click change contextmenu reset submit".split(" ");

function Ys(e, t) {
   switch (e) {
      case "focusin":
      case "focusout":
         It = null;
         break;
      case "dragenter":
      case "dragleave":
         Ft = null;
         break;
      case "mouseover":
      case "mouseout":
         At = null;
         break;
      case "pointerover":
      case "pointerout":
         zr.delete(t.pointerId);
         break;
      case "gotpointercapture":
      case "lostpointercapture":
         Lr.delete(t.pointerId)
   }
}

function ir(e, t, n, r, l, o) {
   return e === null || e.nativeEvent !== o ? (e = {
      blockedOn: t,
      domEventName: n,
      eventSystemFlags: r,
      nativeEvent: o,
      targetContainers: [l]
   }, t !== null && (t = qr(t), t !== null && Ou(t)), e) : (e.eventSystemFlags |= r, t = e.targetContainers, l !== null && t.indexOf(l) === -1 && t.push(l), e)
}

function Rh(e, t, n, r, l) {
   switch (t) {
      case "focusin":
         return It = ir(It, e, t, n, r, l), !0;
      case "dragenter":
         return Ft = ir(Ft, e, t, n, r, l), !0;
      case "mouseover":
         return At = ir(At, e, t, n, r, l), !0;
      case "pointerover":
         var o = l.pointerId;
         return zr.set(o, ir(zr.get(o) || null, e, t, n, r, l)), !0;
      case "gotpointercapture":
         return o = l.pointerId, Lr.set(o, ir(Lr.get(o) || null, e, t, n, r, l)), !0
   }
   return !1
}

function tf(e) {
   var t = en(e.target);
   if (t !== null) {
      var n = dn(t);
      if (n !== null) {
         if (t = n.tag, t === 13) {
            if (t = Wc(n), t !== null) {
               e.blockedOn = t, ef(e.priority, function () {
                  qc(n)
               });
               return
            }
         } else if (t === 3 && n.stateNode.current.memoizedState.isDehydrated) {
            e.blockedOn = n.tag === 3 ? n.stateNode.containerInfo : null;
            return
         }
      }
   }
   e.blockedOn = null
}

function _l(e) {
   if (e.blockedOn !== null) return !1;
   for (var t = e.targetContainers; 0 < t.length;) {
      var n = $i(e.domEventName, e.eventSystemFlags, t[0], e.nativeEvent);
      if (n === null) {
         n = e.nativeEvent;
         var r = new n.constructor(n.type, n);
         Li = r, n.target.dispatchEvent(r), Li = null
      } else return t = qr(n), t !== null && Ou(t), e.blockedOn = n, !1;
      t.shift()
   }
   return !0
}

function Xs(e, t, n) {
   _l(e) && n.delete(t)
}

function Th() {
   Ai = !1, It !== null && _l(It) && (It = null), Ft !== null && _l(Ft) && (Ft = null), At !== null && _l(At) && (At = null), zr.forEach(Xs), Lr.forEach(Xs)
}

function ur(e, t) {
   e.blockedOn === t && (e.blockedOn = null, Ai || (Ai = !0, Le.unstable_scheduleCallback(Le.unstable_NormalPriority, Th)))
}

function Mr(e) {
   function t(l) {
      return ur(l, e)
   }
   if (0 < hl.length) {
      ur(hl[0], e);
      for (var n = 1; n < hl.length; n++) {
         var r = hl[n];
         r.blockedOn === e && (r.blockedOn = null)
      }
   }
   for (It !== null && ur(It, e), Ft !== null && ur(Ft, e), At !== null && ur(At, e), zr.forEach(t), Lr.forEach(t), n = 0; n < Ot.length; n++) r = Ot[n], r.blockedOn === e && (r.blockedOn = null);
   for (; 0 < Ot.length && (n = Ot[0], n.blockedOn === null);) tf(n), n.blockedOn === null && Ot.shift()
}
var Fn = xt.ReactCurrentBatchConfig,
   Wl = !0;

function Oh(e, t, n, r) {
   var l = A,
      o = Fn.transition;
   Fn.transition = null;
   try {
      A = 1, zu(e, t, n, r)
   } finally {
      A = l, Fn.transition = o
   }
}

function zh(e, t, n, r) {
   var l = A,
      o = Fn.transition;
   Fn.transition = null;
   try {
      A = 4, zu(e, t, n, r)
   } finally {
      A = l, Fn.transition = o
   }
}

function zu(e, t, n, r) {
   if (Wl) {
      var l = $i(e, t, n, r);
      if (l === null) ii(e, t, r, Hl, n), Ys(e, r);
      else if (Rh(l, e, t, n, r)) r.stopPropagation();
      else if (Ys(e, r), t & 4 && -1 < Ph.indexOf(e)) {
         for (; l !== null;) {
            var o = qr(l);
            if (o !== null && Jc(o), o = $i(e, t, n, r), o === null && ii(e, t, r, Hl, n), o === l) break;
            l = o
         }
         l !== null && r.stopPropagation()
      } else ii(e, t, r, null, n)
   }
}
var Hl = null;

function $i(e, t, n, r) {
   if (Hl = null, e = Pu(r), e = en(e), e !== null)
      if (t = dn(e), t === null) e = null;
      else if (n = t.tag, n === 13) {
      if (e = Wc(t), e !== null) return e;
      e = null
   } else if (n === 3) {
      if (t.stateNode.current.memoizedState.isDehydrated) return t.tag === 3 ? t.stateNode.containerInfo : null;
      e = null
   } else t !== e && (e = null);
   return Hl = e, null
}

function nf(e) {
   switch (e) {
      case "cancel":
      case "click":
      case "close":
      case "contextmenu":
      case "copy":
      case "cut":
      case "auxclick":
      case "dblclick":
      case "dragend":
      case "dragstart":
      case "drop":
      case "focusin":
      case "focusout":
      case "input":
      case "invalid":
      case "keydown":
      case "keypress":
      case "keyup":
      case "mousedown":
      case "mouseup":
      case "paste":
      case "pause":
      case "play":
      case "pointercancel":
      case "pointerdown":
      case "pointerup":
      case "ratechange":
      case "reset":
      case "resize":
      case "seeked":
      case "submit":
      case "touchcancel":
      case "touchend":
      case "touchstart":
      case "volumechange":
      case "change":
      case "selectionchange":
      case "textInput":
      case "compositionstart":
      case "compositionend":
      case "compositionupdate":
      case "beforeblur":
      case "afterblur":
      case "beforeinput":
      case "blur":
      case "fullscreenchange":
      case "focus":
      case "hashchange":
      case "popstate":
      case "select":
      case "selectstart":
         return 1;
      case "drag":
      case "dragenter":
      case "dragexit":
      case "dragleave":
      case "dragover":
      case "mousemove":
      case "mouseout":
      case "mouseover":
      case "pointermove":
      case "pointerout":
      case "pointerover":
      case "scroll":
      case "toggle":
      case "touchmove":
      case "wheel":
      case "mouseenter":
      case "mouseleave":
      case "pointerenter":
      case "pointerleave":
         return 4;
      case "message":
         switch (wh()) {
            case Ru:
               return 1;
            case Yc:
               return 4;
            case Bl:
            case Sh:
               return 16;
            case Xc:
               return 536870912;
            default:
               return 16
         }
      default:
         return 16
   }
}
var Lt = null,
   Lu = null,
   Pl = null;

function rf() {
   if (Pl) return Pl;
   var e, t = Lu,
      n = t.length,
      r, l = "value" in Lt ? Lt.value : Lt.textContent,
      o = l.length;
   for (e = 0; e < n && t[e] === l[e]; e++);
   var i = n - e;
   for (r = 1; r <= i && t[n - r] === l[o - r]; r++);
   return Pl = l.slice(e, 1 < r ? 1 - r : void 0)
}

function Rl(e) {
   var t = e.keyCode;
   return "charCode" in e ? (e = e.charCode, e === 0 && t === 13 && (e = 13)) : e = t, e === 10 && (e = 13), 32 <= e || e === 13 ? e : 0
}

function vl() {
   return !0
}

function Gs() {
   return !1
}

function je(e) {
   function t(n, r, l, o, i) {
      this._reactName = n, this._targetInst = l, this.type = r, this.nativeEvent = o, this.target = i, this.currentTarget = null;
      for (var u in e) e.hasOwnProperty(u) && (n = e[u], this[u] = n ? n(o) : o[u]);
      return this.isDefaultPrevented = (o.defaultPrevented != null ? o.defaultPrevented : o.returnValue === !1) ? vl : Gs, this.isPropagationStopped = Gs, this
   }
   return X(t.prototype, {
      preventDefault: function () {
         this.defaultPrevented = !0;
         var n = this.nativeEvent;
         n && (n.preventDefault ? n.preventDefault() : typeof n.returnValue != "unknown" && (n.returnValue = !1), this.isDefaultPrevented = vl)
      },
      stopPropagation: function () {
         var n = this.nativeEvent;
         n && (n.stopPropagation ? n.stopPropagation() : typeof n.cancelBubble != "unknown" && (n.cancelBubble = !0), this.isPropagationStopped = vl)
      },
      persist: function () {},
      isPersistent: vl
   }), t
}
var Zn = {
      eventPhase: 0,
      bubbles: 0,
      cancelable: 0,
      timeStamp: function (e) {
         return e.timeStamp || Date.now()
      },
      defaultPrevented: 0,
      isTrusted: 0
   },
   Mu = je(Zn),
   Jr = X({}, Zn, {
      view: 0,
      detail: 0
   }),
   Lh = je(Jr),
   Jo, qo, sr, xo = X({}, Jr, {
      screenX: 0,
      screenY: 0,
      clientX: 0,
      clientY: 0,
      pageX: 0,
      pageY: 0,
      ctrlKey: 0,
      shiftKey: 0,
      altKey: 0,
      metaKey: 0,
      getModifierState: ju,
      button: 0,
      buttons: 0,
      relatedTarget: function (e) {
         return e.relatedTarget === void 0 ? e.fromElement === e.srcElement ? e.toElement : e.fromElement : e.relatedTarget
      },
      movementX: function (e) {
         return "movementX" in e ? e.movementX : (e !== sr && (sr && e.type === "mousemove" ? (Jo = e.screenX - sr.screenX, qo = e.screenY - sr.screenY) : qo = Jo = 0, sr = e), Jo)
      },
      movementY: function (e) {
         return "movementY" in e ? e.movementY : qo
      }
   }),
   Zs = je(xo),
   Mh = X({}, xo, {
      dataTransfer: 0
   }),
   jh = je(Mh),
   Ih = X({}, Jr, {
      relatedTarget: 0
   }),
   bo = je(Ih),
   Fh = X({}, Zn, {
      animationName: 0,
      elapsedTime: 0,
      pseudoElement: 0
   }),
   Ah = je(Fh),
   $h = X({}, Zn, {
      clipboardData: function (e) {
         return "clipboardData" in e ? e.clipboardData : window.clipboardData
      }
   }),
   Uh = je($h),
   Bh = X({}, Zn, {
      data: 0
   }),
   Js = je(Bh),
   Vh = {
      Esc: "Escape",
      Spacebar: " ",
      Left: "ArrowLeft",
      Up: "ArrowUp",
      Right: "ArrowRight",
      Down: "ArrowDown",
      Del: "Delete",
      Win: "OS",
      Menu: "ContextMenu",
      Apps: "ContextMenu",
      Scroll: "ScrollLock",
      MozPrintableKey: "Unidentified"
   },
   Wh = {
      8: "Backspace",
      9: "Tab",
      12: "Clear",
      13: "Enter",
      16: "Shift",
      17: "Control",
      18: "Alt",
      19: "Pause",
      20: "CapsLock",
      27: "Escape",
      32: " ",
      33: "PageUp",
      34: "PageDown",
      35: "End",
      36: "Home",
      37: "ArrowLeft",
      38: "ArrowUp",
      39: "ArrowRight",
      40: "ArrowDown",
      45: "Insert",
      46: "Delete",
      112: "F1",
      113: "F2",
      114: "F3",
      115: "F4",
      116: "F5",
      117: "F6",
      118: "F7",
      119: "F8",
      120: "F9",
      121: "F10",
      122: "F11",
      123: "F12",
      144: "NumLock",
      145: "ScrollLock",
      224: "Meta"
   },
   Hh = {
      Alt: "altKey",
      Control: "ctrlKey",
      Meta: "metaKey",
      Shift: "shiftKey"
   };

function Qh(e) {
   var t = this.nativeEvent;
   return t.getModifierState ? t.getModifierState(e) : (e = Hh[e]) ? !!t[e] : !1
}

function ju() {
   return Qh
}
var Kh = X({}, Jr, {
      key: function (e) {
         if (e.key) {
            var t = Vh[e.key] || e.key;
            if (t !== "Unidentified") return t
         }
         return e.type === "keypress" ? (e = Rl(e), e === 13 ? "Enter" : String.fromCharCode(e)) : e.type === "keydown" || e.type === "keyup" ? Wh[e.keyCode] || "Unidentified" : ""
      },
      code: 0,
      location: 0,
      ctrlKey: 0,
      shiftKey: 0,
      altKey: 0,
      metaKey: 0,
      repeat: 0,
      locale: 0,
      getModifierState: ju,
      charCode: function (e) {
         return e.type === "keypress" ? Rl(e) : 0
      },
      keyCode: function (e) {
         return e.type === "keydown" || e.type === "keyup" ? e.keyCode : 0
      },
      which: function (e) {
         return e.type === "keypress" ? Rl(e) : e.type === "keydown" || e.type === "keyup" ? e.keyCode : 0
      }
   }),
   Yh = je(Kh),
   Xh = X({}, xo, {
      pointerId: 0,
      width: 0,
      height: 0,
      pressure: 0,
      tangentialPressure: 0,
      tiltX: 0,
      tiltY: 0,
      twist: 0,
      pointerType: 0,
      isPrimary: 0
   }),
   qs = je(Xh),
   Gh = X({}, Jr, {
      touches: 0,
      targetTouches: 0,
      changedTouches: 0,
      altKey: 0,
      metaKey: 0,
      ctrlKey: 0,
      shiftKey: 0,
      getModifierState: ju
   }),
   Zh = je(Gh),
   Jh = X({}, Zn, {
      propertyName: 0,
      elapsedTime: 0,
      pseudoElement: 0
   }),
   qh = je(Jh),
   bh = X({}, xo, {
      deltaX: function (e) {
         return "deltaX" in e ? e.deltaX : "wheelDeltaX" in e ? -e.wheelDeltaX : 0
      },
      deltaY: function (e) {
         return "deltaY" in e ? e.deltaY : "wheelDeltaY" in e ? -e.wheelDeltaY : "wheelDelta" in e ? -e.wheelDelta : 0
      },
      deltaZ: 0,
      deltaMode: 0
   }),
   ev = je(bh),
   tv = [9, 13, 27, 32],
   Iu = mt && "CompositionEvent" in window,
   yr = null;
mt && "documentMode" in document && (yr = document.documentMode);
var nv = mt && "TextEvent" in window && !yr,
   lf = mt && (!Iu || yr && 8 < yr && 11 >= yr),
   bs = " ",
   ea = !1;

function of (e, t) {
   switch (e) {
      case "keyup":
         return tv.indexOf(t.keyCode) !== -1;
      case "keydown":
         return t.keyCode !== 229;
      case "keypress":
      case "mousedown":
      case "focusout":
         return !0;
      default:
         return !1
   }
}

function uf(e) {
   return e = e.detail, typeof e == "object" && "data" in e ? e.data : null
}
var En = !1;

function rv(e, t) {
   switch (e) {
      case "compositionend":
         return uf(t);
      case "keypress":
         return t.which !== 32 ? null : (ea = !0, bs);
      case "textInput":
         return e = t.data, e === bs && ea ? null : e;
      default:
         return null
   }
}

function lv(e, t) {
   if (En) return e === "compositionend" || !Iu && of (e, t) ? (e = rf(), Pl = Lu = Lt = null, En = !1, e) : null;
   switch (e) {
      case "paste":
         return null;
      case "keypress":
         if (!(t.ctrlKey || t.altKey || t.metaKey) || t.ctrlKey && t.altKey) {
            if (t.char && 1 < t.char.length) return t.char;
            if (t.which) return String.fromCharCode(t.which)
         }
         return null;
      case "compositionend":
         return lf && t.locale !== "ko" ? null : t.data;
      default:
         return null
   }
}
var ov = {
   color: !0,
   date: !0,
   datetime: !0,
   "datetime-local": !0,
   email: !0,
   month: !0,
   number: !0,
   password: !0,
   range: !0,
   search: !0,
   tel: !0,
   text: !0,
   time: !0,
   url: !0,
   week: !0
};

function ta(e) {
   var t = e && e.nodeName && e.nodeName.toLowerCase();
   return t === "input" ? !!ov[e.type] : t === "textarea"
}

function sf(e, t, n, r) {
   Ac(r), t = Ql(t, "onChange"), 0 < t.length && (n = new Mu("onChange", "change", null, n, r), e.push({
      event: n,
      listeners: t
   }))
}
var wr = null,
   jr = null;

function iv(e) {
   wf(e, 0)
}

function ko(e) {
   var t = Dn(e);
   if (Oc(t)) return e
}

function uv(e, t) {
   if (e === "change") return t
}
var af = !1;
if (mt) {
   var ei;
   if (mt) {
      var ti = "oninput" in document;
      if (!ti) {
         var na = document.createElement("div");
         na.setAttribute("oninput", "return;"), ti = typeof na.oninput == "function"
      }
      ei = ti
   } else ei = !1;
   af = ei && (!document.documentMode || 9 < document.documentMode)
}

function ra() {
   wr && (wr.detachEvent("onpropertychange", cf), jr = wr = null)
}

function cf(e) {
   if (e.propertyName === "value" && ko(jr)) {
      var t = [];
      sf(t, jr, e, Pu(e)), Vc(iv, t)
   }
}

function sv(e, t, n) {
   e === "focusin" ? (ra(), wr = t, jr = n, wr.attachEvent("onpropertychange", cf)) : e === "focusout" && ra()
}

function av(e) {
   if (e === "selectionchange" || e === "keyup" || e === "keydown") return ko(jr)
}

function cv(e, t) {
   if (e === "click") return ko(t)
}

function fv(e, t) {
   if (e === "input" || e === "change") return ko(t)
}

function dv(e, t) {
   return e === t && (e !== 0 || 1 / e === 1 / t) || e !== e && t !== t
}
var et = typeof Object.is == "function" ? Object.is : dv;

function Ir(e, t) {
   if (et(e, t)) return !0;
   if (typeof e != "object" || e === null || typeof t != "object" || t === null) return !1;
   var n = Object.keys(e),
      r = Object.keys(t);
   if (n.length !== r.length) return !1;
   for (r = 0; r < n.length; r++) {
      var l = n[r];
      if (!xi.call(t, l) || !et(e[l], t[l])) return !1
   }
   return !0
}

function la(e) {
   for (; e && e.firstChild;) e = e.firstChild;
   return e
}

function oa(e, t) {
   var n = la(e);
   e = 0;
   for (var r; n;) {
      if (n.nodeType === 3) {
         if (r = e + n.textContent.length, e <= t && r >= t) return {
            node: n,
            offset: t - e
         };
         e = r
      }
      e: {
         for (; n;) {
            if (n.nextSibling) {
               n = n.nextSibling;
               break e
            }
            n = n.parentNode
         }
         n = void 0
      }
      n = la(n)
   }
}

function ff(e, t) {
   return e && t ? e === t ? !0 : e && e.nodeType === 3 ? !1 : t && t.nodeType === 3 ? ff(e, t.parentNode) : "contains" in e ? e.contains(t) : e.compareDocumentPosition ? !!(e.compareDocumentPosition(t) & 16) : !1 : !1
}

function df() {
   for (var e = window, t = Al(); t instanceof e.HTMLIFrameElement;) {
      try {
         var n = typeof t.contentWindow.location.href == "string"
      } catch {
         n = !1
      }
      if (n) e = t.contentWindow;
      else break;
      t = Al(e.document)
   }
   return t
}

function Fu(e) {
   var t = e && e.nodeName && e.nodeName.toLowerCase();
   return t && (t === "input" && (e.type === "text" || e.type === "search" || e.type === "tel" || e.type === "url" || e.type === "password") || t === "textarea" || e.contentEditable === "true")
}

function pv(e) {
   var t = df(),
      n = e.focusedElem,
      r = e.selectionRange;
   if (t !== n && n && n.ownerDocument && ff(n.ownerDocument.documentElement, n)) {
      if (r !== null && Fu(n)) {
         if (t = r.start, e = r.end, e === void 0 && (e = t), "selectionStart" in n) n.selectionStart = t, n.selectionEnd = Math.min(e, n.value.length);
         else if (e = (t = n.ownerDocument || document) && t.defaultView || window, e.getSelection) {
            e = e.getSelection();
            var l = n.textContent.length,
               o = Math.min(r.start, l);
            r = r.end === void 0 ? o : Math.min(r.end, l), !e.extend && o > r && (l = r, r = o, o = l), l = oa(n, o);
            var i = oa(n, r);
            l && i && (e.rangeCount !== 1 || e.anchorNode !== l.node || e.anchorOffset !== l.offset || e.focusNode !== i.node || e.focusOffset !== i.offset) && (t = t.createRange(), t.setStart(l.node, l.offset), e.removeAllRanges(), o > r ? (e.addRange(t), e.extend(i.node, i.offset)) : (t.setEnd(i.node, i.offset), e.addRange(t)))
         }
      }
      for (t = [], e = n; e = e.parentNode;) e.nodeType === 1 && t.push({
         element: e,
         left: e.scrollLeft,
         top: e.scrollTop
      });
      for (typeof n.focus == "function" && n.focus(), n = 0; n < t.length; n++) e = t[n], e.element.scrollLeft = e.left, e.element.scrollTop = e.top
   }
}
var hv = mt && "documentMode" in document && 11 >= document.documentMode,
   Cn = null,
   Ui = null,
   Sr = null,
   Bi = !1;

function ia(e, t, n) {
   var r = n.window === n ? n.document : n.nodeType === 9 ? n : n.ownerDocument;
   Bi || Cn == null || Cn !== Al(r) || (r = Cn, "selectionStart" in r && Fu(r) ? r = {
      start: r.selectionStart,
      end: r.selectionEnd
   } : (r = (r.ownerDocument && r.ownerDocument.defaultView || window).getSelection(), r = {
      anchorNode: r.anchorNode,
      anchorOffset: r.anchorOffset,
      focusNode: r.focusNode,
      focusOffset: r.focusOffset
   }), Sr && Ir(Sr, r) || (Sr = r, r = Ql(Ui, "onSelect"), 0 < r.length && (t = new Mu("onSelect", "select", null, t, n), e.push({
      event: t,
      listeners: r
   }), t.target = Cn)))
}

function ml(e, t) {
   var n = {};
   return n[e.toLowerCase()] = t.toLowerCase(), n["Webkit" + e] = "webkit" + t, n["Moz" + e] = "moz" + t, n
}
var Nn = {
      animationend: ml("Animation", "AnimationEnd"),
      animationiteration: ml("Animation", "AnimationIteration"),
      animationstart: ml("Animation", "AnimationStart"),
      transitionend: ml("Transition", "TransitionEnd")
   },
   ni = {},
   pf = {};
mt && (pf = document.createElement("div").style, "AnimationEvent" in window || (delete Nn.animationend.animation, delete Nn.animationiteration.animation, delete Nn.animationstart.animation), "TransitionEvent" in window || delete Nn.transitionend.transition);

function Eo(e) {
   if (ni[e]) return ni[e];
   if (!Nn[e]) return e;
   var t = Nn[e],
      n;
   for (n in t)
      if (t.hasOwnProperty(n) && n in pf) return ni[e] = t[n];
   return e
}
var hf = Eo("animationend"),
   vf = Eo("animationiteration"),
   mf = Eo("animationstart"),
   gf = Eo("transitionend"),
   yf = new Map,
   ua = "abort auxClick cancel canPlay canPlayThrough click close contextMenu copy cut drag dragEnd dragEnter dragExit dragLeave dragOver dragStart drop durationChange emptied encrypted ended error gotPointerCapture input invalid keyDown keyPress keyUp load loadedData loadedMetadata loadStart lostPointerCapture mouseDown mouseMove mouseOut mouseOver mouseUp paste pause play playing pointerCancel pointerDown pointerMove pointerOut pointerOver pointerUp progress rateChange reset resize seeked seeking stalled submit suspend timeUpdate touchCancel touchEnd touchStart volumeChange scroll toggle touchMove waiting wheel".split(" ");

function Kt(e, t) {
   yf.set(e, t), fn(t, [e])
}
for (var ri = 0; ri < ua.length; ri++) {
   var li = ua[ri],
      vv = li.toLowerCase(),
      mv = li[0].toUpperCase() + li.slice(1);
   Kt(vv, "on" + mv)
}
Kt(hf, "onAnimationEnd");
Kt(vf, "onAnimationIteration");
Kt(mf, "onAnimationStart");
Kt("dblclick", "onDoubleClick");
Kt("focusin", "onFocus");
Kt("focusout", "onBlur");
Kt(gf, "onTransitionEnd");
Vn("onMouseEnter", ["mouseout", "mouseover"]);
Vn("onMouseLeave", ["mouseout", "mouseover"]);
Vn("onPointerEnter", ["pointerout", "pointerover"]);
Vn("onPointerLeave", ["pointerout", "pointerover"]);
fn("onChange", "change click focusin focusout input keydown keyup selectionchange".split(" "));
fn("onSelect", "focusout contextmenu dragend focusin keydown keyup mousedown mouseup selectionchange".split(" "));
fn("onBeforeInput", ["compositionend", "keypress", "textInput", "paste"]);
fn("onCompositionEnd", "compositionend focusout keydown keypress keyup mousedown".split(" "));
fn("onCompositionStart", "compositionstart focusout keydown keypress keyup mousedown".split(" "));
fn("onCompositionUpdate", "compositionupdate focusout keydown keypress keyup mousedown".split(" "));
var vr = "abort canplay canplaythrough durationchange emptied encrypted ended error loadeddata loadedmetadata loadstart pause play playing progress ratechange resize seeked seeking stalled suspend timeupdate volumechange waiting".split(" "),
   gv = new Set("cancel close invalid load scroll toggle".split(" ").concat(vr));

function sa(e, t, n) {
   var r = e.type || "unknown-event";
   e.currentTarget = n, vh(r, t, void 0, e), e.currentTarget = null
}

function wf(e, t) {
   t = (t & 4) !== 0;
   for (var n = 0; n < e.length; n++) {
      var r = e[n],
         l = r.event;
      r = r.listeners;
      e: {
         var o = void 0;
         if (t)
            for (var i = r.length - 1; 0 <= i; i--) {
               var u = r[i],
                  s = u.instance,
                  a = u.currentTarget;
               if (u = u.listener, s !== o && l.isPropagationStopped()) break e;
               sa(l, u, a), o = s
            } else
               for (i = 0; i < r.length; i++) {
                  if (u = r[i], s = u.instance, a = u.currentTarget, u = u.listener, s !== o && l.isPropagationStopped()) break e;
                  sa(l, u, a), o = s
               }
      }
   }
   if (Ul) throw e = Ii, Ul = !1, Ii = null, e
}

function V(e, t) {
   var n = t[Ki];
   n === void 0 && (n = t[Ki] = new Set);
   var r = e + "__bubble";
   n.has(r) || (Sf(t, e, 2, !1), n.add(r))
}

function oi(e, t, n) {
   var r = 0;
   t && (r |= 4), Sf(n, e, r, t)
}
var gl = "_reactListening" + Math.random().toString(36).slice(2);

function Fr(e) {
   if (!e[gl]) {
      e[gl] = !0, Dc.forEach(function (n) {
         n !== "selectionchange" && (gv.has(n) || oi(n, !1, e), oi(n, !0, e))
      });
      var t = e.nodeType === 9 ? e : e.ownerDocument;
      t === null || t[gl] || (t[gl] = !0, oi("selectionchange", !1, t))
   }
}

function Sf(e, t, n, r) {
   switch (nf(t)) {
      case 1:
         var l = Oh;
         break;
      case 4:
         l = zh;
         break;
      default:
         l = zu
   }
   n = l.bind(null, t, n, e), l = void 0, !ji || t !== "touchstart" && t !== "touchmove" && t !== "wheel" || (l = !0), r ? l !== void 0 ? e.addEventListener(t, n, {
      capture: !0,
      passive: l
   }) : e.addEventListener(t, n, !0) : l !== void 0 ? e.addEventListener(t, n, {
      passive: l
   }) : e.addEventListener(t, n, !1)
}

function ii(e, t, n, r, l) {
   var o = r;
   if (!(t & 1) && !(t & 2) && r !== null) e: for (;;) {
      if (r === null) return;
      var i = r.tag;
      if (i === 3 || i === 4) {
         var u = r.stateNode.containerInfo;
         if (u === l || u.nodeType === 8 && u.parentNode === l) break;
         if (i === 4)
            for (i = r.return; i !== null;) {
               var s = i.tag;
               if ((s === 3 || s === 4) && (s = i.stateNode.containerInfo, s === l || s.nodeType === 8 && s.parentNode === l)) return;
               i = i.return
            }
         for (; u !== null;) {
            if (i = en(u), i === null) return;
            if (s = i.tag, s === 5 || s === 6) {
               r = o = i;
               continue e
            }
            u = u.parentNode
         }
      }
      r = r.return
   }
   Vc(function () {
      var a = o,
         p = Pu(n),
         d = [];
      e: {
         var v = yf.get(e);
         if (v !== void 0) {
            var m = Mu,
               w = e;
            switch (e) {
               case "keypress":
                  if (Rl(n) === 0) break e;
               case "keydown":
               case "keyup":
                  m = Yh;
                  break;
               case "focusin":
                  w = "focus", m = bo;
                  break;
               case "focusout":
                  w = "blur", m = bo;
                  break;
               case "beforeblur":
               case "afterblur":
                  m = bo;
                  break;
               case "click":
                  if (n.button === 2) break e;
               case "auxclick":
               case "dblclick":
               case "mousedown":
               case "mousemove":
               case "mouseup":
               case "mouseout":
               case "mouseover":
               case "contextmenu":
                  m = Zs;
                  break;
               case "drag":
               case "dragend":
               case "dragenter":
               case "dragexit":
               case "dragleave":
               case "dragover":
               case "dragstart":
               case "drop":
                  m = jh;
                  break;
               case "touchcancel":
               case "touchend":
               case "touchmove":
               case "touchstart":
                  m = Zh;
                  break;
               case hf:
               case vf:
               case mf:
                  m = Ah;
                  break;
               case gf:
                  m = qh;
                  break;
               case "scroll":
                  m = Lh;
                  break;
               case "wheel":
                  m = ev;
                  break;
               case "copy":
               case "cut":
               case "paste":
                  m = Uh;
                  break;
               case "gotpointercapture":
               case "lostpointercapture":
               case "pointercancel":
               case "pointerdown":
               case "pointermove":
               case "pointerout":
               case "pointerover":
               case "pointerup":
                  m = qs
            }
            var y = (t & 4) !== 0,
               D = !y && e === "scroll",
               f = y ? v !== null ? v + "Capture" : null : v;
            y = [];
            for (var c = a, h; c !== null;) {
               h = c;
               var S = h.stateNode;
               if (h.tag === 5 && S !== null && (h = S, f !== null && (S = Or(c, f), S != null && y.push(Ar(c, S, h)))), D) break;
               c = c.return
            }
            0 < y.length && (v = new m(v, w, null, n, p), d.push({
               event: v,
               listeners: y
            }))
         }
      }
      if (!(t & 7)) {
         e: {
            if (v = e === "mouseover" || e === "pointerover", m = e === "mouseout" || e === "pointerout", v && n !== Li && (w = n.relatedTarget || n.fromElement) && (en(w) || w[gt])) break e;
            if ((m || v) && (v = p.window === p ? p : (v = p.ownerDocument) ? v.defaultView || v.parentWindow : window, m ? (w = n.relatedTarget || n.toElement, m = a, w = w ? en(w) : null, w !== null && (D = dn(w), w !== D || w.tag !== 5 && w.tag !== 6) && (w = null)) : (m = null, w = a), m !== w)) {
               if (y = Zs, S = "onMouseLeave", f = "onMouseEnter", c = "mouse", (e === "pointerout" || e === "pointerover") && (y = qs, S = "onPointerLeave", f = "onPointerEnter", c = "pointer"), D = m == null ? v : Dn(m), h = w == null ? v : Dn(w), v = new y(S, c + "leave", m, n, p), v.target = D, v.relatedTarget = h, S = null, en(p) === a && (y = new y(f, c + "enter", w, n, p), y.target = h, y.relatedTarget = D, S = y), D = S, m && w) t: {
                  for (y = m, f = w, c = 0, h = y; h; h = wn(h)) c++;
                  for (h = 0, S = f; S; S = wn(S)) h++;
                  for (; 0 < c - h;) y = wn(y),
                  c--;
                  for (; 0 < h - c;) f = wn(f),
                  h--;
                  for (; c--;) {
                     if (y === f || f !== null && y === f.alternate) break t;
                     y = wn(y), f = wn(f)
                  }
                  y = null
               }
               else y = null;
               m !== null && aa(d, v, m, y, !1), w !== null && D !== null && aa(d, D, w, y, !0)
            }
         }
         e: {
            if (v = a ? Dn(a) : window, m = v.nodeName && v.nodeName.toLowerCase(), m === "select" || m === "input" && v.type === "file") var x = uv;
            else if (ta(v))
               if (af) x = fv;
               else {
                  x = av;
                  var N = sv
               }
            else(m = v.nodeName) && m.toLowerCase() === "input" && (v.type === "checkbox" || v.type === "radio") && (x = cv);
            if (x && (x = x(e, a))) {
               sf(d, x, n, p);
               break e
            }
            N && N(e, v, a),
            e === "focusout" && (N = v._wrapperState) && N.controlled && v.type === "number" && Pi(v, "number", v.value)
         }
         switch (N = a ? Dn(a) : window, e) {
            case "focusin":
               (ta(N) || N.contentEditable === "true") && (Cn = N, Ui = a, Sr = null);
               break;
            case "focusout":
               Sr = Ui = Cn = null;
               break;
            case "mousedown":
               Bi = !0;
               break;
            case "contextmenu":
            case "mouseup":
            case "dragend":
               Bi = !1, ia(d, n, p);
               break;
            case "selectionchange":
               if (hv) break;
            case "keydown":
            case "keyup":
               ia(d, n, p)
         }
         var E;
         if (Iu) e: {
            switch (e) {
               case "compositionstart":
                  var C = "onCompositionStart";
                  break e;
               case "compositionend":
                  C = "onCompositionEnd";
                  break e;
               case "compositionupdate":
                  C = "onCompositionUpdate";
                  break e
            }
            C = void 0
         }
         else En ? of (e, n) && (C = "onCompositionEnd") : e === "keydown" && n.keyCode === 229 && (C = "onCompositionStart");C && (lf && n.locale !== "ko" && (En || C !== "onCompositionStart" ? C === "onCompositionEnd" && En && (E = rf()) : (Lt = p, Lu = "value" in Lt ? Lt.value : Lt.textContent, En = !0)), N = Ql(a, C), 0 < N.length && (C = new Js(C, e, null, n, p), d.push({
            event: C,
            listeners: N
         }), E ? C.data = E : (E = uf(n), E !== null && (C.data = E)))),
         (E = nv ? rv(e, n) : lv(e, n)) && (a = Ql(a, "onBeforeInput"), 0 < a.length && (p = new Js("onBeforeInput", "beforeinput", null, n, p), d.push({
            event: p,
            listeners: a
         }), p.data = E))
      }
      wf(d, t)
   })
}

function Ar(e, t, n) {
   return {
      instance: e,
      listener: t,
      currentTarget: n
   }
}

function Ql(e, t) {
   for (var n = t + "Capture", r = []; e !== null;) {
      var l = e,
         o = l.stateNode;
      l.tag === 5 && o !== null && (l = o, o = Or(e, n), o != null && r.unshift(Ar(e, o, l)), o = Or(e, t), o != null && r.push(Ar(e, o, l))), e = e.return
   }
   return r
}

function wn(e) {
   if (e === null) return null;
   do e = e.return; while (e && e.tag !== 5);
   return e || null
}

function aa(e, t, n, r, l) {
   for (var o = t._reactName, i = []; n !== null && n !== r;) {
      var u = n,
         s = u.alternate,
         a = u.stateNode;
      if (s !== null && s === r) break;
      u.tag === 5 && a !== null && (u = a, l ? (s = Or(n, o), s != null && i.unshift(Ar(n, s, u))) : l || (s = Or(n, o), s != null && i.push(Ar(n, s, u)))), n = n.return
   }
   i.length !== 0 && e.push({
      event: t,
      listeners: i
   })
}
var yv = /\r\n?/g,
   wv = /\u0000|\uFFFD/g;

function ca(e) {
   return (typeof e == "string" ? e : "" + e).replace(yv, `
`).replace(wv, "")
}

function yl(e, t, n) {
   if (t = ca(t), ca(e) !== t && n) throw Error(k(425))
}

function Kl() {}
var Vi = null,
   Wi = null;

function Hi(e, t) {
   return e === "textarea" || e === "noscript" || typeof t.children == "string" || typeof t.children == "number" || typeof t.dangerouslySetInnerHTML == "object" && t.dangerouslySetInnerHTML !== null && t.dangerouslySetInnerHTML.__html != null
}
var Qi = typeof setTimeout == "function" ? setTimeout : void 0,
   Sv = typeof clearTimeout == "function" ? clearTimeout : void 0,
   fa = typeof Promise == "function" ? Promise : void 0,
   xv = typeof queueMicrotask == "function" ? queueMicrotask : typeof fa < "u" ? function (e) {
      return fa.resolve(null).then(e).catch(kv)
   } : Qi;

function kv(e) {
   setTimeout(function () {
      throw e
   })
}

function ui(e, t) {
   var n = t,
      r = 0;
   do {
      var l = n.nextSibling;
      if (e.removeChild(n), l && l.nodeType === 8)
         if (n = l.data, n === "/$") {
            if (r === 0) {
               e.removeChild(l), Mr(t);
               return
            }
            r--
         } else n !== "$" && n !== "$?" && n !== "$!" || r++;
      n = l
   } while (n);
   Mr(t)
}

function $t(e) {
   for (; e != null; e = e.nextSibling) {
      var t = e.nodeType;
      if (t === 1 || t === 3) break;
      if (t === 8) {
         if (t = e.data, t === "$" || t === "$!" || t === "$?") break;
         if (t === "/$") return null
      }
   }
   return e
}

function da(e) {
   e = e.previousSibling;
   for (var t = 0; e;) {
      if (e.nodeType === 8) {
         var n = e.data;
         if (n === "$" || n === "$!" || n === "$?") {
            if (t === 0) return e;
            t--
         } else n === "/$" && t++
      }
      e = e.previousSibling
   }
   return null
}
var Jn = Math.random().toString(36).slice(2),
   ut = "__reactFiber$" + Jn,
   $r = "__reactProps$" + Jn,
   gt = "__reactContainer$" + Jn,
   Ki = "__reactEvents$" + Jn,
   Ev = "__reactListeners$" + Jn,
   Cv = "__reactHandles$" + Jn;

function en(e) {
   var t = e[ut];
   if (t) return t;
   for (var n = e.parentNode; n;) {
      if (t = n[gt] || n[ut]) {
         if (n = t.alternate, t.child !== null || n !== null && n.child !== null)
            for (e = da(e); e !== null;) {
               if (n = e[ut]) return n;
               e = da(e)
            }
         return t
      }
      e = n, n = e.parentNode
   }
   return null
}

function qr(e) {
   return e = e[ut] || e[gt], !e || e.tag !== 5 && e.tag !== 6 && e.tag !== 13 && e.tag !== 3 ? null : e
}

function Dn(e) {
   if (e.tag === 5 || e.tag === 6) return e.stateNode;
   throw Error(k(33))
}

function Co(e) {
   return e[$r] || null
}
var Yi = [],
   _n = -1;

function Yt(e) {
   return {
      current: e
   }
}

function W(e) {
   0 > _n || (e.current = Yi[_n], Yi[_n] = null, _n--)
}

function B(e, t) {
   _n++, Yi[_n] = e.current, e.current = t
}
var Qt = {},
   pe = Yt(Qt),
   Ee = Yt(!1),
   on = Qt;

function Wn(e, t) {
   var n = e.type.contextTypes;
   if (!n) return Qt;
   var r = e.stateNode;
   if (r && r.__reactInternalMemoizedUnmaskedChildContext === t) return r.__reactInternalMemoizedMaskedChildContext;
   var l = {},
      o;
   for (o in n) l[o] = t[o];
   return r && (e = e.stateNode, e.__reactInternalMemoizedUnmaskedChildContext = t, e.__reactInternalMemoizedMaskedChildContext = l), l
}

function Ce(e) {
   return e = e.childContextTypes, e != null
}

function Yl() {
   W(Ee), W(pe)
}

function pa(e, t, n) {
   if (pe.current !== Qt) throw Error(k(168));
   B(pe, t), B(Ee, n)
}

function xf(e, t, n) {
   var r = e.stateNode;
   if (t = t.childContextTypes, typeof r.getChildContext != "function") return n;
   r = r.getChildContext();
   for (var l in r)
      if (!(l in t)) throw Error(k(108, sh(e) || "Unknown", l));
   return X({}, n, r)
}

function Xl(e) {
   return e = (e = e.stateNode) && e.__reactInternalMemoizedMergedChildContext || Qt, on = pe.current, B(pe, e), B(Ee, Ee.current), !0
}

function ha(e, t, n) {
   var r = e.stateNode;
   if (!r) throw Error(k(169));
   n ? (e = xf(e, t, on), r.__reactInternalMemoizedMergedChildContext = e, W(Ee), W(pe), B(pe, e)) : W(Ee), B(Ee, n)
}
var dt = null,
   No = !1,
   si = !1;

function kf(e) {
   dt === null ? dt = [e] : dt.push(e)
}

function Nv(e) {
   No = !0, kf(e)
}

function Xt() {
   if (!si && dt !== null) {
      si = !0;
      var e = 0,
         t = A;
      try {
         var n = dt;
         for (A = 1; e < n.length; e++) {
            var r = n[e];
            do r = r(!0); while (r !== null)
         }
         dt = null, No = !1
      } catch (l) {
         throw dt !== null && (dt = dt.slice(e + 1)), Kc(Ru, Xt), l
      } finally {
         A = t, si = !1
      }
   }
   return null
}
var Pn = [],
   Rn = 0,
   Gl = null,
   Zl = 0,
   $e = [],
   Ue = 0,
   un = null,
   pt = 1,
   ht = "";

function qt(e, t) {
   Pn[Rn++] = Zl, Pn[Rn++] = Gl, Gl = e, Zl = t
}

function Ef(e, t, n) {
   $e[Ue++] = pt, $e[Ue++] = ht, $e[Ue++] = un, un = e;
   var r = pt;
   e = ht;
   var l = 32 - qe(r) - 1;
   r &= ~(1 << l), n += 1;
   var o = 32 - qe(t) + l;
   if (30 < o) {
      var i = l - l % 5;
      o = (r & (1 << i) - 1).toString(32), r >>= i, l -= i, pt = 1 << 32 - qe(t) + l | n << l | r, ht = o + e
   } else pt = 1 << o | n << l | r, ht = e
}

function Au(e) {
   e.return !== null && (qt(e, 1), Ef(e, 1, 0))
}

function $u(e) {
   for (; e === Gl;) Gl = Pn[--Rn], Pn[Rn] = null, Zl = Pn[--Rn], Pn[Rn] = null;
   for (; e === un;) un = $e[--Ue], $e[Ue] = null, ht = $e[--Ue], $e[Ue] = null, pt = $e[--Ue], $e[Ue] = null
}
var ze = null,
   Oe = null,
   Q = !1,
   Je = null;

function Cf(e, t) {
   var n = Be(5, null, null, 0);
   n.elementType = "DELETED", n.stateNode = t, n.return = e, t = e.deletions, t === null ? (e.deletions = [n], e.flags |= 16) : t.push(n)
}

function va(e, t) {
   switch (e.tag) {
      case 5:
         var n = e.type;
         return t = t.nodeType !== 1 || n.toLowerCase() !== t.nodeName.toLowerCase() ? null : t, t !== null ? (e.stateNode = t, ze = e, Oe = $t(t.firstChild), !0) : !1;
      case 6:
         return t = e.pendingProps === "" || t.nodeType !== 3 ? null : t, t !== null ? (e.stateNode = t, ze = e, Oe = null, !0) : !1;
      case 13:
         return t = t.nodeType !== 8 ? null : t, t !== null ? (n = un !== null ? {
            id: pt,
            overflow: ht
         } : null, e.memoizedState = {
            dehydrated: t,
            treeContext: n,
            retryLane: 1073741824
         }, n = Be(18, null, null, 0), n.stateNode = t, n.return = e, e.child = n, ze = e, Oe = null, !0) : !1;
      default:
         return !1
   }
}

function Xi(e) {
   return (e.mode & 1) !== 0 && (e.flags & 128) === 0
}

function Gi(e) {
   if (Q) {
      var t = Oe;
      if (t) {
         var n = t;
         if (!va(e, t)) {
            if (Xi(e)) throw Error(k(418));
            t = $t(n.nextSibling);
            var r = ze;
            t && va(e, t) ? Cf(r, n) : (e.flags = e.flags & -4097 | 2, Q = !1, ze = e)
         }
      } else {
         if (Xi(e)) throw Error(k(418));
         e.flags = e.flags & -4097 | 2, Q = !1, ze = e
      }
   }
}

function ma(e) {
   for (e = e.return; e !== null && e.tag !== 5 && e.tag !== 3 && e.tag !== 13;) e = e.return;
   ze = e
}

function wl(e) {
   if (e !== ze) return !1;
   if (!Q) return ma(e), Q = !0, !1;
   var t;
   if ((t = e.tag !== 3) && !(t = e.tag !== 5) && (t = e.type, t = t !== "head" && t !== "body" && !Hi(e.type, e.memoizedProps)), t && (t = Oe)) {
      if (Xi(e)) throw Nf(), Error(k(418));
      for (; t;) Cf(e, t), t = $t(t.nextSibling)
   }
   if (ma(e), e.tag === 13) {
      if (e = e.memoizedState, e = e !== null ? e.dehydrated : null, !e) throw Error(k(317));
      e: {
         for (e = e.nextSibling, t = 0; e;) {
            if (e.nodeType === 8) {
               var n = e.data;
               if (n === "/$") {
                  if (t === 0) {
                     Oe = $t(e.nextSibling);
                     break e
                  }
                  t--
               } else n !== "$" && n !== "$!" && n !== "$?" || t++
            }
            e = e.nextSibling
         }
         Oe = null
      }
   } else Oe = ze ? $t(e.stateNode.nextSibling) : null;
   return !0
}

function Nf() {
   for (var e = Oe; e;) e = $t(e.nextSibling)
}

function Hn() {
   Oe = ze = null, Q = !1
}

function Uu(e) {
   Je === null ? Je = [e] : Je.push(e)
}
var Dv = xt.ReactCurrentBatchConfig;

function ar(e, t, n) {
   if (e = n.ref, e !== null && typeof e != "function" && typeof e != "object") {
      if (n._owner) {
         if (n = n._owner, n) {
            if (n.tag !== 1) throw Error(k(309));
            var r = n.stateNode
         }
         if (!r) throw Error(k(147, e));
         var l = r,
            o = "" + e;
         return t !== null && t.ref !== null && typeof t.ref == "function" && t.ref._stringRef === o ? t.ref : (t = function (i) {
            var u = l.refs;
            i === null ? delete u[o] : u[o] = i
         }, t._stringRef = o, t)
      }
      if (typeof e != "string") throw Error(k(284));
      if (!n._owner) throw Error(k(290, e))
   }
   return e
}

function Sl(e, t) {
   throw e = Object.prototype.toString.call(t), Error(k(31, e === "[object Object]" ? "object with keys {" + Object.keys(t).join(", ") + "}" : e))
}

function ga(e) {
   var t = e._init;
   return t(e._payload)
}

function Df(e) {
   function t(f, c) {
      if (e) {
         var h = f.deletions;
         h === null ? (f.deletions = [c], f.flags |= 16) : h.push(c)
      }
   }

   function n(f, c) {
      if (!e) return null;
      for (; c !== null;) t(f, c), c = c.sibling;
      return null
   }

   function r(f, c) {
      for (f = new Map; c !== null;) c.key !== null ? f.set(c.key, c) : f.set(c.index, c), c = c.sibling;
      return f
   }

   function l(f, c) {
      return f = Wt(f, c), f.index = 0, f.sibling = null, f
   }

   function o(f, c, h) {
      return f.index = h, e ? (h = f.alternate, h !== null ? (h = h.index, h < c ? (f.flags |= 2, c) : h) : (f.flags |= 2, c)) : (f.flags |= 1048576, c)
   }

   function i(f) {
      return e && f.alternate === null && (f.flags |= 2), f
   }

   function u(f, c, h, S) {
      return c === null || c.tag !== 6 ? (c = vi(h, f.mode, S), c.return = f, c) : (c = l(c, h), c.return = f, c)
   }

   function s(f, c, h, S) {
      var x = h.type;
      return x === kn ? p(f, c, h.props.children, S, h.key) : c !== null && (c.elementType === x || typeof x == "object" && x !== null && x.$$typeof === Pt && ga(x) === c.type) ? (S = l(c, h.props), S.ref = ar(f, c, h), S.return = f, S) : (S = Il(h.type, h.key, h.props, null, f.mode, S), S.ref = ar(f, c, h), S.return = f, S)
   }

   function a(f, c, h, S) {
      return c === null || c.tag !== 4 || c.stateNode.containerInfo !== h.containerInfo || c.stateNode.implementation !== h.implementation ? (c = mi(h, f.mode, S), c.return = f, c) : (c = l(c, h.children || []), c.return = f, c)
   }

   function p(f, c, h, S, x) {
      return c === null || c.tag !== 7 ? (c = ln(h, f.mode, S, x), c.return = f, c) : (c = l(c, h), c.return = f, c)
   }

   function d(f, c, h) {
      if (typeof c == "string" && c !== "" || typeof c == "number") return c = vi("" + c, f.mode, h), c.return = f, c;
      if (typeof c == "object" && c !== null) {
         switch (c.$$typeof) {
            case al:
               return h = Il(c.type, c.key, c.props, null, f.mode, h), h.ref = ar(f, null, c), h.return = f, h;
            case xn:
               return c = mi(c, f.mode, h), c.return = f, c;
            case Pt:
               var S = c._init;
               return d(f, S(c._payload), h)
         }
         if (pr(c) || lr(c)) return c = ln(c, f.mode, h, null), c.return = f, c;
         Sl(f, c)
      }
      return null
   }

   function v(f, c, h, S) {
      var x = c !== null ? c.key : null;
      if (typeof h == "string" && h !== "" || typeof h == "number") return x !== null ? null : u(f, c, "" + h, S);
      if (typeof h == "object" && h !== null) {
         switch (h.$$typeof) {
            case al:
               return h.key === x ? s(f, c, h, S) : null;
            case xn:
               return h.key === x ? a(f, c, h, S) : null;
            case Pt:
               return x = h._init, v(f, c, x(h._payload), S)
         }
         if (pr(h) || lr(h)) return x !== null ? null : p(f, c, h, S, null);
         Sl(f, h)
      }
      return null
   }

   function m(f, c, h, S, x) {
      if (typeof S == "string" && S !== "" || typeof S == "number") return f = f.get(h) || null, u(c, f, "" + S, x);
      if (typeof S == "object" && S !== null) {
         switch (S.$$typeof) {
            case al:
               return f = f.get(S.key === null ? h : S.key) || null, s(c, f, S, x);
            case xn:
               return f = f.get(S.key === null ? h : S.key) || null, a(c, f, S, x);
            case Pt:
               var N = S._init;
               return m(f, c, h, N(S._payload), x)
         }
         if (pr(S) || lr(S)) return f = f.get(h) || null, p(c, f, S, x, null);
         Sl(c, S)
      }
      return null
   }

   function w(f, c, h, S) {
      for (var x = null, N = null, E = c, C = c = 0, z = null; E !== null && C < h.length; C++) {
         E.index > C ? (z = E, E = null) : z = E.sibling;
         var T = v(f, E, h[C], S);
         if (T === null) {
            E === null && (E = z);
            break
         }
         e && E && T.alternate === null && t(f, E), c = o(T, c, C), N === null ? x = T : N.sibling = T, N = T, E = z
      }
      if (C === h.length) return n(f, E), Q && qt(f, C), x;
      if (E === null) {
         for (; C < h.length; C++) E = d(f, h[C], S), E !== null && (c = o(E, c, C), N === null ? x = E : N.sibling = E, N = E);
         return Q && qt(f, C), x
      }
      for (E = r(f, E); C < h.length; C++) z = m(E, f, C, h[C], S), z !== null && (e && z.alternate !== null && E.delete(z.key === null ? C : z.key), c = o(z, c, C), N === null ? x = z : N.sibling = z, N = z);
      return e && E.forEach(function (I) {
         return t(f, I)
      }), Q && qt(f, C), x
   }

   function y(f, c, h, S) {
      var x = lr(h);
      if (typeof x != "function") throw Error(k(150));
      if (h = x.call(h), h == null) throw Error(k(151));
      for (var N = x = null, E = c, C = c = 0, z = null, T = h.next(); E !== null && !T.done; C++, T = h.next()) {
         E.index > C ? (z = E, E = null) : z = E.sibling;
         var I = v(f, E, T.value, S);
         if (I === null) {
            E === null && (E = z);
            break
         }
         e && E && I.alternate === null && t(f, E), c = o(I, c, C), N === null ? x = I : N.sibling = I, N = I, E = z
      }
      if (T.done) return n(f, E), Q && qt(f, C), x;
      if (E === null) {
         for (; !T.done; C++, T = h.next()) T = d(f, T.value, S), T !== null && (c = o(T, c, C), N === null ? x = T : N.sibling = T, N = T);
         return Q && qt(f, C), x
      }
      for (E = r(f, E); !T.done; C++, T = h.next()) T = m(E, f, C, T.value, S), T !== null && (e && T.alternate !== null && E.delete(T.key === null ? C : T.key), c = o(T, c, C), N === null ? x = T : N.sibling = T, N = T);
      return e && E.forEach(function (he) {
         return t(f, he)
      }), Q && qt(f, C), x
   }

   function D(f, c, h, S) {
      if (typeof h == "object" && h !== null && h.type === kn && h.key === null && (h = h.props.children), typeof h == "object" && h !== null) {
         switch (h.$$typeof) {
            case al:
               e: {
                  for (var x = h.key, N = c; N !== null;) {
                     if (N.key === x) {
                        if (x = h.type, x === kn) {
                           if (N.tag === 7) {
                              n(f, N.sibling), c = l(N, h.props.children), c.return = f, f = c;
                              break e
                           }
                        } else if (N.elementType === x || typeof x == "object" && x !== null && x.$$typeof === Pt && ga(x) === N.type) {
                           n(f, N.sibling), c = l(N, h.props), c.ref = ar(f, N, h), c.return = f, f = c;
                           break e
                        }
                        n(f, N);
                        break
                     } else t(f, N);
                     N = N.sibling
                  }
                  h.type === kn ? (c = ln(h.props.children, f.mode, S, h.key), c.return = f, f = c) : (S = Il(h.type, h.key, h.props, null, f.mode, S), S.ref = ar(f, c, h), S.return = f, f = S)
               }
               return i(f);
            case xn:
               e: {
                  for (N = h.key; c !== null;) {
                     if (c.key === N)
                        if (c.tag === 4 && c.stateNode.containerInfo === h.containerInfo && c.stateNode.implementation === h.implementation) {
                           n(f, c.sibling), c = l(c, h.children || []), c.return = f, f = c;
                           break e
                        } else {
                           n(f, c);
                           break
                        }
                     else t(f, c);
                     c = c.sibling
                  }
                  c = mi(h, f.mode, S),
                  c.return = f,
                  f = c
               }
               return i(f);
            case Pt:
               return N = h._init, D(f, c, N(h._payload), S)
         }
         if (pr(h)) return w(f, c, h, S);
         if (lr(h)) return y(f, c, h, S);
         Sl(f, h)
      }
      return typeof h == "string" && h !== "" || typeof h == "number" ? (h = "" + h, c !== null && c.tag === 6 ? (n(f, c.sibling), c = l(c, h), c.return = f, f = c) : (n(f, c), c = vi(h, f.mode, S), c.return = f, f = c), i(f)) : n(f, c)
   }
   return D
}
var Qn = Df(!0),
   _f = Df(!1),
   Jl = Yt(null),
   ql = null,
   Tn = null,
   Bu = null;

function Vu() {
   Bu = Tn = ql = null
}

function Wu(e) {
   var t = Jl.current;
   W(Jl), e._currentValue = t
}

function Zi(e, t, n) {
   for (; e !== null;) {
      var r = e.alternate;
      if ((e.childLanes & t) !== t ? (e.childLanes |= t, r !== null && (r.childLanes |= t)) : r !== null && (r.childLanes & t) !== t && (r.childLanes |= t), e === n) break;
      e = e.return
   }
}

function An(e, t) {
   ql = e, Bu = Tn = null, e = e.dependencies, e !== null && e.firstContext !== null && (e.lanes & t && (ke = !0), e.firstContext = null)
}

function We(e) {
   var t = e._currentValue;
   if (Bu !== e)
      if (e = {
            context: e,
            memoizedValue: t,
            next: null
         }, Tn === null) {
         if (ql === null) throw Error(k(308));
         Tn = e, ql.dependencies = {
            lanes: 0,
            firstContext: e
         }
      } else Tn = Tn.next = e;
   return t
}
var tn = null;

function Hu(e) {
   tn === null ? tn = [e] : tn.push(e)
}

function Pf(e, t, n, r) {
   var l = t.interleaved;
   return l === null ? (n.next = n, Hu(t)) : (n.next = l.next, l.next = n), t.interleaved = n, yt(e, r)
}

function yt(e, t) {
   e.lanes |= t;
   var n = e.alternate;
   for (n !== null && (n.lanes |= t), n = e, e = e.return; e !== null;) e.childLanes |= t, n = e.alternate, n !== null && (n.childLanes |= t), n = e, e = e.return;
   return n.tag === 3 ? n.stateNode : null
}
var Rt = !1;

function Qu(e) {
   e.updateQueue = {
      baseState: e.memoizedState,
      firstBaseUpdate: null,
      lastBaseUpdate: null,
      shared: {
         pending: null,
         interleaved: null,
         lanes: 0
      },
      effects: null
   }
}

function Rf(e, t) {
   e = e.updateQueue, t.updateQueue === e && (t.updateQueue = {
      baseState: e.baseState,
      firstBaseUpdate: e.firstBaseUpdate,
      lastBaseUpdate: e.lastBaseUpdate,
      shared: e.shared,
      effects: e.effects
   })
}

function vt(e, t) {
   return {
      eventTime: e,
      lane: t,
      tag: 0,
      payload: null,
      callback: null,
      next: null
   }
}

function Ut(e, t, n) {
   var r = e.updateQueue;
   if (r === null) return null;
   if (r = r.shared, j & 2) {
      var l = r.pending;
      return l === null ? t.next = t : (t.next = l.next, l.next = t), r.pending = t, yt(e, n)
   }
   return l = r.interleaved, l === null ? (t.next = t, Hu(r)) : (t.next = l.next, l.next = t), r.interleaved = t, yt(e, n)
}

function Tl(e, t, n) {
   if (t = t.updateQueue, t !== null && (t = t.shared, (n & 4194240) !== 0)) {
      var r = t.lanes;
      r &= e.pendingLanes, n |= r, t.lanes = n, Tu(e, n)
   }
}

function ya(e, t) {
   var n = e.updateQueue,
      r = e.alternate;
   if (r !== null && (r = r.updateQueue, n === r)) {
      var l = null,
         o = null;
      if (n = n.firstBaseUpdate, n !== null) {
         do {
            var i = {
               eventTime: n.eventTime,
               lane: n.lane,
               tag: n.tag,
               payload: n.payload,
               callback: n.callback,
               next: null
            };
            o === null ? l = o = i : o = o.next = i, n = n.next
         } while (n !== null);
         o === null ? l = o = t : o = o.next = t
      } else l = o = t;
      n = {
         baseState: r.baseState,
         firstBaseUpdate: l,
         lastBaseUpdate: o,
         shared: r.shared,
         effects: r.effects
      }, e.updateQueue = n;
      return
   }
   e = n.lastBaseUpdate, e === null ? n.firstBaseUpdate = t : e.next = t, n.lastBaseUpdate = t
}

function bl(e, t, n, r) {
   var l = e.updateQueue;
   Rt = !1;
   var o = l.firstBaseUpdate,
      i = l.lastBaseUpdate,
      u = l.shared.pending;
   if (u !== null) {
      l.shared.pending = null;
      var s = u,
         a = s.next;
      s.next = null, i === null ? o = a : i.next = a, i = s;
      var p = e.alternate;
      p !== null && (p = p.updateQueue, u = p.lastBaseUpdate, u !== i && (u === null ? p.firstBaseUpdate = a : u.next = a, p.lastBaseUpdate = s))
   }
   if (o !== null) {
      var d = l.baseState;
      i = 0, p = a = s = null, u = o;
      do {
         var v = u.lane,
            m = u.eventTime;
         if ((r & v) === v) {
            p !== null && (p = p.next = {
               eventTime: m,
               lane: 0,
               tag: u.tag,
               payload: u.payload,
               callback: u.callback,
               next: null
            });
            e: {
               var w = e,
                  y = u;
               switch (v = t, m = n, y.tag) {
                  case 1:
                     if (w = y.payload, typeof w == "function") {
                        d = w.call(m, d, v);
                        break e
                     }
                     d = w;
                     break e;
                  case 3:
                     w.flags = w.flags & -65537 | 128;
                  case 0:
                     if (w = y.payload, v = typeof w == "function" ? w.call(m, d, v) : w, v == null) break e;
                     d = X({}, d, v);
                     break e;
                  case 2:
                     Rt = !0
               }
            }
            u.callback !== null && u.lane !== 0 && (e.flags |= 64, v = l.effects, v === null ? l.effects = [u] : v.push(u))
         } else m = {
            eventTime: m,
            lane: v,
            tag: u.tag,
            payload: u.payload,
            callback: u.callback,
            next: null
         }, p === null ? (a = p = m, s = d) : p = p.next = m, i |= v;
         if (u = u.next, u === null) {
            if (u = l.shared.pending, u === null) break;
            v = u, u = v.next, v.next = null, l.lastBaseUpdate = v, l.shared.pending = null
         }
      } while (!0);
      if (p === null && (s = d), l.baseState = s, l.firstBaseUpdate = a, l.lastBaseUpdate = p, t = l.shared.interleaved, t !== null) {
         l = t;
         do i |= l.lane, l = l.next; while (l !== t)
      } else o === null && (l.shared.lanes = 0);
      an |= i, e.lanes = i, e.memoizedState = d
   }
}

function wa(e, t, n) {
   if (e = t.effects, t.effects = null, e !== null)
      for (t = 0; t < e.length; t++) {
         var r = e[t],
            l = r.callback;
         if (l !== null) {
            if (r.callback = null, r = n, typeof l != "function") throw Error(k(191, l));
            l.call(r)
         }
      }
}
var br = {},
   at = Yt(br),
   Ur = Yt(br),
   Br = Yt(br);

function nn(e) {
   if (e === br) throw Error(k(174));
   return e
}

function Ku(e, t) {
   switch (B(Br, t), B(Ur, e), B(at, br), e = t.nodeType, e) {
      case 9:
      case 11:
         t = (t = t.documentElement) ? t.namespaceURI : Ti(null, "");
         break;
      default:
         e = e === 8 ? t.parentNode : t, t = e.namespaceURI || null, e = e.tagName, t = Ti(t, e)
   }
   W(at), B(at, t)
}

function Kn() {
   W(at), W(Ur), W(Br)
}

function Tf(e) {
   nn(Br.current);
   var t = nn(at.current),
      n = Ti(t, e.type);
   t !== n && (B(Ur, e), B(at, n))
}

function Yu(e) {
   Ur.current === e && (W(at), W(Ur))
}
var K = Yt(0);

function eo(e) {
   for (var t = e; t !== null;) {
      if (t.tag === 13) {
         var n = t.memoizedState;
         if (n !== null && (n = n.dehydrated, n === null || n.data === "$?" || n.data === "$!")) return t
      } else if (t.tag === 19 && t.memoizedProps.revealOrder !== void 0) {
         if (t.flags & 128) return t
      } else if (t.child !== null) {
         t.child.return = t, t = t.child;
         continue
      }
      if (t === e) break;
      for (; t.sibling === null;) {
         if (t.return === null || t.return === e) return null;
         t = t.return
      }
      t.sibling.return = t.return, t = t.sibling
   }
   return null
}
var ai = [];

function Xu() {
   for (var e = 0; e < ai.length; e++) ai[e]._workInProgressVersionPrimary = null;
   ai.length = 0
}
var Ol = xt.ReactCurrentDispatcher,
   ci = xt.ReactCurrentBatchConfig,
   sn = 0,
   Y = null,
   b = null,
   ne = null,
   to = !1,
   xr = !1,
   Vr = 0,
   _v = 0;

function ce() {
   throw Error(k(321))
}

function Gu(e, t) {
   if (t === null) return !1;
   for (var n = 0; n < t.length && n < e.length; n++)
      if (!et(e[n], t[n])) return !1;
   return !0
}

function Zu(e, t, n, r, l, o) {
   if (sn = o, Y = t, t.memoizedState = null, t.updateQueue = null, t.lanes = 0, Ol.current = e === null || e.memoizedState === null ? Ov : zv, e = n(r, l), xr) {
      o = 0;
      do {
         if (xr = !1, Vr = 0, 25 <= o) throw Error(k(301));
         o += 1, ne = b = null, t.updateQueue = null, Ol.current = Lv, e = n(r, l)
      } while (xr)
   }
   if (Ol.current = no, t = b !== null && b.next !== null, sn = 0, ne = b = Y = null, to = !1, t) throw Error(k(300));
   return e
}

function Ju() {
   var e = Vr !== 0;
   return Vr = 0, e
}

function it() {
   var e = {
      memoizedState: null,
      baseState: null,
      baseQueue: null,
      queue: null,
      next: null
   };
   return ne === null ? Y.memoizedState = ne = e : ne = ne.next = e, ne
}

function He() {
   if (b === null) {
      var e = Y.alternate;
      e = e !== null ? e.memoizedState : null
   } else e = b.next;
   var t = ne === null ? Y.memoizedState : ne.next;
   if (t !== null) ne = t, b = e;
   else {
      if (e === null) throw Error(k(310));
      b = e, e = {
         memoizedState: b.memoizedState,
         baseState: b.baseState,
         baseQueue: b.baseQueue,
         queue: b.queue,
         next: null
      }, ne === null ? Y.memoizedState = ne = e : ne = ne.next = e
   }
   return ne
}

function Wr(e, t) {
   return typeof t == "function" ? t(e) : t
}

function fi(e) {
   var t = He(),
      n = t.queue;
   if (n === null) throw Error(k(311));
   n.lastRenderedReducer = e;
   var r = b,
      l = r.baseQueue,
      o = n.pending;
   if (o !== null) {
      if (l !== null) {
         var i = l.next;
         l.next = o.next, o.next = i
      }
      r.baseQueue = l = o, n.pending = null
   }
   if (l !== null) {
      o = l.next, r = r.baseState;
      var u = i = null,
         s = null,
         a = o;
      do {
         var p = a.lane;
         if ((sn & p) === p) s !== null && (s = s.next = {
            lane: 0,
            action: a.action,
            hasEagerState: a.hasEagerState,
            eagerState: a.eagerState,
            next: null
         }), r = a.hasEagerState ? a.eagerState : e(r, a.action);
         else {
            var d = {
               lane: p,
               action: a.action,
               hasEagerState: a.hasEagerState,
               eagerState: a.eagerState,
               next: null
            };
            s === null ? (u = s = d, i = r) : s = s.next = d, Y.lanes |= p, an |= p
         }
         a = a.next
      } while (a !== null && a !== o);
      s === null ? i = r : s.next = u, et(r, t.memoizedState) || (ke = !0), t.memoizedState = r, t.baseState = i, t.baseQueue = s, n.lastRenderedState = r
   }
   if (e = n.interleaved, e !== null) {
      l = e;
      do o = l.lane, Y.lanes |= o, an |= o, l = l.next; while (l !== e)
   } else l === null && (n.lanes = 0);
   return [t.memoizedState, n.dispatch]
}

function di(e) {
   var t = He(),
      n = t.queue;
   if (n === null) throw Error(k(311));
   n.lastRenderedReducer = e;
   var r = n.dispatch,
      l = n.pending,
      o = t.memoizedState;
   if (l !== null) {
      n.pending = null;
      var i = l = l.next;
      do o = e(o, i.action), i = i.next; while (i !== l);
      et(o, t.memoizedState) || (ke = !0), t.memoizedState = o, t.baseQueue === null && (t.baseState = o), n.lastRenderedState = o
   }
   return [o, r]
}

function Of() {}

function zf(e, t) {
   var n = Y,
      r = He(),
      l = t(),
      o = !et(r.memoizedState, l);
   if (o && (r.memoizedState = l, ke = !0), r = r.queue, qu(jf.bind(null, n, r, e), [e]), r.getSnapshot !== t || o || ne !== null && ne.memoizedState.tag & 1) {
      if (n.flags |= 2048, Hr(9, Mf.bind(null, n, r, l, t), void 0, null), le === null) throw Error(k(349));
      sn & 30 || Lf(n, t, l)
   }
   return l
}

function Lf(e, t, n) {
   e.flags |= 16384, e = {
      getSnapshot: t,
      value: n
   }, t = Y.updateQueue, t === null ? (t = {
      lastEffect: null,
      stores: null
   }, Y.updateQueue = t, t.stores = [e]) : (n = t.stores, n === null ? t.stores = [e] : n.push(e))
}

function Mf(e, t, n, r) {
   t.value = n, t.getSnapshot = r, If(t) && Ff(e)
}

function jf(e, t, n) {
   return n(function () {
      If(t) && Ff(e)
   })
}

function If(e) {
   var t = e.getSnapshot;
   e = e.value;
   try {
      var n = t();
      return !et(e, n)
   } catch {
      return !0
   }
}

function Ff(e) {
   var t = yt(e, 1);
   t !== null && be(t, e, 1, -1)
}

function Sa(e) {
   var t = it();
   return typeof e == "function" && (e = e()), t.memoizedState = t.baseState = e, e = {
      pending: null,
      interleaved: null,
      lanes: 0,
      dispatch: null,
      lastRenderedReducer: Wr,
      lastRenderedState: e
   }, t.queue = e, e = e.dispatch = Tv.bind(null, Y, e), [t.memoizedState, e]
}

function Hr(e, t, n, r) {
   return e = {
      tag: e,
      create: t,
      destroy: n,
      deps: r,
      next: null
   }, t = Y.updateQueue, t === null ? (t = {
      lastEffect: null,
      stores: null
   }, Y.updateQueue = t, t.lastEffect = e.next = e) : (n = t.lastEffect, n === null ? t.lastEffect = e.next = e : (r = n.next, n.next = e, e.next = r, t.lastEffect = e)), e
}

function Af() {
   return He().memoizedState
}

function zl(e, t, n, r) {
   var l = it();
   Y.flags |= e, l.memoizedState = Hr(1 | t, n, void 0, r === void 0 ? null : r)
}

function Do(e, t, n, r) {
   var l = He();
   r = r === void 0 ? null : r;
   var o = void 0;
   if (b !== null) {
      var i = b.memoizedState;
      if (o = i.destroy, r !== null && Gu(r, i.deps)) {
         l.memoizedState = Hr(t, n, o, r);
         return
      }
   }
   Y.flags |= e, l.memoizedState = Hr(1 | t, n, o, r)
}

function xa(e, t) {
   return zl(8390656, 8, e, t)
}

function qu(e, t) {
   return Do(2048, 8, e, t)
}

function $f(e, t) {
   return Do(4, 2, e, t)
}

function Uf(e, t) {
   return Do(4, 4, e, t)
}

function Bf(e, t) {
   if (typeof t == "function") return e = e(), t(e),
      function () {
         t(null)
      };
   if (t != null) return e = e(), t.current = e,
      function () {
         t.current = null
      }
}

function Vf(e, t, n) {
   return n = n != null ? n.concat([e]) : null, Do(4, 4, Bf.bind(null, t, e), n)
}

function bu() {}

function Wf(e, t) {
   var n = He();
   t = t === void 0 ? null : t;
   var r = n.memoizedState;
   return r !== null && t !== null && Gu(t, r[1]) ? r[0] : (n.memoizedState = [e, t], e)
}

function Hf(e, t) {
   var n = He();
   t = t === void 0 ? null : t;
   var r = n.memoizedState;
   return r !== null && t !== null && Gu(t, r[1]) ? r[0] : (e = e(), n.memoizedState = [e, t], e)
}

function Qf(e, t, n) {
   return sn & 21 ? (et(n, t) || (n = Gc(), Y.lanes |= n, an |= n, e.baseState = !0), t) : (e.baseState && (e.baseState = !1, ke = !0), e.memoizedState = n)
}

function Pv(e, t) {
   var n = A;
   A = n !== 0 && 4 > n ? n : 4, e(!0);
   var r = ci.transition;
   ci.transition = {};
   try {
      e(!1), t()
   } finally {
      A = n, ci.transition = r
   }
}

function Kf() {
   return He().memoizedState
}

function Rv(e, t, n) {
   var r = Vt(e);
   if (n = {
         lane: r,
         action: n,
         hasEagerState: !1,
         eagerState: null,
         next: null
      }, Yf(e)) Xf(t, n);
   else if (n = Pf(e, t, n, r), n !== null) {
      var l = ge();
      be(n, e, r, l), Gf(n, t, r)
   }
}

function Tv(e, t, n) {
   var r = Vt(e),
      l = {
         lane: r,
         action: n,
         hasEagerState: !1,
         eagerState: null,
         next: null
      };
   if (Yf(e)) Xf(t, l);
   else {
      var o = e.alternate;
      if (e.lanes === 0 && (o === null || o.lanes === 0) && (o = t.lastRenderedReducer, o !== null)) try {
         var i = t.lastRenderedState,
            u = o(i, n);
         if (l.hasEagerState = !0, l.eagerState = u, et(u, i)) {
            var s = t.interleaved;
            s === null ? (l.next = l, Hu(t)) : (l.next = s.next, s.next = l), t.interleaved = l;
            return
         }
      } catch {} finally {}
      n = Pf(e, t, l, r), n !== null && (l = ge(), be(n, e, r, l), Gf(n, t, r))
   }
}

function Yf(e) {
   var t = e.alternate;
   return e === Y || t !== null && t === Y
}

function Xf(e, t) {
   xr = to = !0;
   var n = e.pending;
   n === null ? t.next = t : (t.next = n.next, n.next = t), e.pending = t
}

function Gf(e, t, n) {
   if (n & 4194240) {
      var r = t.lanes;
      r &= e.pendingLanes, n |= r, t.lanes = n, Tu(e, n)
   }
}
var no = {
      readContext: We,
      useCallback: ce,
      useContext: ce,
      useEffect: ce,
      useImperativeHandle: ce,
      useInsertionEffect: ce,
      useLayoutEffect: ce,
      useMemo: ce,
      useReducer: ce,
      useRef: ce,
      useState: ce,
      useDebugValue: ce,
      useDeferredValue: ce,
      useTransition: ce,
      useMutableSource: ce,
      useSyncExternalStore: ce,
      useId: ce,
      unstable_isNewReconciler: !1
   },
   Ov = {
      readContext: We,
      useCallback: function (e, t) {
         return it().memoizedState = [e, t === void 0 ? null : t], e
      },
      useContext: We,
      useEffect: xa,
      useImperativeHandle: function (e, t, n) {
         return n = n != null ? n.concat([e]) : null, zl(4194308, 4, Bf.bind(null, t, e), n)
      },
      useLayoutEffect: function (e, t) {
         return zl(4194308, 4, e, t)
      },
      useInsertionEffect: function (e, t) {
         return zl(4, 2, e, t)
      },
      useMemo: function (e, t) {
         var n = it();
         return t = t === void 0 ? null : t, e = e(), n.memoizedState = [e, t], e
      },
      useReducer: function (e, t, n) {
         var r = it();
         return t = n !== void 0 ? n(t) : t, r.memoizedState = r.baseState = t, e = {
            pending: null,
            interleaved: null,
            lanes: 0,
            dispatch: null,
            lastRenderedReducer: e,
            lastRenderedState: t
         }, r.queue = e, e = e.dispatch = Rv.bind(null, Y, e), [r.memoizedState, e]
      },
      useRef: function (e) {
         var t = it();
         return e = {
            current: e
         }, t.memoizedState = e
      },
      useState: Sa,
      useDebugValue: bu,
      useDeferredValue: function (e) {
         return it().memoizedState = e
      },
      useTransition: function () {
         var e = Sa(!1),
            t = e[0];
         return e = Pv.bind(null, e[1]), it().memoizedState = e, [t, e]
      },
      useMutableSource: function () {},
      useSyncExternalStore: function (e, t, n) {
         var r = Y,
            l = it();
         if (Q) {
            if (n === void 0) throw Error(k(407));
            n = n()
         } else {
            if (n = t(), le === null) throw Error(k(349));
            sn & 30 || Lf(r, t, n)
         }
         l.memoizedState = n;
         var o = {
            value: n,
            getSnapshot: t
         };
         return l.queue = o, xa(jf.bind(null, r, o, e), [e]), r.flags |= 2048, Hr(9, Mf.bind(null, r, o, n, t), void 0, null), n
      },
      useId: function () {
         var e = it(),
            t = le.identifierPrefix;
         if (Q) {
            var n = ht,
               r = pt;
            n = (r & ~(1 << 32 - qe(r) - 1)).toString(32) + n, t = ":" + t + "R" + n, n = Vr++, 0 < n && (t += "H" + n.toString(32)), t += ":"
         } else n = _v++, t = ":" + t + "r" + n.toString(32) + ":";
         return e.memoizedState = t
      },
      unstable_isNewReconciler: !1
   },
   zv = {
      readContext: We,
      useCallback: Wf,
      useContext: We,
      useEffect: qu,
      useImperativeHandle: Vf,
      useInsertionEffect: $f,
      useLayoutEffect: Uf,
      useMemo: Hf,
      useReducer: fi,
      useRef: Af,
      useState: function () {
         return fi(Wr)
      },
      useDebugValue: bu,
      useDeferredValue: function (e) {
         var t = He();
         return Qf(t, b.memoizedState, e)
      },
      useTransition: function () {
         var e = fi(Wr)[0],
            t = He().memoizedState;
         return [e, t]
      },
      useMutableSource: Of,
      useSyncExternalStore: zf,
      useId: Kf,
      unstable_isNewReconciler: !1
   },
   Lv = {
      readContext: We,
      useCallback: Wf,
      useContext: We,
      useEffect: qu,
      useImperativeHandle: Vf,
      useInsertionEffect: $f,
      useLayoutEffect: Uf,
      useMemo: Hf,
      useReducer: di,
      useRef: Af,
      useState: function () {
         return di(Wr)
      },
      useDebugValue: bu,
      useDeferredValue: function (e) {
         var t = He();
         return b === null ? t.memoizedState = e : Qf(t, b.memoizedState, e)
      },
      useTransition: function () {
         var e = di(Wr)[0],
            t = He().memoizedState;
         return [e, t]
      },
      useMutableSource: Of,
      useSyncExternalStore: zf,
      useId: Kf,
      unstable_isNewReconciler: !1
   };

function Ge(e, t) {
   if (e && e.defaultProps) {
      t = X({}, t), e = e.defaultProps;
      for (var n in e) t[n] === void 0 && (t[n] = e[n]);
      return t
   }
   return t
}

function Ji(e, t, n, r) {
   t = e.memoizedState, n = n(r, t), n = n == null ? t : X({}, t, n), e.memoizedState = n, e.lanes === 0 && (e.updateQueue.baseState = n)
}
var _o = {
   isMounted: function (e) {
      return (e = e._reactInternals) ? dn(e) === e : !1
   },
   enqueueSetState: function (e, t, n) {
      e = e._reactInternals;
      var r = ge(),
         l = Vt(e),
         o = vt(r, l);
      o.payload = t, n != null && (o.callback = n), t = Ut(e, o, l), t !== null && (be(t, e, l, r), Tl(t, e, l))
   },
   enqueueReplaceState: function (e, t, n) {
      e = e._reactInternals;
      var r = ge(),
         l = Vt(e),
         o = vt(r, l);
      o.tag = 1, o.payload = t, n != null && (o.callback = n), t = Ut(e, o, l), t !== null && (be(t, e, l, r), Tl(t, e, l))
   },
   enqueueForceUpdate: function (e, t) {
      e = e._reactInternals;
      var n = ge(),
         r = Vt(e),
         l = vt(n, r);
      l.tag = 2, t != null && (l.callback = t), t = Ut(e, l, r), t !== null && (be(t, e, r, n), Tl(t, e, r))
   }
};

function ka(e, t, n, r, l, o, i) {
   return e = e.stateNode, typeof e.shouldComponentUpdate == "function" ? e.shouldComponentUpdate(r, o, i) : t.prototype && t.prototype.isPureReactComponent ? !Ir(n, r) || !Ir(l, o) : !0
}

function Zf(e, t, n) {
   var r = !1,
      l = Qt,
      o = t.contextType;
   return typeof o == "object" && o !== null ? o = We(o) : (l = Ce(t) ? on : pe.current, r = t.contextTypes, o = (r = r != null) ? Wn(e, l) : Qt), t = new t(n, o), e.memoizedState = t.state !== null && t.state !== void 0 ? t.state : null, t.updater = _o, e.stateNode = t, t._reactInternals = e, r && (e = e.stateNode, e.__reactInternalMemoizedUnmaskedChildContext = l, e.__reactInternalMemoizedMaskedChildContext = o), t
}

function Ea(e, t, n, r) {
   e = t.state, typeof t.componentWillReceiveProps == "function" && t.componentWillReceiveProps(n, r), typeof t.UNSAFE_componentWillReceiveProps == "function" && t.UNSAFE_componentWillReceiveProps(n, r), t.state !== e && _o.enqueueReplaceState(t, t.state, null)
}

function qi(e, t, n, r) {
   var l = e.stateNode;
   l.props = n, l.state = e.memoizedState, l.refs = {}, Qu(e);
   var o = t.contextType;
   typeof o == "object" && o !== null ? l.context = We(o) : (o = Ce(t) ? on : pe.current, l.context = Wn(e, o)), l.state = e.memoizedState, o = t.getDerivedStateFromProps, typeof o == "function" && (Ji(e, t, o, n), l.state = e.memoizedState), typeof t.getDerivedStateFromProps == "function" || typeof l.getSnapshotBeforeUpdate == "function" || typeof l.UNSAFE_componentWillMount != "function" && typeof l.componentWillMount != "function" || (t = l.state, typeof l.componentWillMount == "function" && l.componentWillMount(), typeof l.UNSAFE_componentWillMount == "function" && l.UNSAFE_componentWillMount(), t !== l.state && _o.enqueueReplaceState(l, l.state, null), bl(e, n, l, r), l.state = e.memoizedState), typeof l.componentDidMount == "function" && (e.flags |= 4194308)
}

function Yn(e, t) {
   try {
      var n = "",
         r = t;
      do n += uh(r), r = r.return; while (r);
      var l = n
   } catch (o) {
      l = `
Error generating stack: ` + o.message + `
` + o.stack
   }
   return {
      value: e,
      source: t,
      stack: l,
      digest: null
   }
}

function pi(e, t, n) {
   return {
      value: e,
      source: null,
      stack: n ?? null,
      digest: t ?? null
   }
}

function bi(e, t) {
   try {
      console.error(t.value)
   } catch (n) {
      setTimeout(function () {
         throw n
      })
   }
}
var Mv = typeof WeakMap == "function" ? WeakMap : Map;

function Jf(e, t, n) {
   n = vt(-1, n), n.tag = 3, n.payload = {
      element: null
   };
   var r = t.value;
   return n.callback = function () {
      lo || (lo = !0, au = r), bi(e, t)
   }, n
}

function qf(e, t, n) {
   n = vt(-1, n), n.tag = 3;
   var r = e.type.getDerivedStateFromError;
   if (typeof r == "function") {
      var l = t.value;
      n.payload = function () {
         return r(l)
      }, n.callback = function () {
         bi(e, t)
      }
   }
   var o = e.stateNode;
   return o !== null && typeof o.componentDidCatch == "function" && (n.callback = function () {
      bi(e, t), typeof r != "function" && (Bt === null ? Bt = new Set([this]) : Bt.add(this));
      var i = t.stack;
      this.componentDidCatch(t.value, {
         componentStack: i !== null ? i : ""
      })
   }), n
}

function Ca(e, t, n) {
   var r = e.pingCache;
   if (r === null) {
      r = e.pingCache = new Mv;
      var l = new Set;
      r.set(t, l)
   } else l = r.get(t), l === void 0 && (l = new Set, r.set(t, l));
   l.has(n) || (l.add(n), e = Xv.bind(null, e, t, n), t.then(e, e))
}

function Na(e) {
   do {
      var t;
      if ((t = e.tag === 13) && (t = e.memoizedState, t = t !== null ? t.dehydrated !== null : !0), t) return e;
      e = e.return
   } while (e !== null);
   return null
}

function Da(e, t, n, r, l) {
   return e.mode & 1 ? (e.flags |= 65536, e.lanes = l, e) : (e === t ? e.flags |= 65536 : (e.flags |= 128, n.flags |= 131072, n.flags &= -52805, n.tag === 1 && (n.alternate === null ? n.tag = 17 : (t = vt(-1, 1), t.tag = 2, Ut(n, t, 1))), n.lanes |= 1), e)
}
var jv = xt.ReactCurrentOwner,
   ke = !1;

function me(e, t, n, r) {
   t.child = e === null ? _f(t, null, n, r) : Qn(t, e.child, n, r)
}

function _a(e, t, n, r, l) {
   n = n.render;
   var o = t.ref;
   return An(t, l), r = Zu(e, t, n, r, o, l), n = Ju(), e !== null && !ke ? (t.updateQueue = e.updateQueue, t.flags &= -2053, e.lanes &= ~l, wt(e, t, l)) : (Q && n && Au(t), t.flags |= 1, me(e, t, r, l), t.child)
}

function Pa(e, t, n, r, l) {
   if (e === null) {
      var o = n.type;
      return typeof o == "function" && !us(o) && o.defaultProps === void 0 && n.compare === null && n.defaultProps === void 0 ? (t.tag = 15, t.type = o, bf(e, t, o, r, l)) : (e = Il(n.type, null, r, t, t.mode, l), e.ref = t.ref, e.return = t, t.child = e)
   }
   if (o = e.child, !(e.lanes & l)) {
      var i = o.memoizedProps;
      if (n = n.compare, n = n !== null ? n : Ir, n(i, r) && e.ref === t.ref) return wt(e, t, l)
   }
   return t.flags |= 1, e = Wt(o, r), e.ref = t.ref, e.return = t, t.child = e
}

function bf(e, t, n, r, l) {
   if (e !== null) {
      var o = e.memoizedProps;
      if (Ir(o, r) && e.ref === t.ref)
         if (ke = !1, t.pendingProps = r = o, (e.lanes & l) !== 0) e.flags & 131072 && (ke = !0);
         else return t.lanes = e.lanes, wt(e, t, l)
   }
   return eu(e, t, n, r, l)
}

function ed(e, t, n) {
   var r = t.pendingProps,
      l = r.children,
      o = e !== null ? e.memoizedState : null;
   if (r.mode === "hidden")
      if (!(t.mode & 1)) t.memoizedState = {
         baseLanes: 0,
         cachePool: null,
         transitions: null
      }, B(zn, Te), Te |= n;
      else {
         if (!(n & 1073741824)) return e = o !== null ? o.baseLanes | n : n, t.lanes = t.childLanes = 1073741824, t.memoizedState = {
            baseLanes: e,
            cachePool: null,
            transitions: null
         }, t.updateQueue = null, B(zn, Te), Te |= e, null;
         t.memoizedState = {
            baseLanes: 0,
            cachePool: null,
            transitions: null
         }, r = o !== null ? o.baseLanes : n, B(zn, Te), Te |= r
      }
   else o !== null ? (r = o.baseLanes | n, t.memoizedState = null) : r = n, B(zn, Te), Te |= r;
   return me(e, t, l, n), t.child
}

function td(e, t) {
   var n = t.ref;
   (e === null && n !== null || e !== null && e.ref !== n) && (t.flags |= 512, t.flags |= 2097152)
}

function eu(e, t, n, r, l) {
   var o = Ce(n) ? on : pe.current;
   return o = Wn(t, o), An(t, l), n = Zu(e, t, n, r, o, l), r = Ju(), e !== null && !ke ? (t.updateQueue = e.updateQueue, t.flags &= -2053, e.lanes &= ~l, wt(e, t, l)) : (Q && r && Au(t), t.flags |= 1, me(e, t, n, l), t.child)
}

function Ra(e, t, n, r, l) {
   if (Ce(n)) {
      var o = !0;
      Xl(t)
   } else o = !1;
   if (An(t, l), t.stateNode === null) Ll(e, t), Zf(t, n, r), qi(t, n, r, l), r = !0;
   else if (e === null) {
      var i = t.stateNode,
         u = t.memoizedProps;
      i.props = u;
      var s = i.context,
         a = n.contextType;
      typeof a == "object" && a !== null ? a = We(a) : (a = Ce(n) ? on : pe.current, a = Wn(t, a));
      var p = n.getDerivedStateFromProps,
         d = typeof p == "function" || typeof i.getSnapshotBeforeUpdate == "function";
      d || typeof i.UNSAFE_componentWillReceiveProps != "function" && typeof i.componentWillReceiveProps != "function" || (u !== r || s !== a) && Ea(t, i, r, a), Rt = !1;
      var v = t.memoizedState;
      i.state = v, bl(t, r, i, l), s = t.memoizedState, u !== r || v !== s || Ee.current || Rt ? (typeof p == "function" && (Ji(t, n, p, r), s = t.memoizedState), (u = Rt || ka(t, n, u, r, v, s, a)) ? (d || typeof i.UNSAFE_componentWillMount != "function" && typeof i.componentWillMount != "function" || (typeof i.componentWillMount == "function" && i.componentWillMount(), typeof i.UNSAFE_componentWillMount == "function" && i.UNSAFE_componentWillMount()), typeof i.componentDidMount == "function" && (t.flags |= 4194308)) : (typeof i.componentDidMount == "function" && (t.flags |= 4194308), t.memoizedProps = r, t.memoizedState = s), i.props = r, i.state = s, i.context = a, r = u) : (typeof i.componentDidMount == "function" && (t.flags |= 4194308), r = !1)
   } else {
      i = t.stateNode, Rf(e, t), u = t.memoizedProps, a = t.type === t.elementType ? u : Ge(t.type, u), i.props = a, d = t.pendingProps, v = i.context, s = n.contextType, typeof s == "object" && s !== null ? s = We(s) : (s = Ce(n) ? on : pe.current, s = Wn(t, s));
      var m = n.getDerivedStateFromProps;
      (p = typeof m == "function" || typeof i.getSnapshotBeforeUpdate == "function") || typeof i.UNSAFE_componentWillReceiveProps != "function" && typeof i.componentWillReceiveProps != "function" || (u !== d || v !== s) && Ea(t, i, r, s), Rt = !1, v = t.memoizedState, i.state = v, bl(t, r, i, l);
      var w = t.memoizedState;
      u !== d || v !== w || Ee.current || Rt ? (typeof m == "function" && (Ji(t, n, m, r), w = t.memoizedState), (a = Rt || ka(t, n, a, r, v, w, s) || !1) ? (p || typeof i.UNSAFE_componentWillUpdate != "function" && typeof i.componentWillUpdate != "function" || (typeof i.componentWillUpdate == "function" && i.componentWillUpdate(r, w, s), typeof i.UNSAFE_componentWillUpdate == "function" && i.UNSAFE_componentWillUpdate(r, w, s)), typeof i.componentDidUpdate == "function" && (t.flags |= 4), typeof i.getSnapshotBeforeUpdate == "function" && (t.flags |= 1024)) : (typeof i.componentDidUpdate != "function" || u === e.memoizedProps && v === e.memoizedState || (t.flags |= 4), typeof i.getSnapshotBeforeUpdate != "function" || u === e.memoizedProps && v === e.memoizedState || (t.flags |= 1024), t.memoizedProps = r, t.memoizedState = w), i.props = r, i.state = w, i.context = s, r = a) : (typeof i.componentDidUpdate != "function" || u === e.memoizedProps && v === e.memoizedState || (t.flags |= 4), typeof i.getSnapshotBeforeUpdate != "function" || u === e.memoizedProps && v === e.memoizedState || (t.flags |= 1024), r = !1)
   }
   return tu(e, t, n, r, o, l)
}

function tu(e, t, n, r, l, o) {
   td(e, t);
   var i = (t.flags & 128) !== 0;
   if (!r && !i) return l && ha(t, n, !1), wt(e, t, o);
   r = t.stateNode, jv.current = t;
   var u = i && typeof n.getDerivedStateFromError != "function" ? null : r.render();
   return t.flags |= 1, e !== null && i ? (t.child = Qn(t, e.child, null, o), t.child = Qn(t, null, u, o)) : me(e, t, u, o), t.memoizedState = r.state, l && ha(t, n, !0), t.child
}

function nd(e) {
   var t = e.stateNode;
   t.pendingContext ? pa(e, t.pendingContext, t.pendingContext !== t.context) : t.context && pa(e, t.context, !1), Ku(e, t.containerInfo)
}

function Ta(e, t, n, r, l) {
   return Hn(), Uu(l), t.flags |= 256, me(e, t, n, r), t.child
}
var nu = {
   dehydrated: null,
   treeContext: null,
   retryLane: 0
};

function ru(e) {
   return {
      baseLanes: e,
      cachePool: null,
      transitions: null
   }
}

function rd(e, t, n) {
   var r = t.pendingProps,
      l = K.current,
      o = !1,
      i = (t.flags & 128) !== 0,
      u;
   if ((u = i) || (u = e !== null && e.memoizedState === null ? !1 : (l & 2) !== 0), u ? (o = !0, t.flags &= -129) : (e === null || e.memoizedState !== null) && (l |= 1), B(K, l & 1), e === null) return Gi(t), e = t.memoizedState, e !== null && (e = e.dehydrated, e !== null) ? (t.mode & 1 ? e.data === "$!" ? t.lanes = 8 : t.lanes = 1073741824 : t.lanes = 1, null) : (i = r.children, e = r.fallback, o ? (r = t.mode, o = t.child, i = {
      mode: "hidden",
      children: i
   }, !(r & 1) && o !== null ? (o.childLanes = 0, o.pendingProps = i) : o = To(i, r, 0, null), e = ln(e, r, n, null), o.return = t, e.return = t, o.sibling = e, t.child = o, t.child.memoizedState = ru(n), t.memoizedState = nu, e) : es(t, i));
   if (l = e.memoizedState, l !== null && (u = l.dehydrated, u !== null)) return Iv(e, t, i, r, u, l, n);
   if (o) {
      o = r.fallback, i = t.mode, l = e.child, u = l.sibling;
      var s = {
         mode: "hidden",
         children: r.children
      };
      return !(i & 1) && t.child !== l ? (r = t.child, r.childLanes = 0, r.pendingProps = s, t.deletions = null) : (r = Wt(l, s), r.subtreeFlags = l.subtreeFlags & 14680064), u !== null ? o = Wt(u, o) : (o = ln(o, i, n, null), o.flags |= 2), o.return = t, r.return = t, r.sibling = o, t.child = r, r = o, o = t.child, i = e.child.memoizedState, i = i === null ? ru(n) : {
         baseLanes: i.baseLanes | n,
         cachePool: null,
         transitions: i.transitions
      }, o.memoizedState = i, o.childLanes = e.childLanes & ~n, t.memoizedState = nu, r
   }
   return o = e.child, e = o.sibling, r = Wt(o, {
      mode: "visible",
      children: r.children
   }), !(t.mode & 1) && (r.lanes = n), r.return = t, r.sibling = null, e !== null && (n = t.deletions, n === null ? (t.deletions = [e], t.flags |= 16) : n.push(e)), t.child = r, t.memoizedState = null, r
}

function es(e, t) {
   return t = To({
      mode: "visible",
      children: t
   }, e.mode, 0, null), t.return = e, e.child = t
}

function xl(e, t, n, r) {
   return r !== null && Uu(r), Qn(t, e.child, null, n), e = es(t, t.pendingProps.children), e.flags |= 2, t.memoizedState = null, e
}

function Iv(e, t, n, r, l, o, i) {
   if (n) return t.flags & 256 ? (t.flags &= -257, r = pi(Error(k(422))), xl(e, t, i, r)) : t.memoizedState !== null ? (t.child = e.child, t.flags |= 128, null) : (o = r.fallback, l = t.mode, r = To({
      mode: "visible",
      children: r.children
   }, l, 0, null), o = ln(o, l, i, null), o.flags |= 2, r.return = t, o.return = t, r.sibling = o, t.child = r, t.mode & 1 && Qn(t, e.child, null, i), t.child.memoizedState = ru(i), t.memoizedState = nu, o);
   if (!(t.mode & 1)) return xl(e, t, i, null);
   if (l.data === "$!") {
      if (r = l.nextSibling && l.nextSibling.dataset, r) var u = r.dgst;
      return r = u, o = Error(k(419)), r = pi(o, r, void 0), xl(e, t, i, r)
   }
   if (u = (i & e.childLanes) !== 0, ke || u) {
      if (r = le, r !== null) {
         switch (i & -i) {
            case 4:
               l = 2;
               break;
            case 16:
               l = 8;
               break;
            case 64:
            case 128:
            case 256:
            case 512:
            case 1024:
            case 2048:
            case 4096:
            case 8192:
            case 16384:
            case 32768:
            case 65536:
            case 131072:
            case 262144:
            case 524288:
            case 1048576:
            case 2097152:
            case 4194304:
            case 8388608:
            case 16777216:
            case 33554432:
            case 67108864:
               l = 32;
               break;
            case 536870912:
               l = 268435456;
               break;
            default:
               l = 0
         }
         l = l & (r.suspendedLanes | i) ? 0 : l, l !== 0 && l !== o.retryLane && (o.retryLane = l, yt(e, l), be(r, e, l, -1))
      }
      return is(), r = pi(Error(k(421))), xl(e, t, i, r)
   }
   return l.data === "$?" ? (t.flags |= 128, t.child = e.child, t = Gv.bind(null, e), l._reactRetry = t, null) : (e = o.treeContext, Oe = $t(l.nextSibling), ze = t, Q = !0, Je = null, e !== null && ($e[Ue++] = pt, $e[Ue++] = ht, $e[Ue++] = un, pt = e.id, ht = e.overflow, un = t), t = es(t, r.children), t.flags |= 4096, t)
}

function Oa(e, t, n) {
   e.lanes |= t;
   var r = e.alternate;
   r !== null && (r.lanes |= t), Zi(e.return, t, n)
}

function hi(e, t, n, r, l) {
   var o = e.memoizedState;
   o === null ? e.memoizedState = {
      isBackwards: t,
      rendering: null,
      renderingStartTime: 0,
      last: r,
      tail: n,
      tailMode: l
   } : (o.isBackwards = t, o.rendering = null, o.renderingStartTime = 0, o.last = r, o.tail = n, o.tailMode = l)
}

function ld(e, t, n) {
   var r = t.pendingProps,
      l = r.revealOrder,
      o = r.tail;
   if (me(e, t, r.children, n), r = K.current, r & 2) r = r & 1 | 2, t.flags |= 128;
   else {
      if (e !== null && e.flags & 128) e: for (e = t.child; e !== null;) {
         if (e.tag === 13) e.memoizedState !== null && Oa(e, n, t);
         else if (e.tag === 19) Oa(e, n, t);
         else if (e.child !== null) {
            e.child.return = e, e = e.child;
            continue
         }
         if (e === t) break e;
         for (; e.sibling === null;) {
            if (e.return === null || e.return === t) break e;
            e = e.return
         }
         e.sibling.return = e.return, e = e.sibling
      }
      r &= 1
   }
   if (B(K, r), !(t.mode & 1)) t.memoizedState = null;
   else switch (l) {
      case "forwards":
         for (n = t.child, l = null; n !== null;) e = n.alternate, e !== null && eo(e) === null && (l = n), n = n.sibling;
         n = l, n === null ? (l = t.child, t.child = null) : (l = n.sibling, n.sibling = null), hi(t, !1, l, n, o);
         break;
      case "backwards":
         for (n = null, l = t.child, t.child = null; l !== null;) {
            if (e = l.alternate, e !== null && eo(e) === null) {
               t.child = l;
               break
            }
            e = l.sibling, l.sibling = n, n = l, l = e
         }
         hi(t, !0, n, null, o);
         break;
      case "together":
         hi(t, !1, null, null, void 0);
         break;
      default:
         t.memoizedState = null
   }
   return t.child
}

function Ll(e, t) {
   !(t.mode & 1) && e !== null && (e.alternate = null, t.alternate = null, t.flags |= 2)
}

function wt(e, t, n) {
   if (e !== null && (t.dependencies = e.dependencies), an |= t.lanes, !(n & t.childLanes)) return null;
   if (e !== null && t.child !== e.child) throw Error(k(153));
   if (t.child !== null) {
      for (e = t.child, n = Wt(e, e.pendingProps), t.child = n, n.return = t; e.sibling !== null;) e = e.sibling, n = n.sibling = Wt(e, e.pendingProps), n.return = t;
      n.sibling = null
   }
   return t.child
}

function Fv(e, t, n) {
   switch (t.tag) {
      case 3:
         nd(t), Hn();
         break;
      case 5:
         Tf(t);
         break;
      case 1:
         Ce(t.type) && Xl(t);
         break;
      case 4:
         Ku(t, t.stateNode.containerInfo);
         break;
      case 10:
         var r = t.type._context,
            l = t.memoizedProps.value;
         B(Jl, r._currentValue), r._currentValue = l;
         break;
      case 13:
         if (r = t.memoizedState, r !== null) return r.dehydrated !== null ? (B(K, K.current & 1), t.flags |= 128, null) : n & t.child.childLanes ? rd(e, t, n) : (B(K, K.current & 1), e = wt(e, t, n), e !== null ? e.sibling : null);
         B(K, K.current & 1);
         break;
      case 19:
         if (r = (n & t.childLanes) !== 0, e.flags & 128) {
            if (r) return ld(e, t, n);
            t.flags |= 128
         }
         if (l = t.memoizedState, l !== null && (l.rendering = null, l.tail = null, l.lastEffect = null), B(K, K.current), r) break;
         return null;
      case 22:
      case 23:
         return t.lanes = 0, ed(e, t, n)
   }
   return wt(e, t, n)
}
var od, lu, id, ud;
od = function (e, t) {
   for (var n = t.child; n !== null;) {
      if (n.tag === 5 || n.tag === 6) e.appendChild(n.stateNode);
      else if (n.tag !== 4 && n.child !== null) {
         n.child.return = n, n = n.child;
         continue
      }
      if (n === t) break;
      for (; n.sibling === null;) {
         if (n.return === null || n.return === t) return;
         n = n.return
      }
      n.sibling.return = n.return, n = n.sibling
   }
};
lu = function () {};
id = function (e, t, n, r) {
   var l = e.memoizedProps;
   if (l !== r) {
      e = t.stateNode, nn(at.current);
      var o = null;
      switch (n) {
         case "input":
            l = Di(e, l), r = Di(e, r), o = [];
            break;
         case "select":
            l = X({}, l, {
               value: void 0
            }), r = X({}, r, {
               value: void 0
            }), o = [];
            break;
         case "textarea":
            l = Ri(e, l), r = Ri(e, r), o = [];
            break;
         default:
            typeof l.onClick != "function" && typeof r.onClick == "function" && (e.onclick = Kl)
      }
      Oi(n, r);
      var i;
      n = null;
      for (a in l)
         if (!r.hasOwnProperty(a) && l.hasOwnProperty(a) && l[a] != null)
            if (a === "style") {
               var u = l[a];
               for (i in u) u.hasOwnProperty(i) && (n || (n = {}), n[i] = "")
            } else a !== "dangerouslySetInnerHTML" && a !== "children" && a !== "suppressContentEditableWarning" && a !== "suppressHydrationWarning" && a !== "autoFocus" && (Rr.hasOwnProperty(a) ? o || (o = []) : (o = o || []).push(a, null));
      for (a in r) {
         var s = r[a];
         if (u = l != null ? l[a] : void 0, r.hasOwnProperty(a) && s !== u && (s != null || u != null))
            if (a === "style")
               if (u) {
                  for (i in u) !u.hasOwnProperty(i) || s && s.hasOwnProperty(i) || (n || (n = {}), n[i] = "");
                  for (i in s) s.hasOwnProperty(i) && u[i] !== s[i] && (n || (n = {}), n[i] = s[i])
               } else n || (o || (o = []), o.push(a, n)), n = s;
         else a === "dangerouslySetInnerHTML" ? (s = s ? s.__html : void 0, u = u ? u.__html : void 0, s != null && u !== s && (o = o || []).push(a, s)) : a === "children" ? typeof s != "string" && typeof s != "number" || (o = o || []).push(a, "" + s) : a !== "suppressContentEditableWarning" && a !== "suppressHydrationWarning" && (Rr.hasOwnProperty(a) ? (s != null && a === "onScroll" && V("scroll", e), o || u === s || (o = [])) : (o = o || []).push(a, s))
      }
      n && (o = o || []).push("style", n);
      var a = o;
      (t.updateQueue = a) && (t.flags |= 4)
   }
};
ud = function (e, t, n, r) {
   n !== r && (t.flags |= 4)
};

function cr(e, t) {
   if (!Q) switch (e.tailMode) {
      case "hidden":
         t = e.tail;
         for (var n = null; t !== null;) t.alternate !== null && (n = t), t = t.sibling;
         n === null ? e.tail = null : n.sibling = null;
         break;
      case "collapsed":
         n = e.tail;
         for (var r = null; n !== null;) n.alternate !== null && (r = n), n = n.sibling;
         r === null ? t || e.tail === null ? e.tail = null : e.tail.sibling = null : r.sibling = null
   }
}

function fe(e) {
   var t = e.alternate !== null && e.alternate.child === e.child,
      n = 0,
      r = 0;
   if (t)
      for (var l = e.child; l !== null;) n |= l.lanes | l.childLanes, r |= l.subtreeFlags & 14680064, r |= l.flags & 14680064, l.return = e, l = l.sibling;
   else
      for (l = e.child; l !== null;) n |= l.lanes | l.childLanes, r |= l.subtreeFlags, r |= l.flags, l.return = e, l = l.sibling;
   return e.subtreeFlags |= r, e.childLanes = n, t
}

function Av(e, t, n) {
   var r = t.pendingProps;
   switch ($u(t), t.tag) {
      case 2:
      case 16:
      case 15:
      case 0:
      case 11:
      case 7:
      case 8:
      case 12:
      case 9:
      case 14:
         return fe(t), null;
      case 1:
         return Ce(t.type) && Yl(), fe(t), null;
      case 3:
         return r = t.stateNode, Kn(), W(Ee), W(pe), Xu(), r.pendingContext && (r.context = r.pendingContext, r.pendingContext = null), (e === null || e.child === null) && (wl(t) ? t.flags |= 4 : e === null || e.memoizedState.isDehydrated && !(t.flags & 256) || (t.flags |= 1024, Je !== null && (du(Je), Je = null))), lu(e, t), fe(t), null;
      case 5:
         Yu(t);
         var l = nn(Br.current);
         if (n = t.type, e !== null && t.stateNode != null) id(e, t, n, r, l), e.ref !== t.ref && (t.flags |= 512, t.flags |= 2097152);
         else {
            if (!r) {
               if (t.stateNode === null) throw Error(k(166));
               return fe(t), null
            }
            if (e = nn(at.current), wl(t)) {
               r = t.stateNode, n = t.type;
               var o = t.memoizedProps;
               switch (r[ut] = t, r[$r] = o, e = (t.mode & 1) !== 0, n) {
                  case "dialog":
                     V("cancel", r), V("close", r);
                     break;
                  case "iframe":
                  case "object":
                  case "embed":
                     V("load", r);
                     break;
                  case "video":
                  case "audio":
                     for (l = 0; l < vr.length; l++) V(vr[l], r);
                     break;
                  case "source":
                     V("error", r);
                     break;
                  case "img":
                  case "image":
                  case "link":
                     V("error", r), V("load", r);
                     break;
                  case "details":
                     V("toggle", r);
                     break;
                  case "input":
                     Us(r, o), V("invalid", r);
                     break;
                  case "select":
                     r._wrapperState = {
                        wasMultiple: !!o.multiple
                     }, V("invalid", r);
                     break;
                  case "textarea":
                     Vs(r, o), V("invalid", r)
               }
               Oi(n, o), l = null;
               for (var i in o)
                  if (o.hasOwnProperty(i)) {
                     var u = o[i];
                     i === "children" ? typeof u == "string" ? r.textContent !== u && (o.suppressHydrationWarning !== !0 && yl(r.textContent, u, e), l = ["children", u]) : typeof u == "number" && r.textContent !== "" + u && (o.suppressHydrationWarning !== !0 && yl(r.textContent, u, e), l = ["children", "" + u]) : Rr.hasOwnProperty(i) && u != null && i === "onScroll" && V("scroll", r)
                  } switch (n) {
                  case "input":
                     cl(r), Bs(r, o, !0);
                     break;
                  case "textarea":
                     cl(r), Ws(r);
                     break;
                  case "select":
                  case "option":
                     break;
                  default:
                     typeof o.onClick == "function" && (r.onclick = Kl)
               }
               r = l, t.updateQueue = r, r !== null && (t.flags |= 4)
            } else {
               i = l.nodeType === 9 ? l : l.ownerDocument, e === "http://www.w3.org/1999/xhtml" && (e = Mc(n)), e === "http://www.w3.org/1999/xhtml" ? n === "script" ? (e = i.createElement("div"), e.innerHTML = "<script><\/script>", e = e.removeChild(e.firstChild)) : typeof r.is == "string" ? e = i.createElement(n, {
                  is: r.is
               }) : (e = i.createElement(n), n === "select" && (i = e, r.multiple ? i.multiple = !0 : r.size && (i.size = r.size))) : e = i.createElementNS(e, n), e[ut] = t, e[$r] = r, od(e, t, !1, !1), t.stateNode = e;
               e: {
                  switch (i = zi(n, r), n) {
                     case "dialog":
                        V("cancel", e), V("close", e), l = r;
                        break;
                     case "iframe":
                     case "object":
                     case "embed":
                        V("load", e), l = r;
                        break;
                     case "video":
                     case "audio":
                        for (l = 0; l < vr.length; l++) V(vr[l], e);
                        l = r;
                        break;
                     case "source":
                        V("error", e), l = r;
                        break;
                     case "img":
                     case "image":
                     case "link":
                        V("error", e), V("load", e), l = r;
                        break;
                     case "details":
                        V("toggle", e), l = r;
                        break;
                     case "input":
                        Us(e, r), l = Di(e, r), V("invalid", e);
                        break;
                     case "option":
                        l = r;
                        break;
                     case "select":
                        e._wrapperState = {
                           wasMultiple: !!r.multiple
                        }, l = X({}, r, {
                           value: void 0
                        }), V("invalid", e);
                        break;
                     case "textarea":
                        Vs(e, r), l = Ri(e, r), V("invalid", e);
                        break;
                     default:
                        l = r
                  }
                  Oi(n, l),
                  u = l;
                  for (o in u)
                     if (u.hasOwnProperty(o)) {
                        var s = u[o];
                        o === "style" ? Fc(e, s) : o === "dangerouslySetInnerHTML" ? (s = s ? s.__html : void 0, s != null && jc(e, s)) : o === "children" ? typeof s == "string" ? (n !== "textarea" || s !== "") && Tr(e, s) : typeof s == "number" && Tr(e, "" + s) : o !== "suppressContentEditableWarning" && o !== "suppressHydrationWarning" && o !== "autoFocus" && (Rr.hasOwnProperty(o) ? s != null && o === "onScroll" && V("scroll", e) : s != null && Cu(e, o, s, i))
                     } switch (n) {
                     case "input":
                        cl(e), Bs(e, r, !1);
                        break;
                     case "textarea":
                        cl(e), Ws(e);
                        break;
                     case "option":
                        r.value != null && e.setAttribute("value", "" + Ht(r.value));
                        break;
                     case "select":
                        e.multiple = !!r.multiple, o = r.value, o != null ? Mn(e, !!r.multiple, o, !1) : r.defaultValue != null && Mn(e, !!r.multiple, r.defaultValue, !0);
                        break;
                     default:
                        typeof l.onClick == "function" && (e.onclick = Kl)
                  }
                  switch (n) {
                     case "button":
                     case "input":
                     case "select":
                     case "textarea":
                        r = !!r.autoFocus;
                        break e;
                     case "img":
                        r = !0;
                        break e;
                     default:
                        r = !1
                  }
               }
               r && (t.flags |= 4)
            }
            t.ref !== null && (t.flags |= 512, t.flags |= 2097152)
         }
         return fe(t), null;
      case 6:
         if (e && t.stateNode != null) ud(e, t, e.memoizedProps, r);
         else {
            if (typeof r != "string" && t.stateNode === null) throw Error(k(166));
            if (n = nn(Br.current), nn(at.current), wl(t)) {
               if (r = t.stateNode, n = t.memoizedProps, r[ut] = t, (o = r.nodeValue !== n) && (e = ze, e !== null)) switch (e.tag) {
                  case 3:
                     yl(r.nodeValue, n, (e.mode & 1) !== 0);
                     break;
                  case 5:
                     e.memoizedProps.suppressHydrationWarning !== !0 && yl(r.nodeValue, n, (e.mode & 1) !== 0)
               }
               o && (t.flags |= 4)
            } else r = (n.nodeType === 9 ? n : n.ownerDocument).createTextNode(r), r[ut] = t, t.stateNode = r
         }
         return fe(t), null;
      case 13:
         if (W(K), r = t.memoizedState, e === null || e.memoizedState !== null && e.memoizedState.dehydrated !== null) {
            if (Q && Oe !== null && t.mode & 1 && !(t.flags & 128)) Nf(), Hn(), t.flags |= 98560, o = !1;
            else if (o = wl(t), r !== null && r.dehydrated !== null) {
               if (e === null) {
                  if (!o) throw Error(k(318));
                  if (o = t.memoizedState, o = o !== null ? o.dehydrated : null, !o) throw Error(k(317));
                  o[ut] = t
               } else Hn(), !(t.flags & 128) && (t.memoizedState = null), t.flags |= 4;
               fe(t), o = !1
            } else Je !== null && (du(Je), Je = null), o = !0;
            if (!o) return t.flags & 65536 ? t : null
         }
         return t.flags & 128 ? (t.lanes = n, t) : (r = r !== null, r !== (e !== null && e.memoizedState !== null) && r && (t.child.flags |= 8192, t.mode & 1 && (e === null || K.current & 1 ? te === 0 && (te = 3) : is())), t.updateQueue !== null && (t.flags |= 4), fe(t), null);
      case 4:
         return Kn(), lu(e, t), e === null && Fr(t.stateNode.containerInfo), fe(t), null;
      case 10:
         return Wu(t.type._context), fe(t), null;
      case 17:
         return Ce(t.type) && Yl(), fe(t), null;
      case 19:
         if (W(K), o = t.memoizedState, o === null) return fe(t), null;
         if (r = (t.flags & 128) !== 0, i = o.rendering, i === null)
            if (r) cr(o, !1);
            else {
               if (te !== 0 || e !== null && e.flags & 128)
                  for (e = t.child; e !== null;) {
                     if (i = eo(e), i !== null) {
                        for (t.flags |= 128, cr(o, !1), r = i.updateQueue, r !== null && (t.updateQueue = r, t.flags |= 4), t.subtreeFlags = 0, r = n, n = t.child; n !== null;) o = n, e = r, o.flags &= 14680066, i = o.alternate, i === null ? (o.childLanes = 0, o.lanes = e, o.child = null, o.subtreeFlags = 0, o.memoizedProps = null, o.memoizedState = null, o.updateQueue = null, o.dependencies = null, o.stateNode = null) : (o.childLanes = i.childLanes, o.lanes = i.lanes, o.child = i.child, o.subtreeFlags = 0, o.deletions = null, o.memoizedProps = i.memoizedProps, o.memoizedState = i.memoizedState, o.updateQueue = i.updateQueue, o.type = i.type, e = i.dependencies, o.dependencies = e === null ? null : {
                           lanes: e.lanes,
                           firstContext: e.firstContext
                        }), n = n.sibling;
                        return B(K, K.current & 1 | 2), t.child
                     }
                     e = e.sibling
                  }
               o.tail !== null && Z() > Xn && (t.flags |= 128, r = !0, cr(o, !1), t.lanes = 4194304)
            }
         else {
            if (!r)
               if (e = eo(i), e !== null) {
                  if (t.flags |= 128, r = !0, n = e.updateQueue, n !== null && (t.updateQueue = n, t.flags |= 4), cr(o, !0), o.tail === null && o.tailMode === "hidden" && !i.alternate && !Q) return fe(t), null
               } else 2 * Z() - o.renderingStartTime > Xn && n !== 1073741824 && (t.flags |= 128, r = !0, cr(o, !1), t.lanes = 4194304);
            o.isBackwards ? (i.sibling = t.child, t.child = i) : (n = o.last, n !== null ? n.sibling = i : t.child = i, o.last = i)
         }
         return o.tail !== null ? (t = o.tail, o.rendering = t, o.tail = t.sibling, o.renderingStartTime = Z(), t.sibling = null, n = K.current, B(K, r ? n & 1 | 2 : n & 1), t) : (fe(t), null);
      case 22:
      case 23:
         return os(), r = t.memoizedState !== null, e !== null && e.memoizedState !== null !== r && (t.flags |= 8192), r && t.mode & 1 ? Te & 1073741824 && (fe(t), t.subtreeFlags & 6 && (t.flags |= 8192)) : fe(t), null;
      case 24:
         return null;
      case 25:
         return null
   }
   throw Error(k(156, t.tag))
}

function $v(e, t) {
   switch ($u(t), t.tag) {
      case 1:
         return Ce(t.type) && Yl(), e = t.flags, e & 65536 ? (t.flags = e & -65537 | 128, t) : null;
      case 3:
         return Kn(), W(Ee), W(pe), Xu(), e = t.flags, e & 65536 && !(e & 128) ? (t.flags = e & -65537 | 128, t) : null;
      case 5:
         return Yu(t), null;
      case 13:
         if (W(K), e = t.memoizedState, e !== null && e.dehydrated !== null) {
            if (t.alternate === null) throw Error(k(340));
            Hn()
         }
         return e = t.flags, e & 65536 ? (t.flags = e & -65537 | 128, t) : null;
      case 19:
         return W(K), null;
      case 4:
         return Kn(), null;
      case 10:
         return Wu(t.type._context), null;
      case 22:
      case 23:
         return os(), null;
      case 24:
         return null;
      default:
         return null
   }
}
var kl = !1,
   de = !1,
   Uv = typeof WeakSet == "function" ? WeakSet : Set,
   P = null;

function On(e, t) {
   var n = e.ref;
   if (n !== null)
      if (typeof n == "function") try {
         n(null)
      } catch (r) {
         G(e, t, r)
      } else n.current = null
}

function ou(e, t, n) {
   try {
      n()
   } catch (r) {
      G(e, t, r)
   }
}
var za = !1;

function Bv(e, t) {
   if (Vi = Wl, e = df(), Fu(e)) {
      if ("selectionStart" in e) var n = {
         start: e.selectionStart,
         end: e.selectionEnd
      };
      else e: {
         n = (n = e.ownerDocument) && n.defaultView || window;
         var r = n.getSelection && n.getSelection();
         if (r && r.rangeCount !== 0) {
            n = r.anchorNode;
            var l = r.anchorOffset,
               o = r.focusNode;
            r = r.focusOffset;
            try {
               n.nodeType, o.nodeType
            } catch {
               n = null;
               break e
            }
            var i = 0,
               u = -1,
               s = -1,
               a = 0,
               p = 0,
               d = e,
               v = null;
            t: for (;;) {
               for (var m; d !== n || l !== 0 && d.nodeType !== 3 || (u = i + l), d !== o || r !== 0 && d.nodeType !== 3 || (s = i + r), d.nodeType === 3 && (i += d.nodeValue.length), (m = d.firstChild) !== null;) v = d, d = m;
               for (;;) {
                  if (d === e) break t;
                  if (v === n && ++a === l && (u = i), v === o && ++p === r && (s = i), (m = d.nextSibling) !== null) break;
                  d = v, v = d.parentNode
               }
               d = m
            }
            n = u === -1 || s === -1 ? null : {
               start: u,
               end: s
            }
         } else n = null
      }
      n = n || {
         start: 0,
         end: 0
      }
   } else n = null;
   for (Wi = {
         focusedElem: e,
         selectionRange: n
      }, Wl = !1, P = t; P !== null;)
      if (t = P, e = t.child, (t.subtreeFlags & 1028) !== 0 && e !== null) e.return = t, P = e;
      else
         for (; P !== null;) {
            t = P;
            try {
               var w = t.alternate;
               if (t.flags & 1024) switch (t.tag) {
                  case 0:
                  case 11:
                  case 15:
                     break;
                  case 1:
                     if (w !== null) {
                        var y = w.memoizedProps,
                           D = w.memoizedState,
                           f = t.stateNode,
                           c = f.getSnapshotBeforeUpdate(t.elementType === t.type ? y : Ge(t.type, y), D);
                        f.__reactInternalSnapshotBeforeUpdate = c
                     }
                     break;
                  case 3:
                     var h = t.stateNode.containerInfo;
                     h.nodeType === 1 ? h.textContent = "" : h.nodeType === 9 && h.documentElement && h.removeChild(h.documentElement);
                     break;
                  case 5:
                  case 6:
                  case 4:
                  case 17:
                     break;
                  default:
                     throw Error(k(163))
               }
            } catch (S) {
               G(t, t.return, S)
            }
            if (e = t.sibling, e !== null) {
               e.return = t.return, P = e;
               break
            }
            P = t.return
         }
   return w = za, za = !1, w
}

function kr(e, t, n) {
   var r = t.updateQueue;
   if (r = r !== null ? r.lastEffect : null, r !== null) {
      var l = r = r.next;
      do {
         if ((l.tag & e) === e) {
            var o = l.destroy;
            l.destroy = void 0, o !== void 0 && ou(t, n, o)
         }
         l = l.next
      } while (l !== r)
   }
}

function Po(e, t) {
   if (t = t.updateQueue, t = t !== null ? t.lastEffect : null, t !== null) {
      var n = t = t.next;
      do {
         if ((n.tag & e) === e) {
            var r = n.create;
            n.destroy = r()
         }
         n = n.next
      } while (n !== t)
   }
}

function iu(e) {
   var t = e.ref;
   if (t !== null) {
      var n = e.stateNode;
      switch (e.tag) {
         case 5:
            e = n;
            break;
         default:
            e = n
      }
      typeof t == "function" ? t(e) : t.current = e
   }
}

function sd(e) {
   var t = e.alternate;
   t !== null && (e.alternate = null, sd(t)), e.child = null, e.deletions = null, e.sibling = null, e.tag === 5 && (t = e.stateNode, t !== null && (delete t[ut], delete t[$r], delete t[Ki], delete t[Ev], delete t[Cv])), e.stateNode = null, e.return = null, e.dependencies = null, e.memoizedProps = null, e.memoizedState = null, e.pendingProps = null, e.stateNode = null, e.updateQueue = null
}

function ad(e) {
   return e.tag === 5 || e.tag === 3 || e.tag === 4
}

function La(e) {
   e: for (;;) {
      for (; e.sibling === null;) {
         if (e.return === null || ad(e.return)) return null;
         e = e.return
      }
      for (e.sibling.return = e.return, e = e.sibling; e.tag !== 5 && e.tag !== 6 && e.tag !== 18;) {
         if (e.flags & 2 || e.child === null || e.tag === 4) continue e;
         e.child.return = e, e = e.child
      }
      if (!(e.flags & 2)) return e.stateNode
   }
}

function uu(e, t, n) {
   var r = e.tag;
   if (r === 5 || r === 6) e = e.stateNode, t ? n.nodeType === 8 ? n.parentNode.insertBefore(e, t) : n.insertBefore(e, t) : (n.nodeType === 8 ? (t = n.parentNode, t.insertBefore(e, n)) : (t = n, t.appendChild(e)), n = n._reactRootContainer, n != null || t.onclick !== null || (t.onclick = Kl));
   else if (r !== 4 && (e = e.child, e !== null))
      for (uu(e, t, n), e = e.sibling; e !== null;) uu(e, t, n), e = e.sibling
}

function su(e, t, n) {
   var r = e.tag;
   if (r === 5 || r === 6) e = e.stateNode, t ? n.insertBefore(e, t) : n.appendChild(e);
   else if (r !== 4 && (e = e.child, e !== null))
      for (su(e, t, n), e = e.sibling; e !== null;) su(e, t, n), e = e.sibling
}
var ie = null,
   Ze = !1;

function _t(e, t, n) {
   for (n = n.child; n !== null;) cd(e, t, n), n = n.sibling
}

function cd(e, t, n) {
   if (st && typeof st.onCommitFiberUnmount == "function") try {
      st.onCommitFiberUnmount(So, n)
   } catch {}
   switch (n.tag) {
      case 5:
         de || On(n, t);
      case 6:
         var r = ie,
            l = Ze;
         ie = null, _t(e, t, n), ie = r, Ze = l, ie !== null && (Ze ? (e = ie, n = n.stateNode, e.nodeType === 8 ? e.parentNode.removeChild(n) : e.removeChild(n)) : ie.removeChild(n.stateNode));
         break;
      case 18:
         ie !== null && (Ze ? (e = ie, n = n.stateNode, e.nodeType === 8 ? ui(e.parentNode, n) : e.nodeType === 1 && ui(e, n), Mr(e)) : ui(ie, n.stateNode));
         break;
      case 4:
         r = ie, l = Ze, ie = n.stateNode.containerInfo, Ze = !0, _t(e, t, n), ie = r, Ze = l;
         break;
      case 0:
      case 11:
      case 14:
      case 15:
         if (!de && (r = n.updateQueue, r !== null && (r = r.lastEffect, r !== null))) {
            l = r = r.next;
            do {
               var o = l,
                  i = o.destroy;
               o = o.tag, i !== void 0 && (o & 2 || o & 4) && ou(n, t, i), l = l.next
            } while (l !== r)
         }
         _t(e, t, n);
         break;
      case 1:
         if (!de && (On(n, t), r = n.stateNode, typeof r.componentWillUnmount == "function")) try {
            r.props = n.memoizedProps, r.state = n.memoizedState, r.componentWillUnmount()
         } catch (u) {
            G(n, t, u)
         }
         _t(e, t, n);
         break;
      case 21:
         _t(e, t, n);
         break;
      case 22:
         n.mode & 1 ? (de = (r = de) || n.memoizedState !== null, _t(e, t, n), de = r) : _t(e, t, n);
         break;
      default:
         _t(e, t, n)
   }
}

function Ma(e) {
   var t = e.updateQueue;
   if (t !== null) {
      e.updateQueue = null;
      var n = e.stateNode;
      n === null && (n = e.stateNode = new Uv), t.forEach(function (r) {
         var l = Zv.bind(null, e, r);
         n.has(r) || (n.add(r), r.then(l, l))
      })
   }
}

function Xe(e, t) {
   var n = t.deletions;
   if (n !== null)
      for (var r = 0; r < n.length; r++) {
         var l = n[r];
         try {
            var o = e,
               i = t,
               u = i;
            e: for (; u !== null;) {
               switch (u.tag) {
                  case 5:
                     ie = u.stateNode, Ze = !1;
                     break e;
                  case 3:
                     ie = u.stateNode.containerInfo, Ze = !0;
                     break e;
                  case 4:
                     ie = u.stateNode.containerInfo, Ze = !0;
                     break e
               }
               u = u.return
            }
            if (ie === null) throw Error(k(160));
            cd(o, i, l), ie = null, Ze = !1;
            var s = l.alternate;
            s !== null && (s.return = null), l.return = null
         } catch (a) {
            G(l, t, a)
         }
      }
   if (t.subtreeFlags & 12854)
      for (t = t.child; t !== null;) fd(t, e), t = t.sibling
}

function fd(e, t) {
   var n = e.alternate,
      r = e.flags;
   switch (e.tag) {
      case 0:
      case 11:
      case 14:
      case 15:
         if (Xe(t, e), ot(e), r & 4) {
            try {
               kr(3, e, e.return), Po(3, e)
            } catch (y) {
               G(e, e.return, y)
            }
            try {
               kr(5, e, e.return)
            } catch (y) {
               G(e, e.return, y)
            }
         }
         break;
      case 1:
         Xe(t, e), ot(e), r & 512 && n !== null && On(n, n.return);
         break;
      case 5:
         if (Xe(t, e), ot(e), r & 512 && n !== null && On(n, n.return), e.flags & 32) {
            var l = e.stateNode;
            try {
               Tr(l, "")
            } catch (y) {
               G(e, e.return, y)
            }
         }
         if (r & 4 && (l = e.stateNode, l != null)) {
            var o = e.memoizedProps,
               i = n !== null ? n.memoizedProps : o,
               u = e.type,
               s = e.updateQueue;
            if (e.updateQueue = null, s !== null) try {
               u === "input" && o.type === "radio" && o.name != null && zc(l, o), zi(u, i);
               var a = zi(u, o);
               for (i = 0; i < s.length; i += 2) {
                  var p = s[i],
                     d = s[i + 1];
                  p === "style" ? Fc(l, d) : p === "dangerouslySetInnerHTML" ? jc(l, d) : p === "children" ? Tr(l, d) : Cu(l, p, d, a)
               }
               switch (u) {
                  case "input":
                     _i(l, o);
                     break;
                  case "textarea":
                     Lc(l, o);
                     break;
                  case "select":
                     var v = l._wrapperState.wasMultiple;
                     l._wrapperState.wasMultiple = !!o.multiple;
                     var m = o.value;
                     m != null ? Mn(l, !!o.multiple, m, !1) : v !== !!o.multiple && (o.defaultValue != null ? Mn(l, !!o.multiple, o.defaultValue, !0) : Mn(l, !!o.multiple, o.multiple ? [] : "", !1))
               }
               l[$r] = o
            } catch (y) {
               G(e, e.return, y)
            }
         }
         break;
      case 6:
         if (Xe(t, e), ot(e), r & 4) {
            if (e.stateNode === null) throw Error(k(162));
            l = e.stateNode, o = e.memoizedProps;
            try {
               l.nodeValue = o
            } catch (y) {
               G(e, e.return, y)
            }
         }
         break;
      case 3:
         if (Xe(t, e), ot(e), r & 4 && n !== null && n.memoizedState.isDehydrated) try {
            Mr(t.containerInfo)
         } catch (y) {
            G(e, e.return, y)
         }
         break;
      case 4:
         Xe(t, e), ot(e);
         break;
      case 13:
         Xe(t, e), ot(e), l = e.child, l.flags & 8192 && (o = l.memoizedState !== null, l.stateNode.isHidden = o, !o || l.alternate !== null && l.alternate.memoizedState !== null || (rs = Z())), r & 4 && Ma(e);
         break;
      case 22:
         if (p = n !== null && n.memoizedState !== null, e.mode & 1 ? (de = (a = de) || p, Xe(t, e), de = a) : Xe(t, e), ot(e), r & 8192) {
            if (a = e.memoizedState !== null, (e.stateNode.isHidden = a) && !p && e.mode & 1)
               for (P = e, p = e.child; p !== null;) {
                  for (d = P = p; P !== null;) {
                     switch (v = P, m = v.child, v.tag) {
                        case 0:
                        case 11:
                        case 14:
                        case 15:
                           kr(4, v, v.return);
                           break;
                        case 1:
                           On(v, v.return);
                           var w = v.stateNode;
                           if (typeof w.componentWillUnmount == "function") {
                              r = v, n = v.return;
                              try {
                                 t = r, w.props = t.memoizedProps, w.state = t.memoizedState, w.componentWillUnmount()
                              } catch (y) {
                                 G(r, n, y)
                              }
                           }
                           break;
                        case 5:
                           On(v, v.return);
                           break;
                        case 22:
                           if (v.memoizedState !== null) {
                              Ia(d);
                              continue
                           }
                     }
                     m !== null ? (m.return = v, P = m) : Ia(d)
                  }
                  p = p.sibling
               }
            e: for (p = null, d = e;;) {
               if (d.tag === 5) {
                  if (p === null) {
                     p = d;
                     try {
                        l = d.stateNode, a ? (o = l.style, typeof o.setProperty == "function" ? o.setProperty("display", "none", "important") : o.display = "none") : (u = d.stateNode, s = d.memoizedProps.style, i = s != null && s.hasOwnProperty("display") ? s.display : null, u.style.display = Ic("display", i))
                     } catch (y) {
                        G(e, e.return, y)
                     }
                  }
               } else if (d.tag === 6) {
                  if (p === null) try {
                     d.stateNode.nodeValue = a ? "" : d.memoizedProps
                  } catch (y) {
                     G(e, e.return, y)
                  }
               } else if ((d.tag !== 22 && d.tag !== 23 || d.memoizedState === null || d === e) && d.child !== null) {
                  d.child.return = d, d = d.child;
                  continue
               }
               if (d === e) break e;
               for (; d.sibling === null;) {
                  if (d.return === null || d.return === e) break e;
                  p === d && (p = null), d = d.return
               }
               p === d && (p = null), d.sibling.return = d.return, d = d.sibling
            }
         }
         break;
      case 19:
         Xe(t, e), ot(e), r & 4 && Ma(e);
         break;
      case 21:
         break;
      default:
         Xe(t, e), ot(e)
   }
}

function ot(e) {
   var t = e.flags;
   if (t & 2) {
      try {
         e: {
            for (var n = e.return; n !== null;) {
               if (ad(n)) {
                  var r = n;
                  break e
               }
               n = n.return
            }
            throw Error(k(160))
         }
         switch (r.tag) {
            case 5:
               var l = r.stateNode;
               r.flags & 32 && (Tr(l, ""), r.flags &= -33);
               var o = La(e);
               su(e, o, l);
               break;
            case 3:
            case 4:
               var i = r.stateNode.containerInfo,
                  u = La(e);
               uu(e, u, i);
               break;
            default:
               throw Error(k(161))
         }
      }
      catch (s) {
         G(e, e.return, s)
      }
      e.flags &= -3
   }
   t & 4096 && (e.flags &= -4097)
}

function Vv(e, t, n) {
   P = e, dd(e)
}

function dd(e, t, n) {
   for (var r = (e.mode & 1) !== 0; P !== null;) {
      var l = P,
         o = l.child;
      if (l.tag === 22 && r) {
         var i = l.memoizedState !== null || kl;
         if (!i) {
            var u = l.alternate,
               s = u !== null && u.memoizedState !== null || de;
            u = kl;
            var a = de;
            if (kl = i, (de = s) && !a)
               for (P = l; P !== null;) i = P, s = i.child, i.tag === 22 && i.memoizedState !== null ? Fa(l) : s !== null ? (s.return = i, P = s) : Fa(l);
            for (; o !== null;) P = o, dd(o), o = o.sibling;
            P = l, kl = u, de = a
         }
         ja(e)
      } else l.subtreeFlags & 8772 && o !== null ? (o.return = l, P = o) : ja(e)
   }
}

function ja(e) {
   for (; P !== null;) {
      var t = P;
      if (t.flags & 8772) {
         var n = t.alternate;
         try {
            if (t.flags & 8772) switch (t.tag) {
               case 0:
               case 11:
               case 15:
                  de || Po(5, t);
                  break;
               case 1:
                  var r = t.stateNode;
                  if (t.flags & 4 && !de)
                     if (n === null) r.componentDidMount();
                     else {
                        var l = t.elementType === t.type ? n.memoizedProps : Ge(t.type, n.memoizedProps);
                        r.componentDidUpdate(l, n.memoizedState, r.__reactInternalSnapshotBeforeUpdate)
                     } var o = t.updateQueue;
                  o !== null && wa(t, o, r);
                  break;
               case 3:
                  var i = t.updateQueue;
                  if (i !== null) {
                     if (n = null, t.child !== null) switch (t.child.tag) {
                        case 5:
                           n = t.child.stateNode;
                           break;
                        case 1:
                           n = t.child.stateNode
                     }
                     wa(t, i, n)
                  }
                  break;
               case 5:
                  var u = t.stateNode;
                  if (n === null && t.flags & 4) {
                     n = u;
                     var s = t.memoizedProps;
                     switch (t.type) {
                        case "button":
                        case "input":
                        case "select":
                        case "textarea":
                           s.autoFocus && n.focus();
                           break;
                        case "img":
                           s.src && (n.src = s.src)
                     }
                  }
                  break;
               case 6:
                  break;
               case 4:
                  break;
               case 12:
                  break;
               case 13:
                  if (t.memoizedState === null) {
                     var a = t.alternate;
                     if (a !== null) {
                        var p = a.memoizedState;
                        if (p !== null) {
                           var d = p.dehydrated;
                           d !== null && Mr(d)
                        }
                     }
                  }
                  break;
               case 19:
               case 17:
               case 21:
               case 22:
               case 23:
               case 25:
                  break;
               default:
                  throw Error(k(163))
            }
            de || t.flags & 512 && iu(t)
         } catch (v) {
            G(t, t.return, v)
         }
      }
      if (t === e) {
         P = null;
         break
      }
      if (n = t.sibling, n !== null) {
         n.return = t.return, P = n;
         break
      }
      P = t.return
   }
}

function Ia(e) {
   for (; P !== null;) {
      var t = P;
      if (t === e) {
         P = null;
         break
      }
      var n = t.sibling;
      if (n !== null) {
         n.return = t.return, P = n;
         break
      }
      P = t.return
   }
}

function Fa(e) {
   for (; P !== null;) {
      var t = P;
      try {
         switch (t.tag) {
            case 0:
            case 11:
            case 15:
               var n = t.return;
               try {
                  Po(4, t)
               } catch (s) {
                  G(t, n, s)
               }
               break;
            case 1:
               var r = t.stateNode;
               if (typeof r.componentDidMount == "function") {
                  var l = t.return;
                  try {
                     r.componentDidMount()
                  } catch (s) {
                     G(t, l, s)
                  }
               }
               var o = t.return;
               try {
                  iu(t)
               } catch (s) {
                  G(t, o, s)
               }
               break;
            case 5:
               var i = t.return;
               try {
                  iu(t)
               } catch (s) {
                  G(t, i, s)
               }
         }
      } catch (s) {
         G(t, t.return, s)
      }
      if (t === e) {
         P = null;
         break
      }
      var u = t.sibling;
      if (u !== null) {
         u.return = t.return, P = u;
         break
      }
      P = t.return
   }
}
var Wv = Math.ceil,
   ro = xt.ReactCurrentDispatcher,
   ts = xt.ReactCurrentOwner,
   Ve = xt.ReactCurrentBatchConfig,
   j = 0,
   le = null,
   J = null,
   ue = 0,
   Te = 0,
   zn = Yt(0),
   te = 0,
   Qr = null,
   an = 0,
   Ro = 0,
   ns = 0,
   Er = null,
   xe = null,
   rs = 0,
   Xn = 1 / 0,
   ft = null,
   lo = !1,
   au = null,
   Bt = null,
   El = !1,
   Mt = null,
   oo = 0,
   Cr = 0,
   cu = null,
   Ml = -1,
   jl = 0;

function ge() {
   return j & 6 ? Z() : Ml !== -1 ? Ml : Ml = Z()
}

function Vt(e) {
   return e.mode & 1 ? j & 2 && ue !== 0 ? ue & -ue : Dv.transition !== null ? (jl === 0 && (jl = Gc()), jl) : (e = A, e !== 0 || (e = window.event, e = e === void 0 ? 16 : nf(e.type)), e) : 1
}

function be(e, t, n, r) {
   if (50 < Cr) throw Cr = 0, cu = null, Error(k(185));
   Zr(e, n, r), (!(j & 2) || e !== le) && (e === le && (!(j & 2) && (Ro |= n), te === 4 && zt(e, ue)), Ne(e, r), n === 1 && j === 0 && !(t.mode & 1) && (Xn = Z() + 500, No && Xt()))
}

function Ne(e, t) {
   var n = e.callbackNode;
   Dh(e, t);
   var r = Vl(e, e === le ? ue : 0);
   if (r === 0) n !== null && Ks(n), e.callbackNode = null, e.callbackPriority = 0;
   else if (t = r & -r, e.callbackPriority !== t) {
      if (n != null && Ks(n), t === 1) e.tag === 0 ? Nv(Aa.bind(null, e)) : kf(Aa.bind(null, e)), xv(function () {
         !(j & 6) && Xt()
      }), n = null;
      else {
         switch (Zc(r)) {
            case 1:
               n = Ru;
               break;
            case 4:
               n = Yc;
               break;
            case 16:
               n = Bl;
               break;
            case 536870912:
               n = Xc;
               break;
            default:
               n = Bl
         }
         n = Sd(n, pd.bind(null, e))
      }
      e.callbackPriority = t, e.callbackNode = n
   }
}

function pd(e, t) {
   if (Ml = -1, jl = 0, j & 6) throw Error(k(327));
   var n = e.callbackNode;
   if ($n() && e.callbackNode !== n) return null;
   var r = Vl(e, e === le ? ue : 0);
   if (r === 0) return null;
   if (r & 30 || r & e.expiredLanes || t) t = io(e, r);
   else {
      t = r;
      var l = j;
      j |= 2;
      var o = vd();
      (le !== e || ue !== t) && (ft = null, Xn = Z() + 500, rn(e, t));
      do try {
         Kv();
         break
      } catch (u) {
         hd(e, u)
      }
      while (!0);
      Vu(), ro.current = o, j = l, J !== null ? t = 0 : (le = null, ue = 0, t = te)
   }
   if (t !== 0) {
      if (t === 2 && (l = Fi(e), l !== 0 && (r = l, t = fu(e, l))), t === 1) throw n = Qr, rn(e, 0), zt(e, r), Ne(e, Z()), n;
      if (t === 6) zt(e, r);
      else {
         if (l = e.current.alternate, !(r & 30) && !Hv(l) && (t = io(e, r), t === 2 && (o = Fi(e), o !== 0 && (r = o, t = fu(e, o))), t === 1)) throw n = Qr, rn(e, 0), zt(e, r), Ne(e, Z()), n;
         switch (e.finishedWork = l, e.finishedLanes = r, t) {
            case 0:
            case 1:
               throw Error(k(345));
            case 2:
               bt(e, xe, ft);
               break;
            case 3:
               if (zt(e, r), (r & 130023424) === r && (t = rs + 500 - Z(), 10 < t)) {
                  if (Vl(e, 0) !== 0) break;
                  if (l = e.suspendedLanes, (l & r) !== r) {
                     ge(), e.pingedLanes |= e.suspendedLanes & l;
                     break
                  }
                  e.timeoutHandle = Qi(bt.bind(null, e, xe, ft), t);
                  break
               }
               bt(e, xe, ft);
               break;
            case 4:
               if (zt(e, r), (r & 4194240) === r) break;
               for (t = e.eventTimes, l = -1; 0 < r;) {
                  var i = 31 - qe(r);
                  o = 1 << i, i = t[i], i > l && (l = i), r &= ~o
               }
               if (r = l, r = Z() - r, r = (120 > r ? 120 : 480 > r ? 480 : 1080 > r ? 1080 : 1920 > r ? 1920 : 3e3 > r ? 3e3 : 4320 > r ? 4320 : 1960 * Wv(r / 1960)) - r, 10 < r) {
                  e.timeoutHandle = Qi(bt.bind(null, e, xe, ft), r);
                  break
               }
               bt(e, xe, ft);
               break;
            case 5:
               bt(e, xe, ft);
               break;
            default:
               throw Error(k(329))
         }
      }
   }
   return Ne(e, Z()), e.callbackNode === n ? pd.bind(null, e) : null
}

function fu(e, t) {
   var n = Er;
   return e.current.memoizedState.isDehydrated && (rn(e, t).flags |= 256), e = io(e, t), e !== 2 && (t = xe, xe = n, t !== null && du(t)), e
}

function du(e) {
   xe === null ? xe = e : xe.push.apply(xe, e)
}

function Hv(e) {
   for (var t = e;;) {
      if (t.flags & 16384) {
         var n = t.updateQueue;
         if (n !== null && (n = n.stores, n !== null))
            for (var r = 0; r < n.length; r++) {
               var l = n[r],
                  o = l.getSnapshot;
               l = l.value;
               try {
                  if (!et(o(), l)) return !1
               } catch {
                  return !1
               }
            }
      }
      if (n = t.child, t.subtreeFlags & 16384 && n !== null) n.return = t, t = n;
      else {
         if (t === e) break;
         for (; t.sibling === null;) {
            if (t.return === null || t.return === e) return !0;
            t = t.return
         }
         t.sibling.return = t.return, t = t.sibling
      }
   }
   return !0
}

function zt(e, t) {
   for (t &= ~ns, t &= ~Ro, e.suspendedLanes |= t, e.pingedLanes &= ~t, e = e.expirationTimes; 0 < t;) {
      var n = 31 - qe(t),
         r = 1 << n;
      e[n] = -1, t &= ~r
   }
}

function Aa(e) {
   if (j & 6) throw Error(k(327));
   $n();
   var t = Vl(e, 0);
   if (!(t & 1)) return Ne(e, Z()), null;
   var n = io(e, t);
   if (e.tag !== 0 && n === 2) {
      var r = Fi(e);
      r !== 0 && (t = r, n = fu(e, r))
   }
   if (n === 1) throw n = Qr, rn(e, 0), zt(e, t), Ne(e, Z()), n;
   if (n === 6) throw Error(k(345));
   return e.finishedWork = e.current.alternate, e.finishedLanes = t, bt(e, xe, ft), Ne(e, Z()), null
}

function ls(e, t) {
   var n = j;
   j |= 1;
   try {
      return e(t)
   } finally {
      j = n, j === 0 && (Xn = Z() + 500, No && Xt())
   }
}

function cn(e) {
   Mt !== null && Mt.tag === 0 && !(j & 6) && $n();
   var t = j;
   j |= 1;
   var n = Ve.transition,
      r = A;
   try {
      if (Ve.transition = null, A = 1, e) return e()
   } finally {
      A = r, Ve.transition = n, j = t, !(j & 6) && Xt()
   }
}

function os() {
   Te = zn.current, W(zn)
}

function rn(e, t) {
   e.finishedWork = null, e.finishedLanes = 0;
   var n = e.timeoutHandle;
   if (n !== -1 && (e.timeoutHandle = -1, Sv(n)), J !== null)
      for (n = J.return; n !== null;) {
         var r = n;
         switch ($u(r), r.tag) {
            case 1:
               r = r.type.childContextTypes, r != null && Yl();
               break;
            case 3:
               Kn(), W(Ee), W(pe), Xu();
               break;
            case 5:
               Yu(r);
               break;
            case 4:
               Kn();
               break;
            case 13:
               W(K);
               break;
            case 19:
               W(K);
               break;
            case 10:
               Wu(r.type._context);
               break;
            case 22:
            case 23:
               os()
         }
         n = n.return
      }
   if (le = e, J = e = Wt(e.current, null), ue = Te = t, te = 0, Qr = null, ns = Ro = an = 0, xe = Er = null, tn !== null) {
      for (t = 0; t < tn.length; t++)
         if (n = tn[t], r = n.interleaved, r !== null) {
            n.interleaved = null;
            var l = r.next,
               o = n.pending;
            if (o !== null) {
               var i = o.next;
               o.next = l, r.next = i
            }
            n.pending = r
         } tn = null
   }
   return e
}

function hd(e, t) {
   do {
      var n = J;
      try {
         if (Vu(), Ol.current = no, to) {
            for (var r = Y.memoizedState; r !== null;) {
               var l = r.queue;
               l !== null && (l.pending = null), r = r.next
            }
            to = !1
         }
         if (sn = 0, ne = b = Y = null, xr = !1, Vr = 0, ts.current = null, n === null || n.return === null) {
            te = 1, Qr = t, J = null;
            break
         }
         e: {
            var o = e,
               i = n.return,
               u = n,
               s = t;
            if (t = ue, u.flags |= 32768, s !== null && typeof s == "object" && typeof s.then == "function") {
               var a = s,
                  p = u,
                  d = p.tag;
               if (!(p.mode & 1) && (d === 0 || d === 11 || d === 15)) {
                  var v = p.alternate;
                  v ? (p.updateQueue = v.updateQueue, p.memoizedState = v.memoizedState, p.lanes = v.lanes) : (p.updateQueue = null, p.memoizedState = null)
               }
               var m = Na(i);
               if (m !== null) {
                  m.flags &= -257, Da(m, i, u, o, t), m.mode & 1 && Ca(o, a, t), t = m, s = a;
                  var w = t.updateQueue;
                  if (w === null) {
                     var y = new Set;
                     y.add(s), t.updateQueue = y
                  } else w.add(s);
                  break e
               } else {
                  if (!(t & 1)) {
                     Ca(o, a, t), is();
                     break e
                  }
                  s = Error(k(426))
               }
            } else if (Q && u.mode & 1) {
               var D = Na(i);
               if (D !== null) {
                  !(D.flags & 65536) && (D.flags |= 256), Da(D, i, u, o, t), Uu(Yn(s, u));
                  break e
               }
            }
            o = s = Yn(s, u),
            te !== 4 && (te = 2),
            Er === null ? Er = [o] : Er.push(o),
            o = i;do {
               switch (o.tag) {
                  case 3:
                     o.flags |= 65536, t &= -t, o.lanes |= t;
                     var f = Jf(o, s, t);
                     ya(o, f);
                     break e;
                  case 1:
                     u = s;
                     var c = o.type,
                        h = o.stateNode;
                     if (!(o.flags & 128) && (typeof c.getDerivedStateFromError == "function" || h !== null && typeof h.componentDidCatch == "function" && (Bt === null || !Bt.has(h)))) {
                        o.flags |= 65536, t &= -t, o.lanes |= t;
                        var S = qf(o, u, t);
                        ya(o, S);
                        break e
                     }
               }
               o = o.return
            } while (o !== null)
         }
         gd(n)
      } catch (x) {
         t = x, J === n && n !== null && (J = n = n.return);
         continue
      }
      break
   } while (!0)
}

function vd() {
   var e = ro.current;
   return ro.current = no, e === null ? no : e
}

function is() {
   (te === 0 || te === 3 || te === 2) && (te = 4), le === null || !(an & 268435455) && !(Ro & 268435455) || zt(le, ue)
}

function io(e, t) {
   var n = j;
   j |= 2;
   var r = vd();
   (le !== e || ue !== t) && (ft = null, rn(e, t));
   do try {
      Qv();
      break
   } catch (l) {
      hd(e, l)
   }
   while (!0);
   if (Vu(), j = n, ro.current = r, J !== null) throw Error(k(261));
   return le = null, ue = 0, te
}

function Qv() {
   for (; J !== null;) md(J)
}

function Kv() {
   for (; J !== null && !gh();) md(J)
}

function md(e) {
   var t = wd(e.alternate, e, Te);
   e.memoizedProps = e.pendingProps, t === null ? gd(e) : J = t, ts.current = null
}

function gd(e) {
   var t = e;
   do {
      var n = t.alternate;
      if (e = t.return, t.flags & 32768) {
         if (n = $v(n, t), n !== null) {
            n.flags &= 32767, J = n;
            return
         }
         if (e !== null) e.flags |= 32768, e.subtreeFlags = 0, e.deletions = null;
         else {
            te = 6, J = null;
            return
         }
      } else if (n = Av(n, t, Te), n !== null) {
         J = n;
         return
      }
      if (t = t.sibling, t !== null) {
         J = t;
         return
      }
      J = t = e
   } while (t !== null);
   te === 0 && (te = 5)
}

function bt(e, t, n) {
   var r = A,
      l = Ve.transition;
   try {
      Ve.transition = null, A = 1, Yv(e, t, n, r)
   } finally {
      Ve.transition = l, A = r
   }
   return null
}

function Yv(e, t, n, r) {
   do $n(); while (Mt !== null);
   if (j & 6) throw Error(k(327));
   n = e.finishedWork;
   var l = e.finishedLanes;
   if (n === null) return null;
   if (e.finishedWork = null, e.finishedLanes = 0, n === e.current) throw Error(k(177));
   e.callbackNode = null, e.callbackPriority = 0;
   var o = n.lanes | n.childLanes;
   if (_h(e, o), e === le && (J = le = null, ue = 0), !(n.subtreeFlags & 2064) && !(n.flags & 2064) || El || (El = !0, Sd(Bl, function () {
         return $n(), null
      })), o = (n.flags & 15990) !== 0, n.subtreeFlags & 15990 || o) {
      o = Ve.transition, Ve.transition = null;
      var i = A;
      A = 1;
      var u = j;
      j |= 4, ts.current = null, Bv(e, n), fd(n, e), pv(Wi), Wl = !!Vi, Wi = Vi = null, e.current = n, Vv(n), yh(), j = u, A = i, Ve.transition = o
   } else e.current = n;
   if (El && (El = !1, Mt = e, oo = l), o = e.pendingLanes, o === 0 && (Bt = null), xh(n.stateNode), Ne(e, Z()), t !== null)
      for (r = e.onRecoverableError, n = 0; n < t.length; n++) l = t[n], r(l.value, {
         componentStack: l.stack,
         digest: l.digest
      });
   if (lo) throw lo = !1, e = au, au = null, e;
   return oo & 1 && e.tag !== 0 && $n(), o = e.pendingLanes, o & 1 ? e === cu ? Cr++ : (Cr = 0, cu = e) : Cr = 0, Xt(), null
}

function $n() {
   if (Mt !== null) {
      var e = Zc(oo),
         t = Ve.transition,
         n = A;
      try {
         if (Ve.transition = null, A = 16 > e ? 16 : e, Mt === null) var r = !1;
         else {
            if (e = Mt, Mt = null, oo = 0, j & 6) throw Error(k(331));
            var l = j;
            for (j |= 4, P = e.current; P !== null;) {
               var o = P,
                  i = o.child;
               if (P.flags & 16) {
                  var u = o.deletions;
                  if (u !== null) {
                     for (var s = 0; s < u.length; s++) {
                        var a = u[s];
                        for (P = a; P !== null;) {
                           var p = P;
                           switch (p.tag) {
                              case 0:
                              case 11:
                              case 15:
                                 kr(8, p, o)
                           }
                           var d = p.child;
                           if (d !== null) d.return = p, P = d;
                           else
                              for (; P !== null;) {
                                 p = P;
                                 var v = p.sibling,
                                    m = p.return;
                                 if (sd(p), p === a) {
                                    P = null;
                                    break
                                 }
                                 if (v !== null) {
                                    v.return = m, P = v;
                                    break
                                 }
                                 P = m
                              }
                        }
                     }
                     var w = o.alternate;
                     if (w !== null) {
                        var y = w.child;
                        if (y !== null) {
                           w.child = null;
                           do {
                              var D = y.sibling;
                              y.sibling = null, y = D
                           } while (y !== null)
                        }
                     }
                     P = o
                  }
               }
               if (o.subtreeFlags & 2064 && i !== null) i.return = o, P = i;
               else e: for (; P !== null;) {
                  if (o = P, o.flags & 2048) switch (o.tag) {
                     case 0:
                     case 11:
                     case 15:
                        kr(9, o, o.return)
                  }
                  var f = o.sibling;
                  if (f !== null) {
                     f.return = o.return, P = f;
                     break e
                  }
                  P = o.return
               }
            }
            var c = e.current;
            for (P = c; P !== null;) {
               i = P;
               var h = i.child;
               if (i.subtreeFlags & 2064 && h !== null) h.return = i, P = h;
               else e: for (i = c; P !== null;) {
                  if (u = P, u.flags & 2048) try {
                     switch (u.tag) {
                        case 0:
                        case 11:
                        case 15:
                           Po(9, u)
                     }
                  } catch (x) {
                     G(u, u.return, x)
                  }
                  if (u === i) {
                     P = null;
                     break e
                  }
                  var S = u.sibling;
                  if (S !== null) {
                     S.return = u.return, P = S;
                     break e
                  }
                  P = u.return
               }
            }
            if (j = l, Xt(), st && typeof st.onPostCommitFiberRoot == "function") try {
               st.onPostCommitFiberRoot(So, e)
            } catch {}
            r = !0
         }
         return r
      } finally {
         A = n, Ve.transition = t
      }
   }
   return !1
}

function $a(e, t, n) {
   t = Yn(n, t), t = Jf(e, t, 1), e = Ut(e, t, 1), t = ge(), e !== null && (Zr(e, 1, t), Ne(e, t))
}

function G(e, t, n) {
   if (e.tag === 3) $a(e, e, n);
   else
      for (; t !== null;) {
         if (t.tag === 3) {
            $a(t, e, n);
            break
         } else if (t.tag === 1) {
            var r = t.stateNode;
            if (typeof t.type.getDerivedStateFromError == "function" || typeof r.componentDidCatch == "function" && (Bt === null || !Bt.has(r))) {
               e = Yn(n, e), e = qf(t, e, 1), t = Ut(t, e, 1), e = ge(), t !== null && (Zr(t, 1, e), Ne(t, e));
               break
            }
         }
         t = t.return
      }
}

function Xv(e, t, n) {
   var r = e.pingCache;
   r !== null && r.delete(t), t = ge(), e.pingedLanes |= e.suspendedLanes & n, le === e && (ue & n) === n && (te === 4 || te === 3 && (ue & 130023424) === ue && 500 > Z() - rs ? rn(e, 0) : ns |= n), Ne(e, t)
}

function yd(e, t) {
   t === 0 && (e.mode & 1 ? (t = pl, pl <<= 1, !(pl & 130023424) && (pl = 4194304)) : t = 1);
   var n = ge();
   e = yt(e, t), e !== null && (Zr(e, t, n), Ne(e, n))
}

function Gv(e) {
   var t = e.memoizedState,
      n = 0;
   t !== null && (n = t.retryLane), yd(e, n)
}

function Zv(e, t) {
   var n = 0;
   switch (e.tag) {
      case 13:
         var r = e.stateNode,
            l = e.memoizedState;
         l !== null && (n = l.retryLane);
         break;
      case 19:
         r = e.stateNode;
         break;
      default:
         throw Error(k(314))
   }
   r !== null && r.delete(t), yd(e, n)
}
var wd;
wd = function (e, t, n) {
   if (e !== null)
      if (e.memoizedProps !== t.pendingProps || Ee.current) ke = !0;
      else {
         if (!(e.lanes & n) && !(t.flags & 128)) return ke = !1, Fv(e, t, n);
         ke = !!(e.flags & 131072)
      }
   else ke = !1, Q && t.flags & 1048576 && Ef(t, Zl, t.index);
   switch (t.lanes = 0, t.tag) {
      case 2:
         var r = t.type;
         Ll(e, t), e = t.pendingProps;
         var l = Wn(t, pe.current);
         An(t, n), l = Zu(null, t, r, e, l, n);
         var o = Ju();
         return t.flags |= 1, typeof l == "object" && l !== null && typeof l.render == "function" && l.$$typeof === void 0 ? (t.tag = 1, t.memoizedState = null, t.updateQueue = null, Ce(r) ? (o = !0, Xl(t)) : o = !1, t.memoizedState = l.state !== null && l.state !== void 0 ? l.state : null, Qu(t), l.updater = _o, t.stateNode = l, l._reactInternals = t, qi(t, r, e, n), t = tu(null, t, r, !0, o, n)) : (t.tag = 0, Q && o && Au(t), me(null, t, l, n), t = t.child), t;
      case 16:
         r = t.elementType;
         e: {
            switch (Ll(e, t), e = t.pendingProps, l = r._init, r = l(r._payload), t.type = r, l = t.tag = qv(r), e = Ge(r, e), l) {
               case 0:
                  t = eu(null, t, r, e, n);
                  break e;
               case 1:
                  t = Ra(null, t, r, e, n);
                  break e;
               case 11:
                  t = _a(null, t, r, e, n);
                  break e;
               case 14:
                  t = Pa(null, t, r, Ge(r.type, e), n);
                  break e
            }
            throw Error(k(306, r, ""))
         }
         return t;
      case 0:
         return r = t.type, l = t.pendingProps, l = t.elementType === r ? l : Ge(r, l), eu(e, t, r, l, n);
      case 1:
         return r = t.type, l = t.pendingProps, l = t.elementType === r ? l : Ge(r, l), Ra(e, t, r, l, n);
      case 3:
         e: {
            if (nd(t), e === null) throw Error(k(387));r = t.pendingProps,
            o = t.memoizedState,
            l = o.element,
            Rf(e, t),
            bl(t, r, null, n);
            var i = t.memoizedState;
            if (r = i.element, o.isDehydrated)
               if (o = {
                     element: r,
                     isDehydrated: !1,
                     cache: i.cache,
                     pendingSuspenseBoundaries: i.pendingSuspenseBoundaries,
                     transitions: i.transitions
                  }, t.updateQueue.baseState = o, t.memoizedState = o, t.flags & 256) {
                  l = Yn(Error(k(423)), t), t = Ta(e, t, r, n, l);
                  break e
               } else if (r !== l) {
               l = Yn(Error(k(424)), t), t = Ta(e, t, r, n, l);
               break e
            } else
               for (Oe = $t(t.stateNode.containerInfo.firstChild), ze = t, Q = !0, Je = null, n = _f(t, null, r, n), t.child = n; n;) n.flags = n.flags & -3 | 4096, n = n.sibling;
            else {
               if (Hn(), r === l) {
                  t = wt(e, t, n);
                  break e
               }
               me(e, t, r, n)
            }
            t = t.child
         }
         return t;
      case 5:
         return Tf(t), e === null && Gi(t), r = t.type, l = t.pendingProps, o = e !== null ? e.memoizedProps : null, i = l.children, Hi(r, l) ? i = null : o !== null && Hi(r, o) && (t.flags |= 32), td(e, t), me(e, t, i, n), t.child;
      case 6:
         return e === null && Gi(t), null;
      case 13:
         return rd(e, t, n);
      case 4:
         return Ku(t, t.stateNode.containerInfo), r = t.pendingProps, e === null ? t.child = Qn(t, null, r, n) : me(e, t, r, n), t.child;
      case 11:
         return r = t.type, l = t.pendingProps, l = t.elementType === r ? l : Ge(r, l), _a(e, t, r, l, n);
      case 7:
         return me(e, t, t.pendingProps, n), t.child;
      case 8:
         return me(e, t, t.pendingProps.children, n), t.child;
      case 12:
         return me(e, t, t.pendingProps.children, n), t.child;
      case 10:
         e: {
            if (r = t.type._context, l = t.pendingProps, o = t.memoizedProps, i = l.value, B(Jl, r._currentValue), r._currentValue = i, o !== null)
               if (et(o.value, i)) {
                  if (o.children === l.children && !Ee.current) {
                     t = wt(e, t, n);
                     break e
                  }
               } else
                  for (o = t.child, o !== null && (o.return = t); o !== null;) {
                     var u = o.dependencies;
                     if (u !== null) {
                        i = o.child;
                        for (var s = u.firstContext; s !== null;) {
                           if (s.context === r) {
                              if (o.tag === 1) {
                                 s = vt(-1, n & -n), s.tag = 2;
                                 var a = o.updateQueue;
                                 if (a !== null) {
                                    a = a.shared;
                                    var p = a.pending;
                                    p === null ? s.next = s : (s.next = p.next, p.next = s), a.pending = s
                                 }
                              }
                              o.lanes |= n, s = o.alternate, s !== null && (s.lanes |= n), Zi(o.return, n, t), u.lanes |= n;
                              break
                           }
                           s = s.next
                        }
                     } else if (o.tag === 10) i = o.type === t.type ? null : o.child;
                     else if (o.tag === 18) {
                        if (i = o.return, i === null) throw Error(k(341));
                        i.lanes |= n, u = i.alternate, u !== null && (u.lanes |= n), Zi(i, n, t), i = o.sibling
                     } else i = o.child;
                     if (i !== null) i.return = o;
                     else
                        for (i = o; i !== null;) {
                           if (i === t) {
                              i = null;
                              break
                           }
                           if (o = i.sibling, o !== null) {
                              o.return = i.return, i = o;
                              break
                           }
                           i = i.return
                        }
                     o = i
                  }
            me(e, t, l.children, n),
            t = t.child
         }
         return t;
      case 9:
         return l = t.type, r = t.pendingProps.children, An(t, n), l = We(l), r = r(l), t.flags |= 1, me(e, t, r, n), t.child;
      case 14:
         return r = t.type, l = Ge(r, t.pendingProps), l = Ge(r.type, l), Pa(e, t, r, l, n);
      case 15:
         return bf(e, t, t.type, t.pendingProps, n);
      case 17:
         return r = t.type, l = t.pendingProps, l = t.elementType === r ? l : Ge(r, l), Ll(e, t), t.tag = 1, Ce(r) ? (e = !0, Xl(t)) : e = !1, An(t, n), Zf(t, r, l), qi(t, r, l, n), tu(null, t, r, !0, e, n);
      case 19:
         return ld(e, t, n);
      case 22:
         return ed(e, t, n)
   }
   throw Error(k(156, t.tag))
};

function Sd(e, t) {
   return Kc(e, t)
}

function Jv(e, t, n, r) {
   this.tag = e, this.key = n, this.sibling = this.child = this.return = this.stateNode = this.type = this.elementType = null, this.index = 0, this.ref = null, this.pendingProps = t, this.dependencies = this.memoizedState = this.updateQueue = this.memoizedProps = null, this.mode = r, this.subtreeFlags = this.flags = 0, this.deletions = null, this.childLanes = this.lanes = 0, this.alternate = null
}

function Be(e, t, n, r) {
   return new Jv(e, t, n, r)
}

function us(e) {
   return e = e.prototype, !(!e || !e.isReactComponent)
}

function qv(e) {
   if (typeof e == "function") return us(e) ? 1 : 0;
   if (e != null) {
      if (e = e.$$typeof, e === Du) return 11;
      if (e === _u) return 14
   }
   return 2
}

function Wt(e, t) {
   var n = e.alternate;
   return n === null ? (n = Be(e.tag, t, e.key, e.mode), n.elementType = e.elementType, n.type = e.type, n.stateNode = e.stateNode, n.alternate = e, e.alternate = n) : (n.pendingProps = t, n.type = e.type, n.flags = 0, n.subtreeFlags = 0, n.deletions = null), n.flags = e.flags & 14680064, n.childLanes = e.childLanes, n.lanes = e.lanes, n.child = e.child, n.memoizedProps = e.memoizedProps, n.memoizedState = e.memoizedState, n.updateQueue = e.updateQueue, t = e.dependencies, n.dependencies = t === null ? null : {
      lanes: t.lanes,
      firstContext: t.firstContext
   }, n.sibling = e.sibling, n.index = e.index, n.ref = e.ref, n
}

function Il(e, t, n, r, l, o) {
   var i = 2;
   if (r = e, typeof e == "function") us(e) && (i = 1);
   else if (typeof e == "string") i = 5;
   else e: switch (e) {
      case kn:
         return ln(n.children, l, o, t);
      case Nu:
         i = 8, l |= 8;
         break;
      case ki:
         return e = Be(12, n, t, l | 2), e.elementType = ki, e.lanes = o, e;
      case Ei:
         return e = Be(13, n, t, l), e.elementType = Ei, e.lanes = o, e;
      case Ci:
         return e = Be(19, n, t, l), e.elementType = Ci, e.lanes = o, e;
      case Rc:
         return To(n, l, o, t);
      default:
         if (typeof e == "object" && e !== null) switch (e.$$typeof) {
            case _c:
               i = 10;
               break e;
            case Pc:
               i = 9;
               break e;
            case Du:
               i = 11;
               break e;
            case _u:
               i = 14;
               break e;
            case Pt:
               i = 16, r = null;
               break e
         }
         throw Error(k(130, e == null ? e : typeof e, ""))
   }
   return t = Be(i, n, t, l), t.elementType = e, t.type = r, t.lanes = o, t
}

function ln(e, t, n, r) {
   return e = Be(7, e, r, t), e.lanes = n, e
}

function To(e, t, n, r) {
   return e = Be(22, e, r, t), e.elementType = Rc, e.lanes = n, e.stateNode = {
      isHidden: !1
   }, e
}

function vi(e, t, n) {
   return e = Be(6, e, null, t), e.lanes = n, e
}

function mi(e, t, n) {
   return t = Be(4, e.children !== null ? e.children : [], e.key, t), t.lanes = n, t.stateNode = {
      containerInfo: e.containerInfo,
      pendingChildren: null,
      implementation: e.implementation
   }, t
}

function bv(e, t, n, r, l) {
   this.tag = t, this.containerInfo = e, this.finishedWork = this.pingCache = this.current = this.pendingChildren = null, this.timeoutHandle = -1, this.callbackNode = this.pendingContext = this.context = null, this.callbackPriority = 0, this.eventTimes = Zo(0), this.expirationTimes = Zo(-1), this.entangledLanes = this.finishedLanes = this.mutableReadLanes = this.expiredLanes = this.pingedLanes = this.suspendedLanes = this.pendingLanes = 0, this.entanglements = Zo(0), this.identifierPrefix = r, this.onRecoverableError = l, this.mutableSourceEagerHydrationData = null
}

function ss(e, t, n, r, l, o, i, u, s) {
   return e = new bv(e, t, n, u, s), t === 1 ? (t = 1, o === !0 && (t |= 8)) : t = 0, o = Be(3, null, null, t), e.current = o, o.stateNode = e, o.memoizedState = {
      element: r,
      isDehydrated: n,
      cache: null,
      transitions: null,
      pendingSuspenseBoundaries: null
   }, Qu(o), e
}

function em(e, t, n) {
   var r = 3 < arguments.length && arguments[3] !== void 0 ? arguments[3] : null;
   return {
      $$typeof: xn,
      key: r == null ? null : "" + r,
      children: e,
      containerInfo: t,
      implementation: n
   }
}

function xd(e) {
   if (!e) return Qt;
   e = e._reactInternals;
   e: {
      if (dn(e) !== e || e.tag !== 1) throw Error(k(170));
      var t = e;do {
         switch (t.tag) {
            case 3:
               t = t.stateNode.context;
               break e;
            case 1:
               if (Ce(t.type)) {
                  t = t.stateNode.__reactInternalMemoizedMergedChildContext;
                  break e
               }
         }
         t = t.return
      } while (t !== null);
      throw Error(k(171))
   }
   if (e.tag === 1) {
      var n = e.type;
      if (Ce(n)) return xf(e, n, t)
   }
   return t
}

function kd(e, t, n, r, l, o, i, u, s) {
   return e = ss(n, r, !0, e, l, o, i, u, s), e.context = xd(null), n = e.current, r = ge(), l = Vt(n), o = vt(r, l), o.callback = t ?? null, Ut(n, o, l), e.current.lanes = l, Zr(e, l, r), Ne(e, r), e
}

function Oo(e, t, n, r) {
   var l = t.current,
      o = ge(),
      i = Vt(l);
   return n = xd(n), t.context === null ? t.context = n : t.pendingContext = n, t = vt(o, i), t.payload = {
      element: e
   }, r = r === void 0 ? null : r, r !== null && (t.callback = r), e = Ut(l, t, i), e !== null && (be(e, l, i, o), Tl(e, l, i)), i
}

function uo(e) {
   if (e = e.current, !e.child) return null;
   switch (e.child.tag) {
      case 5:
         return e.child.stateNode;
      default:
         return e.child.stateNode
   }
}

function Ua(e, t) {
   if (e = e.memoizedState, e !== null && e.dehydrated !== null) {
      var n = e.retryLane;
      e.retryLane = n !== 0 && n < t ? n : t
   }
}

function as(e, t) {
   Ua(e, t), (e = e.alternate) && Ua(e, t)
}

function tm() {
   return null
}
var Ed = typeof reportError == "function" ? reportError : function (e) {
   console.error(e)
};

function cs(e) {
   this._internalRoot = e
}
zo.prototype.render = cs.prototype.render = function (e) {
   var t = this._internalRoot;
   if (t === null) throw Error(k(409));
   Oo(e, t, null, null)
};
zo.prototype.unmount = cs.prototype.unmount = function () {
   var e = this._internalRoot;
   if (e !== null) {
      this._internalRoot = null;
      var t = e.containerInfo;
      cn(function () {
         Oo(null, e, null, null)
      }), t[gt] = null
   }
};

function zo(e) {
   this._internalRoot = e
}
zo.prototype.unstable_scheduleHydration = function (e) {
   if (e) {
      var t = bc();
      e = {
         blockedOn: null,
         target: e,
         priority: t
      };
      for (var n = 0; n < Ot.length && t !== 0 && t < Ot[n].priority; n++);
      Ot.splice(n, 0, e), n === 0 && tf(e)
   }
};

function fs(e) {
   return !(!e || e.nodeType !== 1 && e.nodeType !== 9 && e.nodeType !== 11)
}

function Lo(e) {
   return !(!e || e.nodeType !== 1 && e.nodeType !== 9 && e.nodeType !== 11 && (e.nodeType !== 8 || e.nodeValue !== " react-mount-point-unstable "))
}

function Ba() {}

function nm(e, t, n, r, l) {
   if (l) {
      if (typeof r == "function") {
         var o = r;
         r = function () {
            var a = uo(i);
            o.call(a)
         }
      }
      var i = kd(t, r, e, 0, null, !1, !1, "", Ba);
      return e._reactRootContainer = i, e[gt] = i.current, Fr(e.nodeType === 8 ? e.parentNode : e), cn(), i
   }
   for (; l = e.lastChild;) e.removeChild(l);
   if (typeof r == "function") {
      var u = r;
      r = function () {
         var a = uo(s);
         u.call(a)
      }
   }
   var s = ss(e, 0, !1, null, null, !1, !1, "", Ba);
   return e._reactRootContainer = s, e[gt] = s.current, Fr(e.nodeType === 8 ? e.parentNode : e), cn(function () {
      Oo(t, s, n, r)
   }), s
}

function Mo(e, t, n, r, l) {
   var o = n._reactRootContainer;
   if (o) {
      var i = o;
      if (typeof l == "function") {
         var u = l;
         l = function () {
            var s = uo(i);
            u.call(s)
         }
      }
      Oo(t, i, e, l)
   } else i = nm(n, t, e, l, r);
   return uo(i)
}
Jc = function (e) {
   switch (e.tag) {
      case 3:
         var t = e.stateNode;
         if (t.current.memoizedState.isDehydrated) {
            var n = hr(t.pendingLanes);
            n !== 0 && (Tu(t, n | 1), Ne(t, Z()), !(j & 6) && (Xn = Z() + 500, Xt()))
         }
         break;
      case 13:
         cn(function () {
            var r = yt(e, 1);
            if (r !== null) {
               var l = ge();
               be(r, e, 1, l)
            }
         }), as(e, 1)
   }
};
Ou = function (e) {
   if (e.tag === 13) {
      var t = yt(e, 134217728);
      if (t !== null) {
         var n = ge();
         be(t, e, 134217728, n)
      }
      as(e, 134217728)
   }
};
qc = function (e) {
   if (e.tag === 13) {
      var t = Vt(e),
         n = yt(e, t);
      if (n !== null) {
         var r = ge();
         be(n, e, t, r)
      }
      as(e, t)
   }
};
bc = function () {
   return A
};
ef = function (e, t) {
   var n = A;
   try {
      return A = e, t()
   } finally {
      A = n
   }
};
Mi = function (e, t, n) {
   switch (t) {
      case "input":
         if (_i(e, n), t = n.name, n.type === "radio" && t != null) {
            for (n = e; n.parentNode;) n = n.parentNode;
            for (n = n.querySelectorAll("input[name=" + JSON.stringify("" + t) + '][type="radio"]'), t = 0; t < n.length; t++) {
               var r = n[t];
               if (r !== e && r.form === e.form) {
                  var l = Co(r);
                  if (!l) throw Error(k(90));
                  Oc(r), _i(r, l)
               }
            }
         }
         break;
      case "textarea":
         Lc(e, n);
         break;
      case "select":
         t = n.value, t != null && Mn(e, !!n.multiple, t, !1)
   }
};
Uc = ls;
Bc = cn;
var rm = {
      usingClientEntryPoint: !1,
      Events: [qr, Dn, Co, Ac, $c, ls]
   },
   fr = {
      findFiberByHostInstance: en,
      bundleType: 0,
      version: "18.3.1",
      rendererPackageName: "react-dom"
   },
   lm = {
      bundleType: fr.bundleType,
      version: fr.version,
      rendererPackageName: fr.rendererPackageName,
      rendererConfig: fr.rendererConfig,
      overrideHookState: null,
      overrideHookStateDeletePath: null,
      overrideHookStateRenamePath: null,
      overrideProps: null,
      overridePropsDeletePath: null,
      overridePropsRenamePath: null,
      setErrorHandler: null,
      setSuspenseHandler: null,
      scheduleUpdate: null,
      currentDispatcherRef: xt.ReactCurrentDispatcher,
      findHostInstanceByFiber: function (e) {
         return e = Hc(e), e === null ? null : e.stateNode
      },
      findFiberByHostInstance: fr.findFiberByHostInstance || tm,
      findHostInstancesForRefresh: null,
      scheduleRefresh: null,
      scheduleRoot: null,
      setRefreshHandler: null,
      getCurrentFiber: null,
      reconcilerVersion: "18.3.1-next-f1338f8080-20240426"
   };
if (typeof __REACT_DEVTOOLS_GLOBAL_HOOK__ < "u") {
   var Cl = __REACT_DEVTOOLS_GLOBAL_HOOK__;
   if (!Cl.isDisabled && Cl.supportsFiber) try {
      So = Cl.inject(lm), st = Cl
   } catch {}
}
Me.__SECRET_INTERNALS_DO_NOT_USE_OR_YOU_WILL_BE_FIRED = rm;
Me.createPortal = function (e, t) {
   var n = 2 < arguments.length && arguments[2] !== void 0 ? arguments[2] : null;
   if (!fs(t)) throw Error(k(200));
   return em(e, t, null, n)
};
Me.createRoot = function (e, t) {
   if (!fs(e)) throw Error(k(299));
   var n = !1,
      r = "",
      l = Ed;
   return t != null && (t.unstable_strictMode === !0 && (n = !0), t.identifierPrefix !== void 0 && (r = t.identifierPrefix), t.onRecoverableError !== void 0 && (l = t.onRecoverableError)), t = ss(e, 1, !1, null, null, n, !1, r, l), e[gt] = t.current, Fr(e.nodeType === 8 ? e.parentNode : e), new cs(t)
};
Me.findDOMNode = function (e) {
   if (e == null) return null;
   if (e.nodeType === 1) return e;
   var t = e._reactInternals;
   if (t === void 0) throw typeof e.render == "function" ? Error(k(188)) : (e = Object.keys(e).join(","), Error(k(268, e)));
   return e = Hc(t), e = e === null ? null : e.stateNode, e
};
Me.flushSync = function (e) {
   return cn(e)
};
Me.hydrate = function (e, t, n) {
   if (!Lo(t)) throw Error(k(200));
   return Mo(null, e, t, !0, n)
};
Me.hydrateRoot = function (e, t, n) {
   if (!fs(e)) throw Error(k(405));
   var r = n != null && n.hydratedSources || null,
      l = !1,
      o = "",
      i = Ed;
   if (n != null && (n.unstable_strictMode === !0 && (l = !0), n.identifierPrefix !== void 0 && (o = n.identifierPrefix), n.onRecoverableError !== void 0 && (i = n.onRecoverableError)), t = kd(t, null, e, 1, n ?? null, l, !1, o, i), e[gt] = t.current, Fr(e), r)
      for (e = 0; e < r.length; e++) n = r[e], l = n._getVersion, l = l(n._source), t.mutableSourceEagerHydrationData == null ? t.mutableSourceEagerHydrationData = [n, l] : t.mutableSourceEagerHydrationData.push(n, l);
   return new zo(t)
};
Me.render = function (e, t, n) {
   if (!Lo(t)) throw Error(k(200));
   return Mo(null, e, t, !1, n)
};
Me.unmountComponentAtNode = function (e) {
   if (!Lo(e)) throw Error(k(40));
   return e._reactRootContainer ? (cn(function () {
      Mo(null, null, e, !1, function () {
         e._reactRootContainer = null, e[gt] = null
      })
   }), !0) : !1
};
Me.unstable_batchedUpdates = ls;
Me.unstable_renderSubtreeIntoContainer = function (e, t, n, r) {
   if (!Lo(n)) throw Error(k(200));
   if (e == null || e._reactInternals === void 0) throw Error(k(38));
   return Mo(e, t, n, !1, r)
};
Me.version = "18.3.1-next-f1338f8080-20240426";

function Cd() {
   if (!(typeof __REACT_DEVTOOLS_GLOBAL_HOOK__ > "u" || typeof __REACT_DEVTOOLS_GLOBAL_HOOK__.checkDCE != "function")) try {
      __REACT_DEVTOOLS_GLOBAL_HOOK__.checkDCE(Cd)
   } catch (e) {
      console.error(e)
   }
}
Cd(), Ec.exports = Me;
var Ln = Ec.exports;
const jo = typeof window < "u" && typeof window.document < "u" && typeof window.document.createElement < "u";

function qn(e) {
   const t = Object.prototype.toString.call(e);
   return t === "[object Window]" || t === "[object global]"
}

function ds(e) {
   return "nodeType" in e
}

function Se(e) {
   var t, n;
   return e ? qn(e) ? e : ds(e) && (t = (n = e.ownerDocument) == null ? void 0 : n.defaultView) != null ? t : window : window
}

function ps(e) {
   const {
      Document: t
   } = Se(e);
   return e instanceof t
}

function el(e) {
   return qn(e) ? !1 : e instanceof Se(e).HTMLElement
}

function Nd(e) {
   return e instanceof Se(e).SVGElement
}

function bn(e) {
   return e ? qn(e) ? e.document : ds(e) ? ps(e) ? e : el(e) || Nd(e) ? e.ownerDocument : document : document : document
}
const St = jo ? g.useLayoutEffect : g.useEffect;

function Io(e) {
   const t = g.useRef(e);
   return St(() => {
      t.current = e
   }), g.useCallback(function () {
      for (var n = arguments.length, r = new Array(n), l = 0; l < n; l++) r[l] = arguments[l];
      return t.current == null ? void 0 : t.current(...r)
   }, [])
}

function om() {
   const e = g.useRef(null),
      t = g.useCallback((r, l) => {
         e.current = setInterval(r, l)
      }, []),
      n = g.useCallback(() => {
         e.current !== null && (clearInterval(e.current), e.current = null)
      }, []);
   return [t, n]
}

function Kr(e, t) {
   t === void 0 && (t = [e]);
   const n = g.useRef(e);
   return St(() => {
      n.current !== e && (n.current = e)
   }, t), n
}

function tl(e, t) {
   const n = g.useRef();
   return g.useMemo(() => {
      const r = e(n.current);
      return n.current = r, r
   }, [...t])
}

function so(e) {
   const t = Io(e),
      n = g.useRef(null),
      r = g.useCallback(l => {
         l !== n.current && (t == null || t(l, n.current)), n.current = l
      }, []);
   return [n, r]
}

function ao(e) {
   const t = g.useRef();
   return g.useEffect(() => {
      t.current = e
   }, [e]), t.current
}
let gi = {};

function Fo(e, t) {
   return g.useMemo(() => {
      if (t) return t;
      const n = gi[e] == null ? 0 : gi[e] + 1;
      return gi[e] = n, e + "-" + n
   }, [e, t])
}

function Dd(e) {
   return function (t) {
      for (var n = arguments.length, r = new Array(n > 1 ? n - 1 : 0), l = 1; l < n; l++) r[l - 1] = arguments[l];
      return r.reduce((o, i) => {
         const u = Object.entries(i);
         for (const [s, a] of u) {
            const p = o[s];
            p != null && (o[s] = p + e * a)
         }
         return o
      }, {
         ...t
      })
   }
}
const Un = Dd(1),
   co = Dd(-1);

function im(e) {
   return "clientX" in e && "clientY" in e
}

function hs(e) {
   if (!e) return !1;
   const {
      KeyboardEvent: t
   } = Se(e.target);
   return t && e instanceof t
}

function um(e) {
   if (!e) return !1;
   const {
      TouchEvent: t
   } = Se(e.target);
   return t && e instanceof t
}

function fo(e) {
   if (um(e)) {
      if (e.touches && e.touches.length) {
         const {
            clientX: t,
            clientY: n
         } = e.touches[0];
         return {
            x: t,
            y: n
         }
      } else if (e.changedTouches && e.changedTouches.length) {
         const {
            clientX: t,
            clientY: n
         } = e.changedTouches[0];
         return {
            x: t,
            y: n
         }
      }
   }
   return im(e) ? {
      x: e.clientX,
      y: e.clientY
   } : null
}
const Yr = Object.freeze({
      Translate: {
         toString(e) {
            if (!e) return;
            const {
               x: t,
               y: n
            } = e;
            return "translate3d(" + (t ? Math.round(t) : 0) + "px, " + (n ? Math.round(n) : 0) + "px, 0)"
         }
      },
      Scale: {
         toString(e) {
            if (!e) return;
            const {
               scaleX: t,
               scaleY: n
            } = e;
            return "scaleX(" + t + ") scaleY(" + n + ")"
         }
      },
      Transform: {
         toString(e) {
            if (e) return [Yr.Translate.toString(e), Yr.Scale.toString(e)].join(" ")
         }
      },
      Transition: {
         toString(e) {
            let {
               property: t,
               duration: n,
               easing: r
            } = e;
            return t + " " + n + "ms " + r
         }
      }
   }),
   Va = "a,frame,iframe,input:not([type=hidden]):not(:disabled),select:not(:disabled),textarea:not(:disabled),button:not(:disabled),*[tabindex]";

function sm(e) {
   return e.matches(Va) ? e : e.querySelector(Va)
}
const am = {
   display: "none"
};

function cm(e) {
   let {
      id: t,
      value: n
   } = e;
   return F.createElement("div", {
      id: t,
      style: am
   }, n)
}

function fm(e) {
   let {
      id: t,
      announcement: n,
      ariaLiveType: r = "assertive"
   } = e;
   const l = {
      position: "fixed",
      top: 0,
      left: 0,
      width: 1,
      height: 1,
      margin: -1,
      border: 0,
      padding: 0,
      overflow: "hidden",
      clip: "rect(0 0 0 0)",
      clipPath: "inset(100%)",
      whiteSpace: "nowrap"
   };
   return F.createElement("div", {
      id: t,
      style: l,
      role: "status",
      "aria-live": r,
      "aria-atomic": !0
   }, n)
}

function dm() {
   const [e, t] = g.useState("");
   return {
      announce: g.useCallback(r => {
         r != null && t(r)
      }, []),
      announcement: e
   }
}
const _d = g.createContext(null);

function pm(e) {
   const t = g.useContext(_d);
   g.useEffect(() => {
      if (!t) throw new Error("useDndMonitor must be used within a children of <DndContext>");
      return t(e)
   }, [e, t])
}

function hm() {
   const [e] = g.useState(() => new Set), t = g.useCallback(r => (e.add(r), () => e.delete(r)), [e]);
   return [g.useCallback(r => {
      let {
         type: l,
         event: o
      } = r;
      e.forEach(i => {
         var u;
         return (u = i[l]) == null ? void 0 : u.call(i, o)
      })
   }, [e]), t]
}
const vm = {
      draggable: `
    To pick up a draggable item, press the space bar.
    While dragging, use the arrow keys to move the item.
    Press space again to drop the item in its new position, or press escape to cancel.
  `
   },
   mm = {
      onDragStart(e) {
         let {
            active: t
         } = e;
         return "Picked up draggable item " + t.id + "."
      },
      onDragOver(e) {
         let {
            active: t,
            over: n
         } = e;
         return n ? "Draggable item " + t.id + " was moved over droppable area " + n.id + "." : "Draggable item " + t.id + " is no longer over a droppable area."
      },
      onDragEnd(e) {
         let {
            active: t,
            over: n
         } = e;
         return n ? "Draggable item " + t.id + " was dropped over droppable area " + n.id : "Draggable item " + t.id + " was dropped."
      },
      onDragCancel(e) {
         let {
            active: t
         } = e;
         return "Dragging was cancelled. Draggable item " + t.id + " was dropped."
      }
   };

function gm(e) {
   let {
      announcements: t = mm,
      container: n,
      hiddenTextDescribedById: r,
      screenReaderInstructions: l = vm
   } = e;
   const {
      announce: o,
      announcement: i
   } = dm(), u = Fo("DndLiveRegion"), [s, a] = g.useState(!1);
   if (g.useEffect(() => {
         a(!0)
      }, []), pm(g.useMemo(() => ({
         onDragStart(d) {
            let {
               active: v
            } = d;
            o(t.onDragStart({
               active: v
            }))
         },
         onDragMove(d) {
            let {
               active: v,
               over: m
            } = d;
            t.onDragMove && o(t.onDragMove({
               active: v,
               over: m
            }))
         },
         onDragOver(d) {
            let {
               active: v,
               over: m
            } = d;
            o(t.onDragOver({
               active: v,
               over: m
            }))
         },
         onDragEnd(d) {
            let {
               active: v,
               over: m
            } = d;
            o(t.onDragEnd({
               active: v,
               over: m
            }))
         },
         onDragCancel(d) {
            let {
               active: v,
               over: m
            } = d;
            o(t.onDragCancel({
               active: v,
               over: m
            }))
         }
      }), [o, t])), !s) return null;
   const p = F.createElement(F.Fragment, null, F.createElement(cm, {
      id: r,
      value: l.draggable
   }), F.createElement(fm, {
      id: u,
      announcement: i
   }));
   return n ? Ln.createPortal(p, n) : p
}
var ee;
(function (e) {
   e.DragStart = "dragStart", e.DragMove = "dragMove", e.DragEnd = "dragEnd", e.DragCancel = "dragCancel", e.DragOver = "dragOver", e.RegisterDroppable = "registerDroppable", e.SetDroppableDisabled = "setDroppableDisabled", e.UnregisterDroppable = "unregisterDroppable"
})(ee || (ee = {}));

function po() {}
const tt = Object.freeze({
   x: 0,
   y: 0
});

function ym(e, t) {
   const n = fo(e);
   if (!n) return "0 0";
   const r = {
      x: (n.x - t.left) / t.width * 100,
      y: (n.y - t.top) / t.height * 100
   };
   return r.x + "% " + r.y + "%"
}

function wm(e, t) {
   let {
      data: {
         value: n
      }
   } = e, {
      data: {
         value: r
      }
   } = t;
   return r - n
}

function Sm(e, t) {
   if (!e || e.length === 0) return null;
   const [n] = e;
   return n[t]
}

function xm(e, t) {
   const n = Math.max(t.top, e.top),
      r = Math.max(t.left, e.left),
      l = Math.min(t.left + t.width, e.left + e.width),
      o = Math.min(t.top + t.height, e.top + e.height),
      i = l - r,
      u = o - n;
   if (r < l && n < o) {
      const s = t.width * t.height,
         a = e.width * e.height,
         p = i * u,
         d = p / (s + a - p);
      return Number(d.toFixed(4))
   }
   return 0
}
const km = e => {
   let {
      collisionRect: t,
      droppableRects: n,
      droppableContainers: r
   } = e;
   const l = [];
   for (const o of r) {
      const {
         id: i
      } = o, u = n.get(i);
      if (u) {
         const s = xm(u, t);
         s > 0 && l.push({
            id: i,
            data: {
               droppableContainer: o,
               value: s
            }
         })
      }
   }
   return l.sort(wm)
};

function Em(e, t, n) {
   return {
      ...e,
      scaleX: t && n ? t.width / n.width : 1,
      scaleY: t && n ? t.height / n.height : 1
   }
}

function Pd(e, t) {
   return e && t ? {
      x: e.left - t.left,
      y: e.top - t.top
   } : tt
}

function Cm(e) {
   return function (n) {
      for (var r = arguments.length, l = new Array(r > 1 ? r - 1 : 0), o = 1; o < r; o++) l[o - 1] = arguments[o];
      return l.reduce((i, u) => ({
         ...i,
         top: i.top + e * u.y,
         bottom: i.bottom + e * u.y,
         left: i.left + e * u.x,
         right: i.right + e * u.x
      }), {
         ...n
      })
   }
}
const Nm = Cm(1);

function Rd(e) {
   if (e.startsWith("matrix3d(")) {
      const t = e.slice(9, -1).split(/, /);
      return {
         x: +t[12],
         y: +t[13],
         scaleX: +t[0],
         scaleY: +t[5]
      }
   } else if (e.startsWith("matrix(")) {
      const t = e.slice(7, -1).split(/, /);
      return {
         x: +t[4],
         y: +t[5],
         scaleX: +t[0],
         scaleY: +t[3]
      }
   }
   return null
}

function Dm(e, t, n) {
   const r = Rd(t);
   if (!r) return e;
   const {
      scaleX: l,
      scaleY: o,
      x: i,
      y: u
   } = r, s = e.left - i - (1 - l) * parseFloat(n), a = e.top - u - (1 - o) * parseFloat(n.slice(n.indexOf(" ") + 1)), p = l ? e.width / l : e.width, d = o ? e.height / o : e.height;
   return {
      width: p,
      height: d,
      top: a,
      right: s + p,
      bottom: a + d,
      left: s
   }
}
const _m = {
   ignoreTransform: !1
};

function nl(e, t) {
   t === void 0 && (t = _m);
   let n = e.getBoundingClientRect();
   if (t.ignoreTransform) {
      const {
         transform: a,
         transformOrigin: p
      } = Se(e).getComputedStyle(e);
      a && (n = Dm(n, a, p))
   }
   const {
      top: r,
      left: l,
      width: o,
      height: i,
      bottom: u,
      right: s
   } = n;
   return {
      top: r,
      left: l,
      width: o,
      height: i,
      bottom: u,
      right: s
   }
}

function Wa(e) {
   return nl(e, {
      ignoreTransform: !0
   })
}

function Pm(e) {
   const t = e.innerWidth,
      n = e.innerHeight;
   return {
      top: 0,
      left: 0,
      right: t,
      bottom: n,
      width: t,
      height: n
   }
}

function Rm(e, t) {
   return t === void 0 && (t = Se(e).getComputedStyle(e)), t.position === "fixed"
}

function Tm(e, t) {
   t === void 0 && (t = Se(e).getComputedStyle(e));
   const n = /(auto|scroll|overlay)/;
   return ["overflow", "overflowX", "overflowY"].some(l => {
      const o = t[l];
      return typeof o == "string" ? n.test(o) : !1
   })
}

function vs(e, t) {
   const n = [];

   function r(l) {
      if (t != null && n.length >= t || !l) return n;
      if (ps(l) && l.scrollingElement != null && !n.includes(l.scrollingElement)) return n.push(l.scrollingElement), n;
      if (!el(l) || Nd(l) || n.includes(l)) return n;
      const o = Se(e).getComputedStyle(l);
      return l !== e && Tm(l, o) && n.push(l), Rm(l, o) ? n : r(l.parentNode)
   }
   return e ? r(e) : n
}

function Td(e) {
   const [t] = vs(e, 1);
   return t ?? null
}

function yi(e) {
   return !jo || !e ? null : qn(e) ? e : ds(e) ? ps(e) || e === bn(e).scrollingElement ? window : el(e) ? e : null : null
}

function Od(e) {
   return qn(e) ? e.scrollX : e.scrollLeft
}

function zd(e) {
   return qn(e) ? e.scrollY : e.scrollTop
}

function pu(e) {
   return {
      x: Od(e),
      y: zd(e)
   }
}
var re;
(function (e) {
   e[e.Forward = 1] = "Forward", e[e.Backward = -1] = "Backward"
})(re || (re = {}));

function Ld(e) {
   return !jo || !e ? !1 : e === document.scrollingElement
}

function Md(e) {
   const t = {
         x: 0,
         y: 0
      },
      n = Ld(e) ? {
         height: window.innerHeight,
         width: window.innerWidth
      } : {
         height: e.clientHeight,
         width: e.clientWidth
      },
      r = {
         x: e.scrollWidth - n.width,
         y: e.scrollHeight - n.height
      },
      l = e.scrollTop <= t.y,
      o = e.scrollLeft <= t.x,
      i = e.scrollTop >= r.y,
      u = e.scrollLeft >= r.x;
   return {
      isTop: l,
      isLeft: o,
      isBottom: i,
      isRight: u,
      maxScroll: r,
      minScroll: t
   }
}
const Om = {
   x: .2,
   y: .2
};

function zm(e, t, n, r, l) {
   let {
      top: o,
      left: i,
      right: u,
      bottom: s
   } = n;
   r === void 0 && (r = 10), l === void 0 && (l = Om);
   const {
      isTop: a,
      isBottom: p,
      isLeft: d,
      isRight: v
   } = Md(e), m = {
      x: 0,
      y: 0
   }, w = {
      x: 0,
      y: 0
   }, y = {
      height: t.height * l.y,
      width: t.width * l.x
   };
   return !a && o <= t.top + y.height ? (m.y = re.Backward, w.y = r * Math.abs((t.top + y.height - o) / y.height)) : !p && s >= t.bottom - y.height && (m.y = re.Forward, w.y = r * Math.abs((t.bottom - y.height - s) / y.height)), !v && u >= t.right - y.width ? (m.x = re.Forward, w.x = r * Math.abs((t.right - y.width - u) / y.width)) : !d && i <= t.left + y.width && (m.x = re.Backward, w.x = r * Math.abs((t.left + y.width - i) / y.width)), {
      direction: m,
      speed: w
   }
}

function Lm(e) {
   if (e === document.scrollingElement) {
      const {
         innerWidth: o,
         innerHeight: i
      } = window;
      return {
         top: 0,
         left: 0,
         right: o,
         bottom: i,
         width: o,
         height: i
      }
   }
   const {
      top: t,
      left: n,
      right: r,
      bottom: l
   } = e.getBoundingClientRect();
   return {
      top: t,
      left: n,
      right: r,
      bottom: l,
      width: e.clientWidth,
      height: e.clientHeight
   }
}

function jd(e) {
   return e.reduce((t, n) => Un(t, pu(n)), tt)
}

function Mm(e) {
   return e.reduce((t, n) => t + Od(n), 0)
}

function jm(e) {
   return e.reduce((t, n) => t + zd(n), 0)
}

function Id(e, t) {
   if (t === void 0 && (t = nl), !e) return;
   const {
      top: n,
      left: r,
      bottom: l,
      right: o
   } = t(e);
   Td(e) && (l <= 0 || o <= 0 || n >= window.innerHeight || r >= window.innerWidth) && e.scrollIntoView({
      block: "center",
      inline: "center"
   })
}
const Im = [
   ["x", ["left", "right"], Mm],
   ["y", ["top", "bottom"], jm]
];
class ms {
   constructor(t, n) {
      this.rect = void 0, this.width = void 0, this.height = void 0, this.top = void 0, this.bottom = void 0, this.right = void 0, this.left = void 0;
      const r = vs(n),
         l = jd(r);
      this.rect = {
         ...t
      }, this.width = t.width, this.height = t.height;
      for (const [o, i, u] of Im)
         for (const s of i) Object.defineProperty(this, s, {
            get: () => {
               const a = u(r),
                  p = l[o] - a;
               return this.rect[s] + p
            },
            enumerable: !0
         });
      Object.defineProperty(this, "rect", {
         enumerable: !1
      })
   }
}
class Nr {
   constructor(t) {
      this.target = void 0, this.listeners = [], this.removeAll = () => {
         this.listeners.forEach(n => {
            var r;
            return (r = this.target) == null ? void 0 : r.removeEventListener(...n)
         })
      }, this.target = t
   }
   add(t, n, r) {
      var l;
      (l = this.target) == null || l.addEventListener(t, n, r), this.listeners.push([t, n, r])
   }
}

function Fm(e) {
   const {
      EventTarget: t
   } = Se(e);
   return e instanceof t ? e : bn(e)
}

function wi(e, t) {
   const n = Math.abs(e.x),
      r = Math.abs(e.y);
   return typeof t == "number" ? Math.sqrt(n ** 2 + r ** 2) > t : "x" in t && "y" in t ? n > t.x && r > t.y : "x" in t ? n > t.x : "y" in t ? r > t.y : !1
}
var Ae;
(function (e) {
   e.Click = "click", e.DragStart = "dragstart", e.Keydown = "keydown", e.ContextMenu = "contextmenu", e.Resize = "resize", e.SelectionChange = "selectionchange", e.VisibilityChange = "visibilitychange"
})(Ae || (Ae = {}));

function Ha(e) {
   e.preventDefault()
}

function Am(e) {
   e.stopPropagation()
}
var $;
(function (e) {
   e.Space = "Space", e.Down = "ArrowDown", e.Right = "ArrowRight", e.Left = "ArrowLeft", e.Up = "ArrowUp", e.Esc = "Escape", e.Enter = "Enter", e.Tab = "Tab"
})($ || ($ = {}));
const Fd = {
      start: [$.Space, $.Enter],
      cancel: [$.Esc],
      end: [$.Space, $.Enter, $.Tab]
   },
   $m = (e, t) => {
      let {
         currentCoordinates: n
      } = t;
      switch (e.code) {
         case $.Right:
            return {
               ...n, x: n.x + 25
            };
         case $.Left:
            return {
               ...n, x: n.x - 25
            };
         case $.Down:
            return {
               ...n, y: n.y + 25
            };
         case $.Up:
            return {
               ...n, y: n.y - 25
            }
      }
   };
class Ad {
   constructor(t) {
      this.props = void 0, this.autoScrollEnabled = !1, this.referenceCoordinates = void 0, this.listeners = void 0, this.windowListeners = void 0, this.props = t;
      const {
         event: {
            target: n
         }
      } = t;
      this.props = t, this.listeners = new Nr(bn(n)), this.windowListeners = new Nr(Se(n)), this.handleKeyDown = this.handleKeyDown.bind(this), this.handleCancel = this.handleCancel.bind(this), this.attach()
   }
   attach() {
      this.handleStart(), this.windowListeners.add(Ae.Resize, this.handleCancel), this.windowListeners.add(Ae.VisibilityChange, this.handleCancel), setTimeout(() => this.listeners.add(Ae.Keydown, this.handleKeyDown))
   }
   handleStart() {
      const {
         activeNode: t,
         onStart: n
      } = this.props, r = t.node.current;
      r && Id(r), n(tt)
   }
   handleKeyDown(t) {
      if (hs(t)) {
         const {
            active: n,
            context: r,
            options: l
         } = this.props, {
            keyboardCodes: o = Fd,
            coordinateGetter: i = $m,
            scrollBehavior: u = "smooth"
         } = l, {
            code: s
         } = t;
         if (o.end.includes(s)) {
            this.handleEnd(t);
            return
         }
         if (o.cancel.includes(s)) {
            this.handleCancel(t);
            return
         }
         const {
            collisionRect: a
         } = r.current, p = a ? {
            x: a.left,
            y: a.top
         } : tt;
         this.referenceCoordinates || (this.referenceCoordinates = p);
         const d = i(t, {
            active: n,
            context: r.current,
            currentCoordinates: p
         });
         if (d) {
            const v = co(d, p),
               m = {
                  x: 0,
                  y: 0
               },
               {
                  scrollableAncestors: w
               } = r.current;
            for (const y of w) {
               const D = t.code,
                  {
                     isTop: f,
                     isRight: c,
                     isLeft: h,
                     isBottom: S,
                     maxScroll: x,
                     minScroll: N
                  } = Md(y),
                  E = Lm(y),
                  C = {
                     x: Math.min(D === $.Right ? E.right - E.width / 2 : E.right, Math.max(D === $.Right ? E.left : E.left + E.width / 2, d.x)),
                     y: Math.min(D === $.Down ? E.bottom - E.height / 2 : E.bottom, Math.max(D === $.Down ? E.top : E.top + E.height / 2, d.y))
                  },
                  z = D === $.Right && !c || D === $.Left && !h,
                  T = D === $.Down && !S || D === $.Up && !f;
               if (z && C.x !== d.x) {
                  const I = y.scrollLeft + v.x,
                     he = D === $.Right && I <= x.x || D === $.Left && I >= N.x;
                  if (he && !v.y) {
                     y.scrollTo({
                        left: I,
                        behavior: u
                     });
                     return
                  }
                  he ? m.x = y.scrollLeft - I : m.x = D === $.Right ? y.scrollLeft - x.x : y.scrollLeft - N.x, m.x && y.scrollBy({
                     left: -m.x,
                     behavior: u
                  });
                  break
               } else if (T && C.y !== d.y) {
                  const I = y.scrollTop + v.y,
                     he = D === $.Down && I <= x.y || D === $.Up && I >= N.y;
                  if (he && !v.x) {
                     y.scrollTo({
                        top: I,
                        behavior: u
                     });
                     return
                  }
                  he ? m.y = y.scrollTop - I : m.y = D === $.Down ? y.scrollTop - x.y : y.scrollTop - N.y, m.y && y.scrollBy({
                     top: -m.y,
                     behavior: u
                  });
                  break
               }
            }
            this.handleMove(t, Un(co(d, this.referenceCoordinates), m))
         }
      }
   }
   handleMove(t, n) {
      const {
         onMove: r
      } = this.props;
      t.preventDefault(), r(n)
   }
   handleEnd(t) {
      const {
         onEnd: n
      } = this.props;
      t.preventDefault(), this.detach(), n()
   }
   handleCancel(t) {
      const {
         onCancel: n
      } = this.props;
      t.preventDefault(), this.detach(), n()
   }
   detach() {
      this.listeners.removeAll(), this.windowListeners.removeAll()
   }
}
Ad.activators = [{
   eventName: "onKeyDown",
   handler: (e, t, n) => {
      let {
         keyboardCodes: r = Fd,
         onActivation: l
      } = t, {
         active: o
      } = n;
      const {
         code: i
      } = e.nativeEvent;
      if (r.start.includes(i)) {
         const u = o.activatorNode.current;
         return u && e.target !== u ? !1 : (e.preventDefault(), l == null || l({
            event: e.nativeEvent
         }), !0)
      }
      return !1
   }
}];

function Qa(e) {
   return !!(e && "distance" in e)
}

function Ka(e) {
   return !!(e && "delay" in e)
}
class gs {
   constructor(t, n, r) {
      var l;
      r === void 0 && (r = Fm(t.event.target)), this.props = void 0, this.events = void 0, this.autoScrollEnabled = !0, this.document = void 0, this.activated = !1, this.initialCoordinates = void 0, this.timeoutId = null, this.listeners = void 0, this.documentListeners = void 0, this.windowListeners = void 0, this.props = t, this.events = n;
      const {
         event: o
      } = t, {
         target: i
      } = o;
      this.props = t, this.events = n, this.document = bn(i), this.documentListeners = new Nr(this.document), this.listeners = new Nr(r), this.windowListeners = new Nr(Se(i)), this.initialCoordinates = (l = fo(o)) != null ? l : tt, this.handleStart = this.handleStart.bind(this), this.handleMove = this.handleMove.bind(this), this.handleEnd = this.handleEnd.bind(this), this.handleCancel = this.handleCancel.bind(this), this.handleKeydown = this.handleKeydown.bind(this), this.removeTextSelection = this.removeTextSelection.bind(this), this.attach()
   }
   attach() {
      const {
         events: t,
         props: {
            options: {
               activationConstraint: n,
               bypassActivationConstraint: r
            }
         }
      } = this;
      if (this.listeners.add(t.move.name, this.handleMove, {
            passive: !1
         }), this.listeners.add(t.end.name, this.handleEnd), t.cancel && this.listeners.add(t.cancel.name, this.handleCancel), this.windowListeners.add(Ae.Resize, this.handleCancel), this.windowListeners.add(Ae.DragStart, Ha), this.windowListeners.add(Ae.VisibilityChange, this.handleCancel), this.windowListeners.add(Ae.ContextMenu, Ha), this.documentListeners.add(Ae.Keydown, this.handleKeydown), n) {
         if (r != null && r({
               event: this.props.event,
               activeNode: this.props.activeNode,
               options: this.props.options
            })) return this.handleStart();
         if (Ka(n)) {
            this.timeoutId = setTimeout(this.handleStart, n.delay), this.handlePending(n);
            return
         }
         if (Qa(n)) {
            this.handlePending(n);
            return
         }
      }
      this.handleStart()
   }
   detach() {
      this.listeners.removeAll(), this.windowListeners.removeAll(), setTimeout(this.documentListeners.removeAll, 50), this.timeoutId !== null && (clearTimeout(this.timeoutId), this.timeoutId = null)
   }
   handlePending(t, n) {
      const {
         active: r,
         onPending: l
      } = this.props;
      l(r, t, this.initialCoordinates, n)
   }
   handleStart() {
      const {
         initialCoordinates: t
      } = this, {
         onStart: n
      } = this.props;
      t && (this.activated = !0, this.documentListeners.add(Ae.Click, Am, {
         capture: !0
      }), this.removeTextSelection(), this.documentListeners.add(Ae.SelectionChange, this.removeTextSelection), n(t))
   }
   handleMove(t) {
      var n;
      const {
         activated: r,
         initialCoordinates: l,
         props: o
      } = this, {
         onMove: i,
         options: {
            activationConstraint: u
         }
      } = o;
      if (!l) return;
      const s = (n = fo(t)) != null ? n : tt,
         a = co(l, s);
      if (!r && u) {
         if (Qa(u)) {
            if (u.tolerance != null && wi(a, u.tolerance)) return this.handleCancel();
            if (wi(a, u.distance)) return this.handleStart()
         }
         if (Ka(u) && wi(a, u.tolerance)) return this.handleCancel();
         this.handlePending(u, a);
         return
      }
      t.cancelable && t.preventDefault(), i(s)
   }
   handleEnd() {
      const {
         onAbort: t,
         onEnd: n
      } = this.props;
      this.detach(), this.activated || t(this.props.active), n()
   }
   handleCancel() {
      const {
         onAbort: t,
         onCancel: n
      } = this.props;
      this.detach(), this.activated || t(this.props.active), n()
   }
   handleKeydown(t) {
      t.code === $.Esc && this.handleCancel()
   }
   removeTextSelection() {
      var t;
      (t = this.document.getSelection()) == null || t.removeAllRanges()
   }
}
const Um = {
   cancel: {
      name: "pointercancel"
   },
   move: {
      name: "pointermove"
   },
   end: {
      name: "pointerup"
   }
};
class $d extends gs {
   constructor(t) {
      const {
         event: n
      } = t, r = bn(n.target);
      super(t, Um, r)
   }
}
$d.activators = [{
   eventName: "onPointerDown",
   handler: (e, t) => {
      let {
         nativeEvent: n
      } = e, {
         onActivation: r
      } = t;
      return !n.isPrimary || n.button !== 0 ? !1 : (r == null || r({
         event: n
      }), !0)
   }
}];
const Bm = {
   move: {
      name: "mousemove"
   },
   end: {
      name: "mouseup"
   }
};
var hu;
(function (e) {
   e[e.RightClick = 2] = "RightClick"
})(hu || (hu = {}));
class Vm extends gs {
   constructor(t) {
      super(t, Bm, bn(t.event.target))
   }
}
Vm.activators = [{
   eventName: "onMouseDown",
   handler: (e, t) => {
      let {
         nativeEvent: n
      } = e, {
         onActivation: r
      } = t;
      return n.button === hu.RightClick ? !1 : (r == null || r({
         event: n
      }), !0)
   }
}];
const Si = {
   cancel: {
      name: "touchcancel"
   },
   move: {
      name: "touchmove"
   },
   end: {
      name: "touchend"
   }
};
class Wm extends gs {
   constructor(t) {
      super(t, Si)
   }
   static setup() {
      return window.addEventListener(Si.move.name, t, {
            capture: !1,
            passive: !1
         }),
         function () {
            window.removeEventListener(Si.move.name, t)
         };

      function t() {}
   }
}
Wm.activators = [{
   eventName: "onTouchStart",
   handler: (e, t) => {
      let {
         nativeEvent: n
      } = e, {
         onActivation: r
      } = t;
      const {
         touches: l
      } = n;
      return l.length > 1 ? !1 : (r == null || r({
         event: n
      }), !0)
   }
}];
var Dr;
(function (e) {
   e[e.Pointer = 0] = "Pointer", e[e.DraggableRect = 1] = "DraggableRect"
})(Dr || (Dr = {}));
var ho;
(function (e) {
   e[e.TreeOrder = 0] = "TreeOrder", e[e.ReversedTreeOrder = 1] = "ReversedTreeOrder"
})(ho || (ho = {}));

function Hm(e) {
   let {
      acceleration: t,
      activator: n = Dr.Pointer,
      canScroll: r,
      draggingRect: l,
      enabled: o,
      interval: i = 5,
      order: u = ho.TreeOrder,
      pointerCoordinates: s,
      scrollableAncestors: a,
      scrollableAncestorRects: p,
      delta: d,
      threshold: v
   } = e;
   const m = Km({
         delta: d,
         disabled: !o
      }),
      [w, y] = om(),
      D = g.useRef({
         x: 0,
         y: 0
      }),
      f = g.useRef({
         x: 0,
         y: 0
      }),
      c = g.useMemo(() => {
         switch (n) {
            case Dr.Pointer:
               return s ? {
                  top: s.y,
                  bottom: s.y,
                  left: s.x,
                  right: s.x
               } : null;
            case Dr.DraggableRect:
               return l
         }
      }, [n, l, s]),
      h = g.useRef(null),
      S = g.useCallback(() => {
         const N = h.current;
         if (!N) return;
         const E = D.current.x * f.current.x,
            C = D.current.y * f.current.y;
         N.scrollBy(E, C)
      }, []),
      x = g.useMemo(() => u === ho.TreeOrder ? [...a].reverse() : a, [u, a]);
   g.useEffect(() => {
      if (!o || !a.length || !c) {
         y();
         return
      }
      for (const N of x) {
         if ((r == null ? void 0 : r(N)) === !1) continue;
         const E = a.indexOf(N),
            C = p[E];
         if (!C) continue;
         const {
            direction: z,
            speed: T
         } = zm(N, C, c, t, v);
         for (const I of ["x", "y"]) m[I][z[I]] || (T[I] = 0, z[I] = 0);
         if (T.x > 0 || T.y > 0) {
            y(), h.current = N, w(S, i), D.current = T, f.current = z;
            return
         }
      }
      D.current = {
         x: 0,
         y: 0
      }, f.current = {
         x: 0,
         y: 0
      }, y()
   }, [t, S, r, y, o, i, JSON.stringify(c), JSON.stringify(m), w, a, x, p, JSON.stringify(v)])
}
const Qm = {
   x: {
      [re.Backward]: !1,
      [re.Forward]: !1
   },
   y: {
      [re.Backward]: !1,
      [re.Forward]: !1
   }
};

function Km(e) {
   let {
      delta: t,
      disabled: n
   } = e;
   const r = ao(t);
   return tl(l => {
      if (n || !r || !l) return Qm;
      const o = {
         x: Math.sign(t.x - r.x),
         y: Math.sign(t.y - r.y)
      };
      return {
         x: {
            [re.Backward]: l.x[re.Backward] || o.x === -1,
            [re.Forward]: l.x[re.Forward] || o.x === 1
         },
         y: {
            [re.Backward]: l.y[re.Backward] || o.y === -1,
            [re.Forward]: l.y[re.Forward] || o.y === 1
         }
      }
   }, [n, t, r])
}

function Ym(e, t) {
   const n = t != null ? e.get(t) : void 0,
      r = n ? n.node.current : null;
   return tl(l => {
      var o;
      return t == null ? null : (o = r ?? l) != null ? o : null
   }, [r, t])
}

function Xm(e, t) {
   return g.useMemo(() => e.reduce((n, r) => {
      const {
         sensor: l
      } = r, o = l.activators.map(i => ({
         eventName: i.eventName,
         handler: t(i.handler, r)
      }));
      return [...n, ...o]
   }, []), [e, t])
}
var Xr;
(function (e) {
   e[e.Always = 0] = "Always", e[e.BeforeDragging = 1] = "BeforeDragging", e[e.WhileDragging = 2] = "WhileDragging"
})(Xr || (Xr = {}));
var vu;
(function (e) {
   e.Optimized = "optimized"
})(vu || (vu = {}));
const Ya = new Map;

function Gm(e, t) {
   let {
      dragging: n,
      dependencies: r,
      config: l
   } = t;
   const [o, i] = g.useState(null), {
      frequency: u,
      measure: s,
      strategy: a
   } = l, p = g.useRef(e), d = D(), v = Kr(d), m = g.useCallback(function (f) {
      f === void 0 && (f = []), !v.current && i(c => c === null ? f : c.concat(f.filter(h => !c.includes(h))))
   }, [v]), w = g.useRef(null), y = tl(f => {
      if (d && !n) return Ya;
      if (!f || f === Ya || p.current !== e || o != null) {
         const c = new Map;
         for (let h of e) {
            if (!h) continue;
            if (o && o.length > 0 && !o.includes(h.id) && h.rect.current) {
               c.set(h.id, h.rect.current);
               continue
            }
            const S = h.node.current,
               x = S ? new ms(s(S), S) : null;
            h.rect.current = x, x && c.set(h.id, x)
         }
         return c
      }
      return f
   }, [e, o, n, d, s]);
   return g.useEffect(() => {
      p.current = e
   }, [e]), g.useEffect(() => {
      d || m()
   }, [n, d]), g.useEffect(() => {
      o && o.length > 0 && i(null)
   }, [JSON.stringify(o)]), g.useEffect(() => {
      d || typeof u != "number" || w.current !== null || (w.current = setTimeout(() => {
         m(), w.current = null
      }, u))
   }, [u, d, m, ...r]), {
      droppableRects: y,
      measureDroppableContainers: m,
      measuringScheduled: o != null
   };

   function D() {
      switch (a) {
         case Xr.Always:
            return !1;
         case Xr.BeforeDragging:
            return n;
         default:
            return !n
      }
   }
}

function ys(e, t) {
   return tl(n => e ? n || (typeof t == "function" ? t(e) : e) : null, [t, e])
}

function Zm(e, t) {
   return ys(e, t)
}

function Jm(e) {
   let {
      callback: t,
      disabled: n
   } = e;
   const r = Io(t),
      l = g.useMemo(() => {
         if (n || typeof window > "u" || typeof window.MutationObserver > "u") return;
         const {
            MutationObserver: o
         } = window;
         return new o(r)
      }, [r, n]);
   return g.useEffect(() => () => l == null ? void 0 : l.disconnect(), [l]), l
}

function Ao(e) {
   let {
      callback: t,
      disabled: n
   } = e;
   const r = Io(t),
      l = g.useMemo(() => {
         if (n || typeof window > "u" || typeof window.ResizeObserver > "u") return;
         const {
            ResizeObserver: o
         } = window;
         return new o(r)
      }, [n]);
   return g.useEffect(() => () => l == null ? void 0 : l.disconnect(), [l]), l
}

function qm(e) {
   return new ms(nl(e), e)
}

function Xa(e, t, n) {
   t === void 0 && (t = qm);
   const [r, l] = g.useState(null);

   function o() {
      l(s => {
         if (!e) return null;
         if (e.isConnected === !1) {
            var a;
            return (a = s ?? n) != null ? a : null
         }
         const p = t(e);
         return JSON.stringify(s) === JSON.stringify(p) ? s : p
      })
   }
   const i = Jm({
         callback(s) {
            if (e)
               for (const a of s) {
                  const {
                     type: p,
                     target: d
                  } = a;
                  if (p === "childList" && d instanceof HTMLElement && d.contains(e)) {
                     o();
                     break
                  }
               }
         }
      }),
      u = Ao({
         callback: o
      });
   return St(() => {
      o(), e ? (u == null || u.observe(e), i == null || i.observe(document.body, {
         childList: !0,
         subtree: !0
      })) : (u == null || u.disconnect(), i == null || i.disconnect())
   }, [e]), r
}

function bm(e) {
   const t = ys(e);
   return Pd(e, t)
}
const Ga = [];

function eg(e) {
   const t = g.useRef(e),
      n = tl(r => e ? r && r !== Ga && e && t.current && e.parentNode === t.current.parentNode ? r : vs(e) : Ga, [e]);
   return g.useEffect(() => {
      t.current = e
   }, [e]), n
}

function tg(e) {
   const [t, n] = g.useState(null), r = g.useRef(e), l = g.useCallback(o => {
      const i = yi(o.target);
      i && n(u => u ? (u.set(i, pu(i)), new Map(u)) : null)
   }, []);
   return g.useEffect(() => {
      const o = r.current;
      if (e !== o) {
         i(o);
         const u = e.map(s => {
            const a = yi(s);
            return a ? (a.addEventListener("scroll", l, {
               passive: !0
            }), [a, pu(a)]) : null
         }).filter(s => s != null);
         n(u.length ? new Map(u) : null), r.current = e
      }
      return () => {
         i(e), i(o)
      };

      function i(u) {
         u.forEach(s => {
            const a = yi(s);
            a == null || a.removeEventListener("scroll", l)
         })
      }
   }, [l, e]), g.useMemo(() => e.length ? t ? Array.from(t.values()).reduce((o, i) => Un(o, i), tt) : jd(e) : tt, [e, t])
}

function Za(e, t) {
   t === void 0 && (t = []);
   const n = g.useRef(null);
   return g.useEffect(() => {
      n.current = null
   }, t), g.useEffect(() => {
      const r = e !== tt;
      r && !n.current && (n.current = e), !r && n.current && (n.current = null)
   }, [e]), n.current ? co(e, n.current) : tt
}

function ng(e) {
   g.useEffect(() => {
      if (!jo) return;
      const t = e.map(n => {
         let {
            sensor: r
         } = n;
         return r.setup == null ? void 0 : r.setup()
      });
      return () => {
         for (const n of t) n == null || n()
      }
   }, e.map(t => {
      let {
         sensor: n
      } = t;
      return n
   }))
}

function rg(e, t) {
   return g.useMemo(() => e.reduce((n, r) => {
      let {
         eventName: l,
         handler: o
      } = r;
      return n[l] = i => {
         o(i, t)
      }, n
   }, {}), [e, t])
}

function Ud(e) {
   return g.useMemo(() => e ? Pm(e) : null, [e])
}
const Ja = [];

function lg(e, t) {
   t === void 0 && (t = nl);
   const [n] = e, r = Ud(n ? Se(n) : null), [l, o] = g.useState(Ja);

   function i() {
      o(() => e.length ? e.map(s => Ld(s) ? r : new ms(t(s), s)) : Ja)
   }
   const u = Ao({
      callback: i
   });
   return St(() => {
      u == null || u.disconnect(), i(), e.forEach(s => u == null ? void 0 : u.observe(s))
   }, [e]), l
}

function Bd(e) {
   if (!e) return null;
   if (e.children.length > 1) return e;
   const t = e.children[0];
   return el(t) ? t : e
}

function og(e) {
   let {
      measure: t
   } = e;
   const [n, r] = g.useState(null), l = g.useCallback(a => {
      for (const {
            target: p
         } of a)
         if (el(p)) {
            r(d => {
               const v = t(p);
               return d ? {
                  ...d,
                  width: v.width,
                  height: v.height
               } : v
            });
            break
         }
   }, [t]), o = Ao({
      callback: l
   }), i = g.useCallback(a => {
      const p = Bd(a);
      o == null || o.disconnect(), p && (o == null || o.observe(p)), r(p ? t(p) : null)
   }, [t, o]), [u, s] = so(i);
   return g.useMemo(() => ({
      nodeRef: u,
      rect: n,
      setRef: s
   }), [n, u, s])
}
const ig = [{
      sensor: $d,
      options: {}
   }, {
      sensor: Ad,
      options: {}
   }],
   ug = {
      current: {}
   },
   Fl = {
      draggable: {
         measure: Wa
      },
      droppable: {
         measure: Wa,
         strategy: Xr.WhileDragging,
         frequency: vu.Optimized
      },
      dragOverlay: {
         measure: nl
      }
   };
class _r extends Map {
   get(t) {
      var n;
      return t != null && (n = super.get(t)) != null ? n : void 0
   }
   toArray() {
      return Array.from(this.values())
   }
   getEnabled() {
      return this.toArray().filter(t => {
         let {
            disabled: n
         } = t;
         return !n
      })
   }
   getNodeFor(t) {
      var n, r;
      return (n = (r = this.get(t)) == null ? void 0 : r.node.current) != null ? n : void 0
   }
}
const sg = {
      activatorEvent: null,
      active: null,
      activeNode: null,
      activeNodeRect: null,
      collisions: null,
      containerNodeRect: null,
      draggableNodes: new Map,
      droppableRects: new Map,
      droppableContainers: new _r,
      over: null,
      dragOverlay: {
         nodeRef: {
            current: null
         },
         rect: null,
         setRef: po
      },
      scrollableAncestors: [],
      scrollableAncestorRects: [],
      measuringConfiguration: Fl,
      measureDroppableContainers: po,
      windowRect: null,
      measuringScheduled: !1
   },
   Vd = {
      activatorEvent: null,
      activators: [],
      active: null,
      activeNodeRect: null,
      ariaDescribedById: {
         draggable: ""
      },
      dispatch: po,
      draggableNodes: new Map,
      over: null,
      measureDroppableContainers: po
   },
   rl = g.createContext(Vd),
   Wd = g.createContext(sg);

function ag() {
   return {
      draggable: {
         active: null,
         initialCoordinates: {
            x: 0,
            y: 0
         },
         nodes: new Map,
         translate: {
            x: 0,
            y: 0
         }
      },
      droppable: {
         containers: new _r
      }
   }
}

function cg(e, t) {
   switch (t.type) {
      case ee.DragStart:
         return {
            ...e, draggable: {
               ...e.draggable,
               initialCoordinates: t.initialCoordinates,
               active: t.active
            }
         };
      case ee.DragMove:
         return e.draggable.active == null ? e : {
            ...e,
            draggable: {
               ...e.draggable,
               translate: {
                  x: t.coordinates.x - e.draggable.initialCoordinates.x,
                  y: t.coordinates.y - e.draggable.initialCoordinates.y
               }
            }
         };
      case ee.DragEnd:
      case ee.DragCancel:
         return {
            ...e, draggable: {
               ...e.draggable,
               active: null,
               initialCoordinates: {
                  x: 0,
                  y: 0
               },
               translate: {
                  x: 0,
                  y: 0
               }
            }
         };
      case ee.RegisterDroppable: {
         const {
            element: n
         } = t, {
            id: r
         } = n, l = new _r(e.droppable.containers);
         return l.set(r, n), {
            ...e,
            droppable: {
               ...e.droppable,
               containers: l
            }
         }
      }
      case ee.SetDroppableDisabled: {
         const {
            id: n,
            key: r,
            disabled: l
         } = t, o = e.droppable.containers.get(n);
         if (!o || r !== o.key) return e;
         const i = new _r(e.droppable.containers);
         return i.set(n, {
            ...o,
            disabled: l
         }), {
            ...e,
            droppable: {
               ...e.droppable,
               containers: i
            }
         }
      }
      case ee.UnregisterDroppable: {
         const {
            id: n,
            key: r
         } = t, l = e.droppable.containers.get(n);
         if (!l || r !== l.key) return e;
         const o = new _r(e.droppable.containers);
         return o.delete(n), {
            ...e,
            droppable: {
               ...e.droppable,
               containers: o
            }
         }
      }
      default:
         return e
   }
}

function fg(e) {
   let {
      disabled: t
   } = e;
   const {
      active: n,
      activatorEvent: r,
      draggableNodes: l
   } = g.useContext(rl), o = ao(r), i = ao(n == null ? void 0 : n.id);
   return g.useEffect(() => {
      if (!t && !r && o && i != null) {
         if (!hs(o) || document.activeElement === o.target) return;
         const u = l.get(i);
         if (!u) return;
         const {
            activatorNode: s,
            node: a
         } = u;
         if (!s.current && !a.current) return;
         requestAnimationFrame(() => {
            for (const p of [s.current, a.current]) {
               if (!p) continue;
               const d = sm(p);
               if (d) {
                  d.focus();
                  break
               }
            }
         })
      }
   }, [r, t, l, i, o]), null
}

function Hd(e, t) {
   let {
      transform: n,
      ...r
   } = t;
   return e != null && e.length ? e.reduce((l, o) => o({
      transform: l,
      ...r
   }), n) : n
}

function dg(e) {
   return g.useMemo(() => ({
      draggable: {
         ...Fl.draggable,
         ...e == null ? void 0 : e.draggable
      },
      droppable: {
         ...Fl.droppable,
         ...e == null ? void 0 : e.droppable
      },
      dragOverlay: {
         ...Fl.dragOverlay,
         ...e == null ? void 0 : e.dragOverlay
      }
   }), [e == null ? void 0 : e.draggable, e == null ? void 0 : e.droppable, e == null ? void 0 : e.dragOverlay])
}

function pg(e) {
   let {
      activeNode: t,
      measure: n,
      initialRect: r,
      config: l = !0
   } = e;
   const o = g.useRef(!1),
      {
         x: i,
         y: u
      } = typeof l == "boolean" ? {
         x: l,
         y: l
      } : l;
   St(() => {
      if (!i && !u || !t) {
         o.current = !1;
         return
      }
      if (o.current || !r) return;
      const a = t == null ? void 0 : t.node.current;
      if (!a || a.isConnected === !1) return;
      const p = n(a),
         d = Pd(p, r);
      if (i || (d.x = 0), u || (d.y = 0), o.current = !0, Math.abs(d.x) > 0 || Math.abs(d.y) > 0) {
         const v = Td(a);
         v && v.scrollBy({
            top: d.y,
            left: d.x
         })
      }
   }, [t, i, u, r, n])
}
const $o = g.createContext({
   ...tt,
   scaleX: 1,
   scaleY: 1
});
var Tt;
(function (e) {
   e[e.Uninitialized = 0] = "Uninitialized", e[e.Initializing = 1] = "Initializing", e[e.Initialized = 2] = "Initialized"
})(Tt || (Tt = {}));
const hg = g.memo(function (t) {
      var n, r, l, o;
      let {
         id: i,
         accessibility: u,
         autoScroll: s = !0,
         children: a,
         sensors: p = ig,
         collisionDetection: d = km,
         measuring: v,
         modifiers: m,
         ...w
      } = t;
      const y = g.useReducer(cg, void 0, ag),
         [D, f] = y,
         [c, h] = hm(),
         [S, x] = g.useState(Tt.Uninitialized),
         N = S === Tt.Initialized,
         {
            draggable: {
               active: E,
               nodes: C,
               translate: z
            },
            droppable: {
               containers: T
            }
         } = D,
         I = E != null ? C.get(E) : null,
         he = g.useRef({
            initial: null,
            translated: null
         }),
         ve = g.useMemo(() => {
            var ae;
            return E != null ? {
               id: E,
               data: (ae = I == null ? void 0 : I.data) != null ? ae : ug,
               rect: he
            } : null
         }, [E, I]),
         Qe = g.useRef(null),
         [ll, pn] = g.useState(null),
         [De, _] = g.useState(null),
         O = Kr(w, Object.values(w)),
         L = Fo("DndDescribedBy", i),
         H = g.useMemo(() => T.getEnabled(), [T]),
         U = dg(v),
         {
            droppableRects: Ke,
            measureDroppableContainers: Ie,
            measuringScheduled: hn
         } = Gm(H, {
            dragging: N,
            dependencies: [z.x, z.y],
            config: U.droppable
         }),
         q = Ym(C, E),
         Gt = g.useMemo(() => De ? fo(De) : null, [De]),
         Ss = rp(),
         xs = Zm(q, U.draggable.measure);
      pg({
         activeNode: E != null ? C.get(E) : null,
         config: Ss.layoutShiftCompensation,
         initialRect: xs,
         measure: U.draggable.measure
      });
      const Ye = Xa(q, U.draggable.measure, xs),
         Uo = Xa(q ? q.parentElement : null),
         Zt = g.useRef({
            activatorEvent: null,
            active: null,
            activeNode: q,
            collisionRect: null,
            collisions: null,
            droppableRects: Ke,
            draggableNodes: C,
            draggingNode: null,
            draggingNodeRect: null,
            droppableContainers: T,
            over: null,
            scrollableAncestors: [],
            scrollAdjustedTranslate: null
         }),
         ks = T.getNodeFor((n = Zt.current.over) == null ? void 0 : n.id),
         Jt = og({
            measure: U.dragOverlay.measure
         }),
         ol = (r = Jt.nodeRef.current) != null ? r : q,
         vn = N ? (l = Jt.rect) != null ? l : Ye : null,
         Es = !!(Jt.nodeRef.current && Jt.rect),
         Cs = bm(Es ? null : Ye),
         Bo = Ud(ol ? Se(ol) : null),
         kt = eg(N ? ks ?? q : null),
         il = lg(kt),
         ul = Hd(m, {
            transform: {
               x: z.x - Cs.x,
               y: z.y - Cs.y,
               scaleX: 1,
               scaleY: 1
            },
            activatorEvent: De,
            active: ve,
            activeNodeRect: Ye,
            containerNodeRect: Uo,
            draggingNodeRect: vn,
            over: Zt.current.over,
            overlayNodeRect: Jt.rect,
            scrollableAncestors: kt,
            scrollableAncestorRects: il,
            windowRect: Bo
         }),
         Ns = Gt ? Un(Gt, z) : null,
         Ds = tg(kt),
         Zd = Za(Ds),
         Jd = Za(Ds, [Ye]),
         mn = Un(ul, Zd),
         gn = vn ? Nm(vn, ul) : null,
         er = ve && gn ? d({
            active: ve,
            collisionRect: gn,
            droppableRects: Ke,
            droppableContainers: H,
            pointerCoordinates: Ns
         }) : null,
         _s = Sm(er, "id"),
         [Et, Ps] = g.useState(null),
         qd = Es ? ul : Un(ul, Jd),
         bd = Em(qd, (o = Et == null ? void 0 : Et.rect) != null ? o : null, Ye),
         Vo = g.useRef(null),
         Rs = g.useCallback((ae, _e) => {
            let {
               sensor: Pe,
               options: Ct
            } = _e;
            if (Qe.current == null) return;
            const Fe = C.get(Qe.current);
            if (!Fe) return;
            const Re = ae.nativeEvent,
               nt = new Pe({
                  active: Qe.current,
                  activeNode: Fe,
                  event: Re,
                  options: Ct,
                  context: Zt,
                  onAbort(oe) {
                     if (!C.get(oe)) return;
                     const {
                        onDragAbort: rt
                     } = O.current, ct = {
                        id: oe
                     };
                     rt == null || rt(ct), c({
                        type: "onDragAbort",
                        event: ct
                     })
                  },
                  onPending(oe, Nt, rt, ct) {
                     if (!C.get(oe)) return;
                     const {
                        onDragPending: nr
                     } = O.current, Dt = {
                        id: oe,
                        constraint: Nt,
                        initialCoordinates: rt,
                        offset: ct
                     };
                     nr == null || nr(Dt), c({
                        type: "onDragPending",
                        event: Dt
                     })
                  },
                  onStart(oe) {
                     const Nt = Qe.current;
                     if (Nt == null) return;
                     const rt = C.get(Nt);
                     if (!rt) return;
                     const {
                        onDragStart: ct
                     } = O.current, tr = {
                        activatorEvent: Re,
                        active: {
                           id: Nt,
                           data: rt.data,
                           rect: he
                        }
                     };
                     Ln.unstable_batchedUpdates(() => {
                        ct == null || ct(tr), x(Tt.Initializing), f({
                           type: ee.DragStart,
                           initialCoordinates: oe,
                           active: Nt
                        }), c({
                           type: "onDragStart",
                           event: tr
                        }), pn(Vo.current), _(Re)
                     })
                  },
                  onMove(oe) {
                     f({
                        type: ee.DragMove,
                        coordinates: oe
                     })
                  },
                  onEnd: yn(ee.DragEnd),
                  onCancel: yn(ee.DragCancel)
               });
            Vo.current = nt;

            function yn(oe) {
               return async function () {
                  const {
                     active: rt,
                     collisions: ct,
                     over: tr,
                     scrollAdjustedTranslate: nr
                  } = Zt.current;
                  let Dt = null;
                  if (rt && nr) {
                     const {
                        cancelDrop: rr
                     } = O.current;
                     Dt = {
                        activatorEvent: Re,
                        active: rt,
                        collisions: ct,
                        delta: nr,
                        over: tr
                     }, oe === ee.DragEnd && typeof rr == "function" && await Promise.resolve(rr(Dt)) && (oe = ee.DragCancel)
                  }
                  Qe.current = null, Ln.unstable_batchedUpdates(() => {
                     f({
                        type: oe
                     }), x(Tt.Uninitialized), Ps(null), pn(null), _(null), Vo.current = null;
                     const rr = oe === ee.DragEnd ? "onDragEnd" : "onDragCancel";
                     if (Dt) {
                        const Wo = O.current[rr];
                        Wo == null || Wo(Dt), c({
                           type: rr,
                           event: Dt
                        })
                     }
                  })
               }
            }
         }, [C]),
         ep = g.useCallback((ae, _e) => (Pe, Ct) => {
            const Fe = Pe.nativeEvent,
               Re = C.get(Ct);
            if (Qe.current !== null || !Re || Fe.dndKit || Fe.defaultPrevented) return;
            const nt = {
               active: Re
            };
            ae(Pe, _e.options, nt) === !0 && (Fe.dndKit = {
               capturedBy: _e.sensor
            }, Qe.current = Ct, Rs(Pe, _e))
         }, [C, Rs]),
         Ts = Xm(p, ep);
      ng(p), St(() => {
         Ye && S === Tt.Initializing && x(Tt.Initialized)
      }, [Ye, S]), g.useEffect(() => {
         const {
            onDragMove: ae
         } = O.current, {
            active: _e,
            activatorEvent: Pe,
            collisions: Ct,
            over: Fe
         } = Zt.current;
         if (!_e || !Pe) return;
         const Re = {
            active: _e,
            activatorEvent: Pe,
            collisions: Ct,
            delta: {
               x: mn.x,
               y: mn.y
            },
            over: Fe
         };
         Ln.unstable_batchedUpdates(() => {
            ae == null || ae(Re), c({
               type: "onDragMove",
               event: Re
            })
         })
      }, [mn.x, mn.y]), g.useEffect(() => {
         const {
            active: ae,
            activatorEvent: _e,
            collisions: Pe,
            droppableContainers: Ct,
            scrollAdjustedTranslate: Fe
         } = Zt.current;
         if (!ae || Qe.current == null || !_e || !Fe) return;
         const {
            onDragOver: Re
         } = O.current, nt = Ct.get(_s), yn = nt && nt.rect.current ? {
            id: nt.id,
            rect: nt.rect.current,
            data: nt.data,
            disabled: nt.disabled
         } : null, oe = {
            active: ae,
            activatorEvent: _e,
            collisions: Pe,
            delta: {
               x: Fe.x,
               y: Fe.y
            },
            over: yn
         };
         Ln.unstable_batchedUpdates(() => {
            Ps(yn), Re == null || Re(oe), c({
               type: "onDragOver",
               event: oe
            })
         })
      }, [_s]), St(() => {
         Zt.current = {
            activatorEvent: De,
            active: ve,
            activeNode: q,
            collisionRect: gn,
            collisions: er,
            droppableRects: Ke,
            draggableNodes: C,
            draggingNode: ol,
            draggingNodeRect: vn,
            droppableContainers: T,
            over: Et,
            scrollableAncestors: kt,
            scrollAdjustedTranslate: mn
         }, he.current = {
            initial: vn,
            translated: gn
         }
      }, [ve, q, er, gn, C, ol, vn, Ke, T, Et, kt, mn]), Hm({
         ...Ss,
         delta: z,
         draggingRect: gn,
         pointerCoordinates: Ns,
         scrollableAncestors: kt,
         scrollableAncestorRects: il
      });
      const tp = g.useMemo(() => ({
            active: ve,
            activeNode: q,
            activeNodeRect: Ye,
            activatorEvent: De,
            collisions: er,
            containerNodeRect: Uo,
            dragOverlay: Jt,
            draggableNodes: C,
            droppableContainers: T,
            droppableRects: Ke,
            over: Et,
            measureDroppableContainers: Ie,
            scrollableAncestors: kt,
            scrollableAncestorRects: il,
            measuringConfiguration: U,
            measuringScheduled: hn,
            windowRect: Bo
         }), [ve, q, Ye, De, er, Uo, Jt, C, T, Ke, Et, Ie, kt, il, U, hn, Bo]),
         np = g.useMemo(() => ({
            activatorEvent: De,
            activators: Ts,
            active: ve,
            activeNodeRect: Ye,
            ariaDescribedById: {
               draggable: L
            },
            dispatch: f,
            draggableNodes: C,
            over: Et,
            measureDroppableContainers: Ie
         }), [De, Ts, ve, Ye, f, L, C, Et, Ie]);
      return F.createElement(_d.Provider, {
         value: h
      }, F.createElement(rl.Provider, {
         value: np
      }, F.createElement(Wd.Provider, {
         value: tp
      }, F.createElement($o.Provider, {
         value: bd
      }, a)), F.createElement(fg, {
         disabled: (u == null ? void 0 : u.restoreFocus) === !1
      })), F.createElement(gm, {
         ...u,
         hiddenTextDescribedById: L
      }));

      function rp() {
         const ae = (ll == null ? void 0 : ll.autoScrollEnabled) === !1,
            _e = typeof s == "object" ? s.enabled === !1 : s === !1,
            Pe = N && !ae && !_e;
         return typeof s == "object" ? {
            ...s,
            enabled: Pe
         } : {
            enabled: Pe
         }
      }
   }),
   vg = g.createContext(null),
   qa = "button",
   mg = "Draggable";

function gg(e) {
   let {
      id: t,
      data: n,
      disabled: r = !1,
      attributes: l
   } = e;
   const o = Fo(mg),
      {
         activators: i,
         activatorEvent: u,
         active: s,
         activeNodeRect: a,
         ariaDescribedById: p,
         draggableNodes: d,
         over: v
      } = g.useContext(rl),
      {
         role: m = qa,
         roleDescription: w = "draggable",
         tabIndex: y = 0
      } = l ?? {},
      D = (s == null ? void 0 : s.id) === t,
      f = g.useContext(D ? $o : vg),
      [c, h] = so(),
      [S, x] = so(),
      N = rg(i, t),
      E = Kr(n);
   St(() => (d.set(t, {
      id: t,
      key: o,
      node: c,
      activatorNode: S,
      data: E
   }), () => {
      const z = d.get(t);
      z && z.key === o && d.delete(t)
   }), [d, t]);
   const C = g.useMemo(() => ({
      role: m,
      tabIndex: y,
      "aria-disabled": r,
      "aria-pressed": D && m === qa ? !0 : void 0,
      "aria-roledescription": w,
      "aria-describedby": p.draggable
   }), [r, m, y, D, w, p.draggable]);
   return {
      active: s,
      activatorEvent: u,
      activeNodeRect: a,
      attributes: C,
      isDragging: D,
      listeners: r ? void 0 : N,
      node: c,
      over: v,
      setNodeRef: h,
      setActivatorNodeRef: x,
      transform: f
   }
}

function yg() {
   return g.useContext(Wd)
}
const wg = "Droppable",
   Sg = {
      timeout: 25
   };

function xg(e) {
   let {
      data: t,
      disabled: n = !1,
      id: r,
      resizeObserverConfig: l
   } = e;
   const o = Fo(wg),
      {
         active: i,
         dispatch: u,
         over: s,
         measureDroppableContainers: a
      } = g.useContext(rl),
      p = g.useRef({
         disabled: n
      }),
      d = g.useRef(!1),
      v = g.useRef(null),
      m = g.useRef(null),
      {
         disabled: w,
         updateMeasurementsFor: y,
         timeout: D
      } = {
         ...Sg,
         ...l
      },
      f = Kr(y ?? r),
      c = g.useCallback(() => {
         if (!d.current) {
            d.current = !0;
            return
         }
         m.current != null && clearTimeout(m.current), m.current = setTimeout(() => {
            a(Array.isArray(f.current) ? f.current : [f.current]), m.current = null
         }, D)
      }, [D]),
      h = Ao({
         callback: c,
         disabled: w || !i
      }),
      S = g.useCallback((C, z) => {
         h && (z && (h.unobserve(z), d.current = !1), C && h.observe(C))
      }, [h]),
      [x, N] = so(S),
      E = Kr(t);
   return g.useEffect(() => {
      !h || !x.current || (h.disconnect(), d.current = !1, h.observe(x.current))
   }, [x, h]), g.useEffect(() => (u({
      type: ee.RegisterDroppable,
      element: {
         id: r,
         key: o,
         disabled: n,
         node: x,
         rect: v,
         data: E
      }
   }), () => u({
      type: ee.UnregisterDroppable,
      key: o,
      id: r
   })), [r]), g.useEffect(() => {
      n !== p.current.disabled && (u({
         type: ee.SetDroppableDisabled,
         id: r,
         key: o,
         disabled: n
      }), p.current.disabled = n)
   }, [r, o, n, u]), {
      active: i,
      rect: v,
      isOver: (s == null ? void 0 : s.id) === r,
      node: x,
      over: s,
      setNodeRef: N
   }
}

function kg(e) {
   let {
      animation: t,
      children: n
   } = e;
   const [r, l] = g.useState(null), [o, i] = g.useState(null), u = ao(n);
   return !n && !r && u && l(u), St(() => {
      if (!o) return;
      const s = r == null ? void 0 : r.key,
         a = r == null ? void 0 : r.props.id;
      if (s == null || a == null) {
         l(null);
         return
      }
      Promise.resolve(t(a, o)).then(() => {
         l(null)
      })
   }, [t, r, o]), F.createElement(F.Fragment, null, n, r ? g.cloneElement(r, {
      ref: i
   }) : null)
}
const Eg = {
   x: 0,
   y: 0,
   scaleX: 1,
   scaleY: 1
};

function Cg(e) {
   let {
      children: t
   } = e;
   return F.createElement(rl.Provider, {
      value: Vd
   }, F.createElement($o.Provider, {
      value: Eg
   }, t))
}
const Ng = {
      position: "fixed",
      touchAction: "none"
   },
   Dg = e => hs(e) ? "transform 250ms ease" : void 0,
   _g = g.forwardRef((e, t) => {
      let {
         as: n,
         activatorEvent: r,
         adjustScale: l,
         children: o,
         className: i,
         rect: u,
         style: s,
         transform: a,
         transition: p = Dg
      } = e;
      if (!u) return null;
      const d = l ? a : {
            ...a,
            scaleX: 1,
            scaleY: 1
         },
         v = {
            ...Ng,
            width: u.width,
            height: u.height,
            top: u.top,
            left: u.left,
            transform: Yr.Transform.toString(d),
            transformOrigin: l && r ? ym(r, u) : void 0,
            transition: typeof p == "function" ? p(r) : p,
            ...s
         };
      return F.createElement(n, {
         className: i,
         style: v,
         ref: t
      }, o)
   }),
   Pg = e => t => {
      let {
         active: n,
         dragOverlay: r
      } = t;
      const l = {},
         {
            styles: o,
            className: i
         } = e;
      if (o != null && o.active)
         for (const [u, s] of Object.entries(o.active)) s !== void 0 && (l[u] = n.node.style.getPropertyValue(u), n.node.style.setProperty(u, s));
      if (o != null && o.dragOverlay)
         for (const [u, s] of Object.entries(o.dragOverlay)) s !== void 0 && r.node.style.setProperty(u, s);
      return i != null && i.active && n.node.classList.add(i.active), i != null && i.dragOverlay && r.node.classList.add(i.dragOverlay),
         function () {
            for (const [s, a] of Object.entries(l)) n.node.style.setProperty(s, a);
            i != null && i.active && n.node.classList.remove(i.active)
         }
   },
   Rg = e => {
      let {
         transform: {
            initial: t,
            final: n
         }
      } = e;
      return [{
         transform: Yr.Transform.toString(t)
      }, {
         transform: Yr.Transform.toString(n)
      }]
   },
   Tg = {
      duration: 250,
      easing: "ease",
      keyframes: Rg,
      sideEffects: Pg({
         styles: {
            active: {
               opacity: "0"
            }
         }
      })
   };

function Og(e) {
   let {
      config: t,
      draggableNodes: n,
      droppableContainers: r,
      measuringConfiguration: l
   } = e;
   return Io((o, i) => {
      if (t === null) return;
      const u = n.get(o);
      if (!u) return;
      const s = u.node.current;
      if (!s) return;
      const a = Bd(i);
      if (!a) return;
      const {
         transform: p
      } = Se(i).getComputedStyle(i), d = Rd(p);
      if (!d) return;
      const v = typeof t == "function" ? t : zg(t);
      return Id(s, l.draggable.measure), v({
         active: {
            id: o,
            data: u.data,
            node: s,
            rect: l.draggable.measure(s)
         },
         draggableNodes: n,
         dragOverlay: {
            node: i,
            rect: l.dragOverlay.measure(a)
         },
         droppableContainers: r,
         measuringConfiguration: l,
         transform: d
      })
   })
}

function zg(e) {
   const {
      duration: t,
      easing: n,
      sideEffects: r,
      keyframes: l
   } = {
      ...Tg,
      ...e
   };
   return o => {
      let {
         active: i,
         dragOverlay: u,
         transform: s,
         ...a
      } = o;
      if (!t) return;
      const p = {
            x: u.rect.left - i.rect.left,
            y: u.rect.top - i.rect.top
         },
         d = {
            scaleX: s.scaleX !== 1 ? i.rect.width * s.scaleX / u.rect.width : 1,
            scaleY: s.scaleY !== 1 ? i.rect.height * s.scaleY / u.rect.height : 1
         },
         v = {
            x: s.x - p.x,
            y: s.y - p.y,
            ...d
         },
         m = l({
            ...a,
            active: i,
            dragOverlay: u,
            transform: {
               initial: s,
               final: v
            }
         }),
         [w] = m,
         y = m[m.length - 1];
      if (JSON.stringify(w) === JSON.stringify(y)) return;
      const D = r == null ? void 0 : r({
            active: i,
            dragOverlay: u,
            ...a
         }),
         f = u.node.animate(m, {
            duration: t,
            easing: n,
            fill: "forwards"
         });
      return new Promise(c => {
         f.onfinish = () => {
            D == null || D(), c()
         }
      })
   }
}
let ba = 0;

function Lg(e) {
   return g.useMemo(() => {
      if (e != null) return ba++, ba
   }, [e])
}
const Mg = F.memo(e => {
   let {
      adjustScale: t = !1,
      children: n,
      dropAnimation: r,
      style: l,
      transition: o,
      modifiers: i,
      wrapperElement: u = "div",
      className: s,
      zIndex: a = 999
   } = e;
   const {
      activatorEvent: p,
      active: d,
      activeNodeRect: v,
      containerNodeRect: m,
      draggableNodes: w,
      droppableContainers: y,
      dragOverlay: D,
      over: f,
      measuringConfiguration: c,
      scrollableAncestors: h,
      scrollableAncestorRects: S,
      windowRect: x
   } = yg(), N = g.useContext($o), E = Lg(d == null ? void 0 : d.id), C = Hd(i, {
      activatorEvent: p,
      active: d,
      activeNodeRect: v,
      containerNodeRect: m,
      draggingNodeRect: D.rect,
      over: f,
      overlayNodeRect: D.rect,
      scrollableAncestors: h,
      scrollableAncestorRects: S,
      transform: N,
      windowRect: x
   }), z = ys(v), T = Og({
      config: r,
      draggableNodes: w,
      droppableContainers: y,
      measuringConfiguration: c
   }), I = z ? D.setRef : void 0;
   return F.createElement(Cg, null, F.createElement(kg, {
      animation: T
   }, d && E ? F.createElement(_g, {
      key: E,
      id: d.id,
      ref: I,
      as: u,
      activatorEvent: p,
      adjustScale: t,
      className: s,
      transition: o,
      rect: z,
      style: {
         zIndex: a,
         ...l
      },
      transform: C
   }, n) : null))
});

function ws({
   id: e,
   item: t,
   onClick: n
}) {
   const {
      attributes: r,
      listeners: l,
      setNodeRef: o,
      transform: i,
      isDragging: u
   } = gg({
      id: e,
      data: t
   }), [s, a] = g.useState(!1), [p, d] = g.useState({
      x: 0,
      y: 0
   }), v = D => {
      d({
         x: D.clientX,
         y: D.clientY
      })
   }, m = D => {
      D.preventDefault(), n == null || n()
   }, w = t.durability && t.days;
   let y = null;
   if (w) {
      const D = 86400 * (t.days ?? 0),
         f = (D - (t.durability ?? 0)) / D,
         c = parseInt((f * 100).toString()),
         h = S => {
            let x = "#5AF483";
            return S >= 100 && (x = "transparent"), S >= 51 && S <= 75 && (x = "#fcc458"), S >= 26 && S <= 50 && (x = "#fc8a58"), S <= 25 && (x = "#fc5858"), x
         };
      y = R.jsx("div", {
         className: "absolute bottom-[.7vw] h-[.1vw] w-[4.5vw] rounded-full bg-white/5",
         children: R.jsx("div", {
            style: {
               width: `${c==1?"100":c}%`,
               background: c == 1 ? "#61FF3A" : h(c)
            },
            className: "h-full rounded-full"
         })
      })
   }
   return R.jsxs(R.Fragment, {
      children: [R.jsxs("button", {
         ref: o,
         ...l,
         ...r,
         onClick: n,
         onMouseEnter: () => a(!0),
         onMouseLeave: () => a(!1),
         onMouseMove: v,
         onContextMenu: m,
         className: `relative z-50 flex h-[5.5vw] w-[5.5vw] cursor-grab items-center justify-center rounded-[.3vw] ${u&&"slot"}`,
         style: {
            transform: i ? `translate3d(${i.x}px, ${i.y}px, 0)` : void 0
         },
         children: [y, R.jsxs("h1", {
            className: "absolute left-[.5vw] top-[.4vw] text-[.6vw] leading-none text-white",
            children: [t.amount, "x"]
         }), R.jsx("img", {
            className: "h-[3vw]",
            src: t.image,
            alt: t.name
         }), R.jsxs("h1", {
            className: "absolute right-[.5vw] top-[.4vw] text-[.6vw] leading-none text-[#FFFFFFBF]",
            children: [t.peso, "kg"]
         })]
      }), s && R.jsxs("div", {
         className: "fixed z-[9999] overflow-visible rounded-[.3vw] border border-white/5 bg-white/10 px-[.6vw] py-[.6vw] text-white",
         style: {
            left: p.x + 22,
            top: p.y - 18,
            pointerEvents: "none"
         },
         children: [R.jsxs("div", {
            className: "flex items-center gap-[.3vw]",
            children: [R.jsxs("h1", {
               className: "font-grotesk text-[.7vw] text-white opacity-75",
               children: [t.amount, " unidades"]
            }), R.jsx("h1", {
               className: "text-[.7vw] text-white",
               children: "/"
            }), R.jsxs("h1", {
               className: "font-grotesk text-[.7vw] text-white opacity-75",
               children: [t.peso, "kg"]
            })]
         }), R.jsx("h1", {
            className: "text-[.8vw] font-bold uppercase text-white",
            children: t.name
         }), R.jsxs("h1", {
            className: "text-[.7vw] text-white opacity-50",
            children: ["Tipo: ", t.type]
         }), R.jsx("h1", {
            className: "max-w-[11vw] text-[.7vw] text-white opacity-50",
            children: t.description
         })]
      })]
   })
}

function Qd({
   id: e,
   children: t
}) {
   const {
      setNodeRef: n,
      isOver: r
   } = xg({
      id: e
   });
   return R.jsx("div", {
      ref: n,
      className: `bg-slot relative h-[5.4vw] w-[5.4vw] rounded-[.36vw] border border-[#FFFFFF26] ${r?"bg-hot":""}`,
      children: t
   })
}
var Kd = {
      color: void 0,
      size: void 0,
      className: void 0,
      style: void 0,
      attr: void 0
   },
   ec = F.createContext && F.createContext(Kd),
   jg = ["attr", "size", "title"];

function Ig(e, t) {
   if (e == null) return {};
   var n = Fg(e, t),
      r, l;
   if (Object.getOwnPropertySymbols) {
      var o = Object.getOwnPropertySymbols(e);
      for (l = 0; l < o.length; l++) r = o[l], !(t.indexOf(r) >= 0) && Object.prototype.propertyIsEnumerable.call(e, r) && (n[r] = e[r])
   }
   return n
}

function Fg(e, t) {
   if (e == null) return {};
   var n = {};
   for (var r in e)
      if (Object.prototype.hasOwnProperty.call(e, r)) {
         if (t.indexOf(r) >= 0) continue;
         n[r] = e[r]
      } return n
}

function vo() {
   return vo = Object.assign ? Object.assign.bind() : function (e) {
      for (var t = 1; t < arguments.length; t++) {
         var n = arguments[t];
         for (var r in n) Object.prototype.hasOwnProperty.call(n, r) && (e[r] = n[r])
      }
      return e
   }, vo.apply(this, arguments)
}

function tc(e, t) {
   var n = Object.keys(e);
   if (Object.getOwnPropertySymbols) {
      var r = Object.getOwnPropertySymbols(e);
      t && (r = r.filter(function (l) {
         return Object.getOwnPropertyDescriptor(e, l).enumerable
      })), n.push.apply(n, r)
   }
   return n
}

function mo(e) {
   for (var t = 1; t < arguments.length; t++) {
      var n = arguments[t] != null ? arguments[t] : {};
      t % 2 ? tc(Object(n), !0).forEach(function (r) {
         Ag(e, r, n[r])
      }) : Object.getOwnPropertyDescriptors ? Object.defineProperties(e, Object.getOwnPropertyDescriptors(n)) : tc(Object(n)).forEach(function (r) {
         Object.defineProperty(e, r, Object.getOwnPropertyDescriptor(n, r))
      })
   }
   return e
}

function Ag(e, t, n) {
   return t = $g(t), t in e ? Object.defineProperty(e, t, {
      value: n,
      enumerable: !0,
      configurable: !0,
      writable: !0
   }) : e[t] = n, e
}

function $g(e) {
   var t = Ug(e, "string");
   return typeof t == "symbol" ? t : t + ""
}

function Ug(e, t) {
   if (typeof e != "object" || !e) return e;
   var n = e[Symbol.toPrimitive];
   if (n !== void 0) {
      var r = n.call(e, t);
      if (typeof r != "object") return r;
      throw new TypeError("@@toPrimitive must return a primitive value.")
   }
   return (t === "string" ? String : Number)(e)
}

function Yd(e) {
   return e && e.map((t, n) => F.createElement(t.tag, mo({
      key: n
   }, t.attr), Yd(t.child)))
}

function Bg(e) {
   return t => F.createElement(Vg, vo({
      attr: mo({}, e.attr)
   }, t), Yd(e.child))
}

function Vg(e) {
   var t = n => {
      var {
         attr: r,
         size: l,
         title: o
      } = e, i = Ig(e, jg), u = l || n.size || "1em", s;
      return n.className && (s = n.className), e.className && (s = (s ? s + " " : "") + e.className), F.createElement("svg", vo({
         stroke: "currentColor",
         fill: "currentColor",
         strokeWidth: "0"
      }, n.attr, r, i, {
         className: s,
         style: mo(mo({
            color: e.color || n.color
         }, n.style), e.style),
         height: u,
         width: u,
         xmlns: "http://www.w3.org/2000/svg"
      }), o && F.createElement("title", null, o), e.children)
   };
   return ec !== void 0 ? F.createElement(ec.Consumer, null, n => t(n)) : t(Kd)
}

function Wg(e) {
   return Bg({
      attr: {
         viewBox: "0 0 24 24"
      },
      child: [{
         tag: "path",
         attr: {
            d: "M6 9V7.25C6 3.845 8.503 1 12 1s6 2.845 6 6.25V9h.5a2.5 2.5 0 0 1 2.5 2.5v8a2.5 2.5 0 0 1-2.5 2.5h-13A2.5 2.5 0 0 1 3 19.5v-8A2.5 2.5 0 0 1 5.5 9Zm-1.5 2.5v8a1 1 0 0 0 1 1h13a1 1 0 0 0 1-1v-8a1 1 0 0 0-1-1h-13a1 1 0 0 0-1 1Zm3-4.25V9h9V7.25c0-2.67-1.922-4.75-4.5-4.75-2.578 0-4.5 2.08-4.5 4.75Z"
         },
         child: []
      }]
   })(e)
}
class jt {
   constructor(t, n, r) {
      lt(this, "eventName");
      lt(this, "data");
      lt(this, "mockData");
      this.eventName = t, this.data = n, this.mockData = r
   }
   static async create(t, n, r) {
      return new jt(t, n, r).execute()
   }
   async execute() {
      const t = {
         method: "post",
         headers: {
            "Content-Type": "application/json; charset=UTF-8"
         },
         body: JSON.stringify(this.data)
      };
      if (Pr() && this.mockData) return this.mockData;
      const n = window.GetParentResourceName ? window.GetParentResourceName() : "nui-frame-app";
      try {
         return await (await fetch(`https://${n}/${this.eventName}`, t)).json()
      } catch (r) {
         throw console.error("Error:", r), r
      }
   }
}

function Hg({
   quantity: e
}) {
   const {
      item: t
   } = kc(), {
      current: n
   } = xu(), {
      current: r
   } = Sc();
   return R.jsxs("div", {
      className: "flex w-[34.66vw] flex-col items-start gap-[.5vw]",
      children: [R.jsxs("div", {
         className: "flex w-full items-center justify-between",
         children: [R.jsx("h1", {
            className: "text-[.8vw] font-bold text-white",
            children: "Mochila"
         }), R.jsxs("p", {
            className: "text-[.8vw] text-white",
            children: [n.weight, R.jsxs("span", {
               className: "text-[.7vw] text-primary",
               children: ["/", n.maxWeight, "kg"]
            })]
         })]
      }), R.jsxs("div", {
         className: "flex h-[28.3vw] w-full flex-wrap gap-[.28vw] overflow-auto",
         children: [Array.from({
            length: r.slot
         }).map((l, o) => {
            const i = (o + 1).toString();
            return R.jsx(Qd, {
               id: i,
               children: t[i] && R.jsx(ws, {
                  id: i,
                  item: t[i],
                  onClick: () => jt.create("useItem", {
                     slot: i,
                     amount: e
                  })
               })
            }, i)
         }), !r.show && R.jsxs("div", {
            className: "relative flex w-[33.9vw] flex-wrap gap-[.28vw]",
            children: [R.jsxs("div", {
               className: "absolute flex h-full w-full flex-col items-center justify-start gap-[.5vw] pt-[3vw]",
               children: [R.jsx(Wg, {
                  className: "text-[2vw] text-white"
               }), R.jsxs("h1", {
                  className: "text-center text-[.8vw] text-[#FFFFFFA6]",
                  children: ["Desbloqueie slots adicionais ", R.jsx("br", {}), " com nosso pacote VIP"]
               })]
            }), Array.from({
               length: 30
            }).map(() => R.jsx("div", {
               className: "bg-slot relative h-[5.4vw] w-[5.4vw] rounded-[.36vw] border-[.1vw] border-dashed border-[#FFFFFF26] opacity-50"
            }))]
         })]
      })]
   })
}

function Qg({
   children: e,
   draggedItem: t,
   onDragStart: n,
   onDragEnd: r
}) {
   return R.jsxs(hg, {
      onDragStart: n,
      onDragEnd: r,
      children: [e, R.jsx(Mg, {
         children: t && R.jsx(ws, {
            id: t.id,
            item: t
         })
      })]
   })
}

function Kg() {
   const {
      item: e
   } = xc(), {
      current: t
   } = xu();
   return R.jsxs("div", {
      className: "flex w-[34.66vw] flex-col items-start gap-[.5vw]",
      children: [R.jsxs("div", {
         className: "flex w-full items-center justify-between",
         children: [R.jsx("h1", {
            className: "text-[.8vw] font-bold text-white",
            children: "Maleta"
         }), R.jsxs("p", {
            className: "text-[.8vw] text-white",
            children: [t.suitCaseWeight, R.jsxs("span", {
               className: "text-[.7vw] text-primary",
               children: ["/", t.suitCaseMaxWeight, "kg"]
            })]
         })]
      }), R.jsx("div", {
         className: "flex h-[28.3vw] w-full flex-wrap gap-[.28vw] overflow-auto",
         children: Array.from({
            length: 6
         }).map((n, r) => {
            const l = `briefcase_${r+1}`,
               o = (r + 1).toString();
            return R.jsx(Qd, {
               id: l,
               children: e && e[o] && R.jsx(ws, {
                  id: l,
                  item: {
                     ...e[o],
                     id: l
                  }
               })
            }, l)
         })
      })]
   })
}

function Yg({
   quantity: e,
   setQuantity: t
}) {
   return R.jsx("input", {
      type: "number",
      placeholder: "QUANTIDADE",
      value: e,
      onChange: n => t(n.target.value === "" ? "" : Number(n.target.value)),
      className: "slot h-[2.5vw] w-[10vw] rounded-[.3vw] text-center text-[.8vw] text-white placeholder:text-white/20"
   })
}

function Xg() {
   const [e, t] = g.useState(null), [n, r] = g.useState(1), [l, o] = g.useState(!1);
   g.useEffect(() => {
      const p = m => {
            m.key === "Shift" && (o(!0), r(e ? e.amount : 1))
         },
         d = m => {
            m.key === "Shift" && o(!1)
         },
         v = m => {
            m.preventDefault(), r(e ? e.amount : 1)
         };
      return window.addEventListener("keydown", p), window.addEventListener("keyup", d), window.addEventListener("contextmenu", v), () => {
         window.removeEventListener("keydown", p), window.removeEventListener("keyup", d), window.removeEventListener("contextmenu", v)
      }
   }, [e]);
   const i = p => p.startsWith("briefcase_"),
      u = p => p.startsWith("briefcase_") ? p.replace("briefcase_", "") : p,
      s = p => l || n === "" || n > p.amount ? p.amount : n,
      a = p => {
         const {
            active: d,
            over: v
         } = p;
         if (!v || !e) return;
         const m = d.id,
            w = v.id;
         if (console.log("DEBUG: Drag from", m, "to", w), m === w) return;
         const y = i(m),
            D = i(w);
         if (y && D) {
            const f = u(m),
               c = u(w);
            console.log("DEBUG: Moving within briefcase from", f, "to", c), jt.create("moveBriefcaseItem", {
               fromSlot: f,
               toSlot: c,
               amount: n === "" ? e.amount : n,
               item: e.item
            }).catch(h => {
               console.error("Failed to move briefcase item:", h)
            })
         } else if (!y && !D) console.log("DEBUG: Moving within inventory from", m, "to", w), jt.create("moveInventoryItem", {
            fromSlot: m,
            toSlot: w,
            amount: n === "" ? e.amount : n,
            item: e.item
         }).catch(f => {
            console.error("Failed to move inventory item:", f)
         });
         else if (!y && D) {
            const f = u(w),
               c = s(e);
            console.log("DEBUG: Moving from inventory", m, "to briefcase", f), jt.create("storeItem", {
               item: e.item,
               slot: m,
               target: f,
               amount: c
            }).catch(h => {
               console.error("Failed to store item:", h)
            })
         } else if (y && !D) {
            const f = u(m),
               c = s(e);
            console.log("DEBUG: Moving from briefcase", f, "to inventory", w), jt.create("takeItem", {
               item: e.item,
               slot: f,
               target: w,
               amount: c
            }).catch(h => {
               console.error("Failed to take item:", h)
            })
         }
         t(null)
      };
   return R.jsx(Qg, {
      draggedItem: e,
      onDragStart: p => {
         var d;
         return t((d = p.active.data) == null ? void 0 : d.current)
      },
      onDragEnd: a,
      children: R.jsx("main", {
         className: "relative flex h-screen w-screen items-center justify-center gap-[.5vw]",
         children: R.jsxs("div", {
            className: "flex items-center gap-[.5vw]",
            children: [R.jsx(Hg, {
               quantity: n
            }), R.jsx(Yg, {
               quantity: n,
               setQuantity: r
            }), R.jsx(Kg, {})]
         })
      })
   })
}
var mu = {},
   nc = Ln;
mu.createRoot = nc.createRoot, mu.hydrateRoot = nc.hydrateRoot;
const Xd = 200,
   Gg = e => ({
      opacity: e === "entered" ? 1 : 0,
      transition: `opacity ${Xd}ms ease`
   }),
   Zg = ({
      children: e,
      show: t = !1
   }) => {
      const [n, r] = g.useState("unmounted"), [, l] = g.useTransition();
      return g.useEffect(() => {
         l(t ? () => {
            r("entering"), setTimeout(() => r("entered"), 0)
         } : () => {
            r("exiting"), setTimeout(() => r("exited"), Xd)
         })
      }, [t]), g.useEffect(() => {
         n === "exited" && r("unmounted")
      }, [n]), n === "unmounted" ? null : R.jsx("div", {
         style: Gg(n),
         children: e
      })
   };

function Gd(e) {
   var t, n, r = "";
   if (typeof e == "string" || typeof e == "number") r += e;
   else if (typeof e == "object")
      if (Array.isArray(e)) {
         var l = e.length;
         for (t = 0; t < l; t++) e[t] && (n = Gd(e[t])) && (r && (r += " "), r += n)
      } else
         for (n in e) e[n] && (r && (r += " "), r += n);
   return r
}

function Jg() {
   for (var e, t, n = 0, r = "", l = arguments.length; n < l; n++)(e = arguments[n]) && (t = Gd(e)) && (r && (r += " "), r += t);
   return r
}
class qg {
   constructor(t, n) {
      lt(this, "event");
      lt(this, "savedHandler");
      this.event = t, this.savedHandler = g.useRef(n)
   }
   setHandler(t) {
      this.savedHandler.current = t
   }
   listen(t) {
      const n = r => {
         this.savedHandler.current(r)
      };
      return t.addEventListener(this.event, n), () => t.removeEventListener(this.event, n)
   }
}
const bg = (e, t, n = window) => {
   const r = g.useRef(new qg(e, t));
   g.useEffect(() => {
      r.current.setHandler(t)
   }, [t]), g.useEffect(() => r.current.listen(n), [e, n])
};
class ey {
   constructor(t, n) {
      lt(this, "action");
      lt(this, "savedHandler");
      this.action = t, this.savedHandler = g.useRef(_p), this.setHandler(n)
   }
   setHandler(t) {
      this.savedHandler.current = t
   }
   observe() {
      const t = n => {
         const {
            action: r,
            data: l
         } = n.data;
         r === this.action && this.savedHandler.current && (Pr() && console.log("Observed event:", n), this.savedHandler.current(l))
      };
      return window.addEventListener("message", t), () => window.removeEventListener("message", t)
   }
}
const Sn = (e, t) => {
      const n = g.useRef(new ey(e, t));
      g.useEffect(() => {
         n.current.setHandler(t)
      }, [t]), g.useEffect(() => n.current.observe(), [e])
   },
   ty = g.createContext(null),
   ny = ({
      children: e
   }) => {
      const [t, n] = g.useState(!1), {
         set: r
      } = kc(), {
         set: l
      } = xc(), {
         set: o
      } = xu(), {
         set: i
      } = Sc();
      return Sn("updateBackpack", r), Sn("updateDrop", l), Sn("setProfile", o), Sn("setInfo", i), Sn("setVisibility", n), Sn("setColor", u => {
         document.documentElement.style.setProperty("--main-color", u)
      }), bg("keydown", u => {
         t && ["Escape"].includes(u.code) && n(!1)
      }), g.useEffect(() => {
         !t && !Pr() && jt.create("removeFocus")
      }, [t]), R.jsx(ty.Provider, {
         value: {
            visible: t,
            setVisible: n
         },
         children: R.jsx(Zg, {
            show: t,
            children: R.jsx("div", {
               style: {
                  backgroundImage: "url('./bg.png')",
                  backgroundSize: "cover",
                  backgroundPosition: "center"
               },
               className: Jg("flex h-screen w-screen items-center justify-center", {
                  "": Pr()
               }),
               children: e
            })
         })
      })
   };
new Pp([{
   action: "setColor",
   data: "60, 142, 220"
}, {
   action: "setVisibility",
   data: !0
}, {
   action: "setProfile",
   data: {
      name: "Rafael Santos",
      id: 237,
      image: "",
      bank: 5e4,
      dollar: 2e4,
      weight: 25,
      maxWeight: 30,
      suitCaseWeight: 20,
      suitCaseMaxWeight: 100
   }
}, {
   action: "updateBackpack",
   data: {
      1: {
         id: "1",
         item: "weapon_pistol_mk2",
         peso: 53,
         name: "Maçã",
         amount: 2,
         durability: 15e3,
         days: 1,
         type: "usavel",
         description: "Você pode comer essa maçã, mas cuidado para não estar verde",
         image: "https://cdn.blacknetwork.com.br/black_inventory/apple.png"
      },
      2: {
         id: "2",
         item: "weapon_sniper_mk2",
         peso: 53,
         name: "Drone",
         amount: 2,
         type: "usavel",
         description: "Você pode comer essa maçã, mas cuidado para não estar verde",
         image: "https://cdn.blacknetwork.com.br/black_inventory/drone.png"
      }
   }
}, {
   action: "updateDrop",
   data: {
      1: {
         id: "1",
         item: "weapon_pistol",
         peso: 25,
         name: "Pistola",
         amount: 1,
         type: "arma",
         description: "Uma pistola comum",
         image: "https://cdn.blacknetwork.com.br/black_inventory/weapon_pistol.png"
      },
      2: {
         id: "2",
         item: "apple",
         peso: 5,
         name: "Maçã",
         amount: 3,
         type: "usavel",
         description: "Uma maçã vermelha",
         image: "https://cdn.blacknetwork.com.br/black_inventory/apple.png"
      },
      3: {
         id: "3",
         item: "water",
         peso: 2,
         name: "Água",
         amount: 5,
         type: "usavel",
         description: "Água mineral",
         image: "https://cdn.blacknetwork.com.br/black_inventory/water.png"
      }
   }
}, {
   action: "setInfo",
   data: {
      slot: 53,
      show: !0
   }
}]);
mu.createRoot(document.getElementById("root")).render(R.jsx(F.StrictMode, {
   children: R.jsx(ny, {
      children: R.jsx(Xg, {})
   })
}));