const Q0 = function () {
   const t = document.createElement("link").relList;
   if (t && t.supports && t.supports("modulepreload")) return;
   for (const o of document.querySelectorAll('link[rel="modulepreload"]')) r(o);
   new MutationObserver(o => {
      for (const i of o)
         if (i.type === "childList")
            for (const s of i.addedNodes) s.tagName === "LINK" && s.rel === "modulepreload" && r(s)
   }).observe(document, {
      childList: !0,
      subtree: !0
   });

   function n(o) {
      const i = {};
      return o.integrity && (i.integrity = o.integrity), o.referrerpolicy && (i.referrerPolicy = o.referrerpolicy), o.crossorigin === "use-credentials" ? i.credentials = "include" : o.crossorigin === "anonymous" ? i.credentials = "omit" : i.credentials = "same-origin", i
   }

   function r(o) {
      if (o.ep) return;
      o.ep = !0;
      const i = n(o);
      fetch(o.href, i)
   }
};
Q0();
var C = {
      exports: {}
   },
   H = {};
/**
 * @license React
 * react.production.min.js
 *
 * Copyright (c) Facebook, Inc. and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */
var To = Symbol.for("react.element"),
   Y0 = Symbol.for("react.portal"),
   K0 = Symbol.for("react.fragment"),
   X0 = Symbol.for("react.strict_mode"),
   Z0 = Symbol.for("react.profiler"),
   J0 = Symbol.for("react.provider"),
   q0 = Symbol.for("react.context"),
   eg = Symbol.for("react.forward_ref"),
   tg = Symbol.for("react.suspense"),
   ng = Symbol.for("react.memo"),
   rg = Symbol.for("react.lazy"),
   kc = Symbol.iterator;

function og(e) {
   return e === null || typeof e != "object" ? null : (e = kc && e[kc] || e["@@iterator"], typeof e == "function" ? e : null)
}
var Xd = {
      isMounted: function () {
         return !1
      },
      enqueueForceUpdate: function () {},
      enqueueReplaceState: function () {},
      enqueueSetState: function () {}
   },
   Zd = Object.assign,
   Jd = {};

function vr(e, t, n) {
   this.props = e, this.context = t, this.refs = Jd, this.updater = n || Xd
}
vr.prototype.isReactComponent = {};
vr.prototype.setState = function (e, t) {
   if (typeof e != "object" && typeof e != "function" && e != null) throw Error("setState(...): takes an object of state variables to update or a function which returns an object of state variables.");
   this.updater.enqueueSetState(this, e, t, "setState")
};
vr.prototype.forceUpdate = function (e) {
   this.updater.enqueueForceUpdate(this, e, "forceUpdate")
};

function qd() {}
qd.prototype = vr.prototype;

function Ka(e, t, n) {
   this.props = e, this.context = t, this.refs = Jd, this.updater = n || Xd
}
var Xa = Ka.prototype = new qd;
Xa.constructor = Ka;
Zd(Xa, vr.prototype);
Xa.isPureReactComponent = !0;
var Cc = Array.isArray,
   ep = Object.prototype.hasOwnProperty,
   Za = {
      current: null
   },
   tp = {
      key: !0,
      ref: !0,
      __self: !0,
      __source: !0
   };

function np(e, t, n) {
   var r, o = {},
      i = null,
      s = null;
   if (t != null)
      for (r in t.ref !== void 0 && (s = t.ref), t.key !== void 0 && (i = "" + t.key), t) ep.call(t, r) && !tp.hasOwnProperty(r) && (o[r] = t[r]);
   var l = arguments.length - 2;
   if (l === 1) o.children = n;
   else if (1 < l) {
      for (var a = Array(l), u = 0; u < l; u++) a[u] = arguments[u + 2];
      o.children = a
   }
   if (e && e.defaultProps)
      for (r in l = e.defaultProps, l) o[r] === void 0 && (o[r] = l[r]);
   return {
      $$typeof: To,
      type: e,
      key: i,
      ref: s,
      props: o,
      _owner: Za.current
   }
}

function ig(e, t) {
   return {
      $$typeof: To,
      type: e.type,
      key: t,
      ref: e.ref,
      props: e.props,
      _owner: e._owner
   }
}

function Ja(e) {
   return typeof e == "object" && e !== null && e.$$typeof === To
}

function sg(e) {
   var t = {
      "=": "=0",
      ":": "=2"
   };
   return "$" + e.replace(/[=:]/g, function (n) {
      return t[n]
   })
}
var Pc = /\/+/g;

function Ys(e, t) {
   return typeof e == "object" && e !== null && e.key != null ? sg("" + e.key) : t.toString(36)
}

function ai(e, t, n, r, o) {
   var i = typeof e;
   (i === "undefined" || i === "boolean") && (e = null);
   var s = !1;
   if (e === null) s = !0;
   else switch (i) {
      case "string":
      case "number":
         s = !0;
         break;
      case "object":
         switch (e.$$typeof) {
            case To:
            case Y0:
               s = !0
         }
   }
   if (s) return s = e, o = o(s), e = r === "" ? "." + Ys(s, 0) : r, Cc(o) ? (n = "", e != null && (n = e.replace(Pc, "$&/") + "/"), ai(o, t, n, "", function (u) {
      return u
   })) : o != null && (Ja(o) && (o = ig(o, n + (!o.key || s && s.key === o.key ? "" : ("" + o.key).replace(Pc, "$&/") + "/") + e)), t.push(o)), 1;
   if (s = 0, r = r === "" ? "." : r + ":", Cc(e))
      for (var l = 0; l < e.length; l++) {
         i = e[l];
         var a = r + Ys(i, l);
         s += ai(i, t, n, a, o)
      } else if (a = og(e), typeof a == "function")
         for (e = a.call(e), l = 0; !(i = e.next()).done;) i = i.value, a = r + Ys(i, l++), s += ai(i, t, n, a, o);
      else if (i === "object") throw t = String(e), Error("Objects are not valid as a React child (found: " + (t === "[object Object]" ? "object with keys {" + Object.keys(e).join(", ") + "}" : t) + "). If you meant to render a collection of children, use an array instead.");
   return s
}

function Fo(e, t, n) {
   if (e == null) return e;
   var r = [],
      o = 0;
   return ai(e, r, "", "", function (i) {
      return t.call(n, i, o++)
   }), r
}

function lg(e) {
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
var je = {
      current: null
   },
   ui = {
      transition: null
   },
   ag = {
      ReactCurrentDispatcher: je,
      ReactCurrentBatchConfig: ui,
      ReactCurrentOwner: Za
   };
H.Children = {
   map: Fo,
   forEach: function (e, t, n) {
      Fo(e, function () {
         t.apply(this, arguments)
      }, n)
   },
   count: function (e) {
      var t = 0;
      return Fo(e, function () {
         t++
      }), t
   },
   toArray: function (e) {
      return Fo(e, function (t) {
         return t
      }) || []
   },
   only: function (e) {
      if (!Ja(e)) throw Error("React.Children.only expected to receive a single React element child.");
      return e
   }
};
H.Component = vr;
H.Fragment = K0;
H.Profiler = Z0;
H.PureComponent = Ka;
H.StrictMode = X0;
H.Suspense = tg;
H.__SECRET_INTERNALS_DO_NOT_USE_OR_YOU_WILL_BE_FIRED = ag;
H.cloneElement = function (e, t, n) {
   if (e == null) throw Error("React.cloneElement(...): The argument must be a React element, but you passed " + e + ".");
   var r = Zd({}, e.props),
      o = e.key,
      i = e.ref,
      s = e._owner;
   if (t != null) {
      if (t.ref !== void 0 && (i = t.ref, s = Za.current), t.key !== void 0 && (o = "" + t.key), e.type && e.type.defaultProps) var l = e.type.defaultProps;
      for (a in t) ep.call(t, a) && !tp.hasOwnProperty(a) && (r[a] = t[a] === void 0 && l !== void 0 ? l[a] : t[a])
   }
   var a = arguments.length - 2;
   if (a === 1) r.children = n;
   else if (1 < a) {
      l = Array(a);
      for (var u = 0; u < a; u++) l[u] = arguments[u + 2];
      r.children = l
   }
   return {
      $$typeof: To,
      type: e.type,
      key: o,
      ref: i,
      props: r,
      _owner: s
   }
};
H.createContext = function (e) {
   return e = {
      $$typeof: q0,
      _currentValue: e,
      _currentValue2: e,
      _threadCount: 0,
      Provider: null,
      Consumer: null,
      _defaultValue: null,
      _globalName: null
   }, e.Provider = {
      $$typeof: J0,
      _context: e
   }, e.Consumer = e
};
H.createElement = np;
H.createFactory = function (e) {
   var t = np.bind(null, e);
   return t.type = e, t
};
H.createRef = function () {
   return {
      current: null
   }
};
H.forwardRef = function (e) {
   return {
      $$typeof: eg,
      render: e
   }
};
H.isValidElement = Ja;
H.lazy = function (e) {
   return {
      $$typeof: rg,
      _payload: {
         _status: -1,
         _result: e
      },
      _init: lg
   }
};
H.memo = function (e, t) {
   return {
      $$typeof: ng,
      type: e,
      compare: t === void 0 ? null : t
   }
};
H.startTransition = function (e) {
   var t = ui.transition;
   ui.transition = {};
   try {
      e()
   } finally {
      ui.transition = t
   }
};
H.unstable_act = function () {
   throw Error("act(...) is not supported in production builds of React.")
};
H.useCallback = function (e, t) {
   return je.current.useCallback(e, t)
};
H.useContext = function (e) {
   return je.current.useContext(e)
};
H.useDebugValue = function () {};
H.useDeferredValue = function (e) {
   return je.current.useDeferredValue(e)
};
H.useEffect = function (e, t) {
   return je.current.useEffect(e, t)
};
H.useId = function () {
   return je.current.useId()
};
H.useImperativeHandle = function (e, t, n) {
   return je.current.useImperativeHandle(e, t, n)
};
H.useInsertionEffect = function (e, t) {
   return je.current.useInsertionEffect(e, t)
};
H.useLayoutEffect = function (e, t) {
   return je.current.useLayoutEffect(e, t)
};
H.useMemo = function (e, t) {
   return je.current.useMemo(e, t)
};
H.useReducer = function (e, t, n) {
   return je.current.useReducer(e, t, n)
};
H.useRef = function (e) {
   return je.current.useRef(e)
};
H.useState = function (e) {
   return je.current.useState(e)
};
H.useSyncExternalStore = function (e, t, n) {
   return je.current.useSyncExternalStore(e, t, n)
};
H.useTransition = function () {
   return je.current.useTransition()
};
H.version = "18.2.0";
C.exports = H;
var Ln = C.exports,
   Dl = {},
   rp = {
      exports: {}
   },
   et = {},
   op = {
      exports: {}
   },
   ip = {};
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
   function t(_, z) {
      var F = _.length;
      _.push(z);
      e: for (; 0 < F;) {
         var q = F - 1 >>> 1,
            V = _[q];
         if (0 < o(V, z)) _[q] = z, _[F] = V, F = q;
         else break e
      }
   }

   function n(_) {
      return _.length === 0 ? null : _[0]
   }

   function r(_) {
      if (_.length === 0) return null;
      var z = _[0],
         F = _.pop();
      if (F !== z) {
         _[0] = F;
         e: for (var q = 0, V = _.length, L = V >>> 1; q < L;) {
            var M = 2 * (q + 1) - 1,
               $ = _[M],
               S = M + 1,
               b = _[S];
            if (0 > o($, F)) S < V && 0 > o(b, $) ? (_[q] = b, _[S] = F, q = S) : (_[q] = $, _[M] = F, q = M);
            else if (S < V && 0 > o(b, F)) _[q] = b, _[S] = F, q = S;
            else break e
         }
      }
      return z
   }

   function o(_, z) {
      var F = _.sortIndex - z.sortIndex;
      return F !== 0 ? F : _.id - z.id
   }
   if (typeof performance == "object" && typeof performance.now == "function") {
      var i = performance;
      e.unstable_now = function () {
         return i.now()
      }
   } else {
      var s = Date,
         l = s.now();
      e.unstable_now = function () {
         return s.now() - l
      }
   }
   var a = [],
      u = [],
      c = 1,
      f = null,
      d = 3,
      g = !1,
      v = !1,
      w = !1,
      k = typeof setTimeout == "function" ? setTimeout : null,
      m = typeof clearTimeout == "function" ? clearTimeout : null,
      p = typeof setImmediate != "undefined" ? setImmediate : null;
   typeof navigator != "undefined" && navigator.scheduling !== void 0 && navigator.scheduling.isInputPending !== void 0 && navigator.scheduling.isInputPending.bind(navigator.scheduling);

   function h(_) {
      for (var z = n(u); z !== null;) {
         if (z.callback === null) r(u);
         else if (z.startTime <= _) r(u), z.sortIndex = z.expirationTime, t(a, z);
         else break;
         z = n(u)
      }
   }

   function y(_) {
      if (w = !1, h(_), !v)
         if (n(a) !== null) v = !0, ne(x);
         else {
            var z = n(u);
            z !== null && me(y, z.startTime - _)
         }
   }

   function x(_, z) {
      v = !1, w && (w = !1, m(A), A = -1), g = !0;
      var F = d;
      try {
         for (h(z), f = n(a); f !== null && (!(f.expirationTime > z) || _ && !se());) {
            var q = f.callback;
            if (typeof q == "function") {
               f.callback = null, d = f.priorityLevel;
               var V = q(f.expirationTime <= z);
               z = e.unstable_now(), typeof V == "function" ? f.callback = V : f === n(a) && r(a), h(z)
            } else r(a);
            f = n(a)
         }
         if (f !== null) var L = !0;
         else {
            var M = n(u);
            M !== null && me(y, M.startTime - z), L = !1
         }
         return L
      } finally {
         f = null, d = F, g = !1
      }
   }
   var E = !1,
      T = null,
      A = -1,
      I = 5,
      D = -1;

   function se() {
      return !(e.unstable_now() - D < I)
   }

   function J() {
      if (T !== null) {
         var _ = e.unstable_now();
         D = _;
         var z = !0;
         try {
            z = T(!0, _)
         } finally {
            z ? fe() : (E = !1, T = null)
         }
      } else E = !1
   }
   var fe;
   if (typeof p == "function") fe = function () {
      p(J)
   };
   else if (typeof MessageChannel != "undefined") {
      var we = new MessageChannel,
         le = we.port2;
      we.port1.onmessage = J, fe = function () {
         le.postMessage(null)
      }
   } else fe = function () {
      k(J, 0)
   };

   function ne(_) {
      T = _, E || (E = !0, fe())
   }

   function me(_, z) {
      A = k(function () {
         _(e.unstable_now())
      }, z)
   }
   e.unstable_IdlePriority = 5, e.unstable_ImmediatePriority = 1, e.unstable_LowPriority = 4, e.unstable_NormalPriority = 3, e.unstable_Profiling = null, e.unstable_UserBlockingPriority = 2, e.unstable_cancelCallback = function (_) {
      _.callback = null
   }, e.unstable_continueExecution = function () {
      v || g || (v = !0, ne(x))
   }, e.unstable_forceFrameRate = function (_) {
      0 > _ || 125 < _ ? console.error("forceFrameRate takes a positive int between 0 and 125, forcing frame rates higher than 125 fps is not supported") : I = 0 < _ ? Math.floor(1e3 / _) : 5
   }, e.unstable_getCurrentPriorityLevel = function () {
      return d
   }, e.unstable_getFirstCallbackNode = function () {
      return n(a)
   }, e.unstable_next = function (_) {
      switch (d) {
         case 1:
         case 2:
         case 3:
            var z = 3;
            break;
         default:
            z = d
      }
      var F = d;
      d = z;
      try {
         return _()
      } finally {
         d = F
      }
   }, e.unstable_pauseExecution = function () {}, e.unstable_requestPaint = function () {}, e.unstable_runWithPriority = function (_, z) {
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
      var F = d;
      d = _;
      try {
         return z()
      } finally {
         d = F
      }
   }, e.unstable_scheduleCallback = function (_, z, F) {
      var q = e.unstable_now();
      switch (typeof F == "object" && F !== null ? (F = F.delay, F = typeof F == "number" && 0 < F ? q + F : q) : F = q, _) {
         case 1:
            var V = -1;
            break;
         case 2:
            V = 250;
            break;
         case 5:
            V = 1073741823;
            break;
         case 4:
            V = 1e4;
            break;
         default:
            V = 5e3
      }
      return V = F + V, _ = {
         id: c++,
         callback: z,
         priorityLevel: _,
         startTime: F,
         expirationTime: V,
         sortIndex: -1
      }, F > q ? (_.sortIndex = F, t(u, _), n(a) === null && _ === n(u) && (w ? (m(A), A = -1) : w = !0, me(y, F - q))) : (_.sortIndex = V, t(a, _), v || g || (v = !0, ne(x))), _
   }, e.unstable_shouldYield = se, e.unstable_wrapCallback = function (_) {
      var z = d;
      return function () {
         var F = d;
         d = z;
         try {
            return _.apply(this, arguments)
         } finally {
            d = F
         }
      }
   }
})(ip);
op.exports = ip;
/**
 * @license React
 * react-dom.production.min.js
 *
 * Copyright (c) Facebook, Inc. and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */
var sp = C.exports,
   Je = op.exports;

function P(e) {
   for (var t = "https://reactjs.org/docs/error-decoder.html?invariant=" + e, n = 1; n < arguments.length; n++) t += "&args[]=" + encodeURIComponent(arguments[n]);
   return "Minified React error #" + e + "; visit " + t + " for the full message or use the non-minified dev environment for full errors and additional helpful warnings."
}
var lp = new Set,
   eo = {};

function Mn(e, t) {
   lr(e, t), lr(e + "Capture", t)
}

function lr(e, t) {
   for (eo[e] = t, e = 0; e < t.length; e++) lp.add(t[e])
}
var Nt = !(typeof window == "undefined" || typeof window.document == "undefined" || typeof window.document.createElement == "undefined"),
   Nl = Object.prototype.hasOwnProperty,
   ug = /^[:A-Z_a-z\u00C0-\u00D6\u00D8-\u00F6\u00F8-\u02FF\u0370-\u037D\u037F-\u1FFF\u200C-\u200D\u2070-\u218F\u2C00-\u2FEF\u3001-\uD7FF\uF900-\uFDCF\uFDF0-\uFFFD][:A-Z_a-z\u00C0-\u00D6\u00D8-\u00F6\u00F8-\u02FF\u0370-\u037D\u037F-\u1FFF\u200C-\u200D\u2070-\u218F\u2C00-\u2FEF\u3001-\uD7FF\uF900-\uFDCF\uFDF0-\uFFFD\-.0-9\u00B7\u0300-\u036F\u203F-\u2040]*$/,
   Ec = {},
   Tc = {};

function cg(e) {
   return Nl.call(Tc, e) ? !0 : Nl.call(Ec, e) ? !1 : ug.test(e) ? Tc[e] = !0 : (Ec[e] = !0, !1)
}

function fg(e, t, n, r) {
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

function dg(e, t, n, r) {
   if (t === null || typeof t == "undefined" || fg(e, t, n, r)) return !0;
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

function Ue(e, t, n, r, o, i, s) {
   this.acceptsBooleans = t === 2 || t === 3 || t === 4, this.attributeName = r, this.attributeNamespace = o, this.mustUseProperty = n, this.propertyName = e, this.type = t, this.sanitizeURL = i, this.removeEmptyString = s
}
var Le = {};
"children dangerouslySetInnerHTML defaultValue defaultChecked innerHTML suppressContentEditableWarning suppressHydrationWarning style".split(" ").forEach(function (e) {
   Le[e] = new Ue(e, 0, !1, e, null, !1, !1)
});
[
   ["acceptCharset", "accept-charset"],
   ["className", "class"],
   ["htmlFor", "for"],
   ["httpEquiv", "http-equiv"]
].forEach(function (e) {
   var t = e[0];
   Le[t] = new Ue(t, 1, !1, e[1], null, !1, !1)
});
["contentEditable", "draggable", "spellCheck", "value"].forEach(function (e) {
   Le[e] = new Ue(e, 2, !1, e.toLowerCase(), null, !1, !1)
});
["autoReverse", "externalResourcesRequired", "focusable", "preserveAlpha"].forEach(function (e) {
   Le[e] = new Ue(e, 2, !1, e, null, !1, !1)
});
"allowFullScreen async autoFocus autoPlay controls default defer disabled disablePictureInPicture disableRemotePlayback formNoValidate hidden loop noModule noValidate open playsInline readOnly required reversed scoped seamless itemScope".split(" ").forEach(function (e) {
   Le[e] = new Ue(e, 3, !1, e.toLowerCase(), null, !1, !1)
});
["checked", "multiple", "muted", "selected"].forEach(function (e) {
   Le[e] = new Ue(e, 3, !0, e, null, !1, !1)
});
["capture", "download"].forEach(function (e) {
   Le[e] = new Ue(e, 4, !1, e, null, !1, !1)
});
["cols", "rows", "size", "span"].forEach(function (e) {
   Le[e] = new Ue(e, 6, !1, e, null, !1, !1)
});
["rowSpan", "start"].forEach(function (e) {
   Le[e] = new Ue(e, 5, !1, e.toLowerCase(), null, !1, !1)
});
var qa = /[\-:]([a-z])/g;

function eu(e) {
   return e[1].toUpperCase()
}
"accent-height alignment-baseline arabic-form baseline-shift cap-height clip-path clip-rule color-interpolation color-interpolation-filters color-profile color-rendering dominant-baseline enable-background fill-opacity fill-rule flood-color flood-opacity font-family font-size font-size-adjust font-stretch font-style font-variant font-weight glyph-name glyph-orientation-horizontal glyph-orientation-vertical horiz-adv-x horiz-origin-x image-rendering letter-spacing lighting-color marker-end marker-mid marker-start overline-position overline-thickness paint-order panose-1 pointer-events rendering-intent shape-rendering stop-color stop-opacity strikethrough-position strikethrough-thickness stroke-dasharray stroke-dashoffset stroke-linecap stroke-linejoin stroke-miterlimit stroke-opacity stroke-width text-anchor text-decoration text-rendering underline-position underline-thickness unicode-bidi unicode-range units-per-em v-alphabetic v-hanging v-ideographic v-mathematical vector-effect vert-adv-y vert-origin-x vert-origin-y word-spacing writing-mode xmlns:xlink x-height".split(" ").forEach(function (e) {
   var t = e.replace(qa, eu);
   Le[t] = new Ue(t, 1, !1, e, null, !1, !1)
});
"xlink:actuate xlink:arcrole xlink:role xlink:show xlink:title xlink:type".split(" ").forEach(function (e) {
   var t = e.replace(qa, eu);
   Le[t] = new Ue(t, 1, !1, e, "http://www.w3.org/1999/xlink", !1, !1)
});
["xml:base", "xml:lang", "xml:space"].forEach(function (e) {
   var t = e.replace(qa, eu);
   Le[t] = new Ue(t, 1, !1, e, "http://www.w3.org/XML/1998/namespace", !1, !1)
});
["tabIndex", "crossOrigin"].forEach(function (e) {
   Le[e] = new Ue(e, 1, !1, e.toLowerCase(), null, !1, !1)
});
Le.xlinkHref = new Ue("xlinkHref", 1, !1, "xlink:href", "http://www.w3.org/1999/xlink", !0, !1);
["src", "href", "action", "formAction"].forEach(function (e) {
   Le[e] = new Ue(e, 1, !1, e.toLowerCase(), null, !0, !0)
});

function tu(e, t, n, r) {
   var o = Le.hasOwnProperty(t) ? Le[t] : null;
   (o !== null ? o.type !== 0 : r || !(2 < t.length) || t[0] !== "o" && t[0] !== "O" || t[1] !== "n" && t[1] !== "N") && (dg(t, n, o, r) && (n = null), r || o === null ? cg(t) && (n === null ? e.removeAttribute(t) : e.setAttribute(t, "" + n)) : o.mustUseProperty ? e[o.propertyName] = n === null ? o.type === 3 ? !1 : "" : n : (t = o.attributeName, r = o.attributeNamespace, n === null ? e.removeAttribute(t) : (o = o.type, n = o === 3 || o === 4 && n === !0 ? "" : "" + n, r ? e.setAttributeNS(r, t, n) : e.setAttribute(t, n))))
}
var jt = sp.__SECRET_INTERNALS_DO_NOT_USE_OR_YOU_WILL_BE_FIRED,
   $o = Symbol.for("react.element"),
   Fn = Symbol.for("react.portal"),
   $n = Symbol.for("react.fragment"),
   nu = Symbol.for("react.strict_mode"),
   Il = Symbol.for("react.profiler"),
   ap = Symbol.for("react.provider"),
   up = Symbol.for("react.context"),
   ru = Symbol.for("react.forward_ref"),
   zl = Symbol.for("react.suspense"),
   Fl = Symbol.for("react.suspense_list"),
   ou = Symbol.for("react.memo"),
   bt = Symbol.for("react.lazy"),
   cp = Symbol.for("react.offscreen"),
   _c = Symbol.iterator;

function kr(e) {
   return e === null || typeof e != "object" ? null : (e = _c && e[_c] || e["@@iterator"], typeof e == "function" ? e : null)
}
var ce = Object.assign,
   Ks;

function Mr(e) {
   if (Ks === void 0) try {
      throw Error()
   } catch (n) {
      var t = n.stack.trim().match(/\n( *(at )?)/);
      Ks = t && t[1] || ""
   }
   return `
` + Ks + e
}
var Xs = !1;

function Zs(e, t) {
   if (!e || Xs) return "";
   Xs = !0;
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
            } catch (u) {
               var r = u
            }
            Reflect.construct(e, [], t)
         } else {
            try {
               t.call()
            } catch (u) {
               r = u
            }
            e.call(t.prototype)
         }
      else {
         try {
            throw Error()
         } catch (u) {
            r = u
         }
         e()
      }
   } catch (u) {
      if (u && r && typeof u.stack == "string") {
         for (var o = u.stack.split(`
`), i = r.stack.split(`
`), s = o.length - 1, l = i.length - 1; 1 <= s && 0 <= l && o[s] !== i[l];) l--;
         for (; 1 <= s && 0 <= l; s--, l--)
            if (o[s] !== i[l]) {
               if (s !== 1 || l !== 1)
                  do
                     if (s--, l--, 0 > l || o[s] !== i[l]) {
                        var a = `
` + o[s].replace(" at new ", " at ");
                        return e.displayName && a.includes("<anonymous>") && (a = a.replace("<anonymous>", e.displayName)), a
                     } while (1 <= s && 0 <= l);
               break
            }
      }
   } finally {
      Xs = !1, Error.prepareStackTrace = n
   }
   return (e = e ? e.displayName || e.name : "") ? Mr(e) : ""
}

function pg(e) {
   switch (e.tag) {
      case 5:
         return Mr(e.type);
      case 16:
         return Mr("Lazy");
      case 13:
         return Mr("Suspense");
      case 19:
         return Mr("SuspenseList");
      case 0:
      case 2:
      case 15:
         return e = Zs(e.type, !1), e;
      case 11:
         return e = Zs(e.type.render, !1), e;
      case 1:
         return e = Zs(e.type, !0), e;
      default:
         return ""
   }
}

function $l(e) {
   if (e == null) return null;
   if (typeof e == "function") return e.displayName || e.name || null;
   if (typeof e == "string") return e;
   switch (e) {
      case $n:
         return "Fragment";
      case Fn:
         return "Portal";
      case Il:
         return "Profiler";
      case nu:
         return "StrictMode";
      case zl:
         return "Suspense";
      case Fl:
         return "SuspenseList"
   }
   if (typeof e == "object") switch (e.$$typeof) {
      case up:
         return (e.displayName || "Context") + ".Consumer";
      case ap:
         return (e._context.displayName || "Context") + ".Provider";
      case ru:
         var t = e.render;
         return e = e.displayName, e || (e = t.displayName || t.name || "", e = e !== "" ? "ForwardRef(" + e + ")" : "ForwardRef"), e;
      case ou:
         return t = e.displayName || null, t !== null ? t : $l(e.type) || "Memo";
      case bt:
         t = e._payload, e = e._init;
         try {
            return $l(e(t))
         } catch {}
   }
   return null
}

function hg(e) {
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
         return $l(t);
      case 8:
         return t === nu ? "StrictMode" : "Mode";
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

function un(e) {
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

function fp(e) {
   var t = e.type;
   return (e = e.nodeName) && e.toLowerCase() === "input" && (t === "checkbox" || t === "radio")
}

function mg(e) {
   var t = fp(e) ? "checked" : "value",
      n = Object.getOwnPropertyDescriptor(e.constructor.prototype, t),
      r = "" + e[t];
   if (!e.hasOwnProperty(t) && typeof n != "undefined" && typeof n.get == "function" && typeof n.set == "function") {
      var o = n.get,
         i = n.set;
      return Object.defineProperty(e, t, {
         configurable: !0,
         get: function () {
            return o.call(this)
         },
         set: function (s) {
            r = "" + s, i.call(this, s)
         }
      }), Object.defineProperty(e, t, {
         enumerable: n.enumerable
      }), {
         getValue: function () {
            return r
         },
         setValue: function (s) {
            r = "" + s
         },
         stopTracking: function () {
            e._valueTracker = null, delete e[t]
         }
      }
   }
}

function jo(e) {
   e._valueTracker || (e._valueTracker = mg(e))
}

function dp(e) {
   if (!e) return !1;
   var t = e._valueTracker;
   if (!t) return !0;
   var n = t.getValue(),
      r = "";
   return e && (r = fp(e) ? e.checked ? "true" : "false" : e.value), e = r, e !== n ? (t.setValue(e), !0) : !1
}

function Pi(e) {
   if (e = e || (typeof document != "undefined" ? document : void 0), typeof e == "undefined") return null;
   try {
      return e.activeElement || e.body
   } catch {
      return e.body
   }
}

function jl(e, t) {
   var n = t.checked;
   return ce({}, t, {
      defaultChecked: void 0,
      defaultValue: void 0,
      value: void 0,
      checked: n != null ? n : e._wrapperState.initialChecked
   })
}

function Ac(e, t) {
   var n = t.defaultValue == null ? "" : t.defaultValue,
      r = t.checked != null ? t.checked : t.defaultChecked;
   n = un(t.value != null ? t.value : n), e._wrapperState = {
      initialChecked: r,
      initialValue: n,
      controlled: t.type === "checkbox" || t.type === "radio" ? t.checked != null : t.value != null
   }
}

function pp(e, t) {
   t = t.checked, t != null && tu(e, "checked", t, !1)
}

function Ul(e, t) {
   pp(e, t);
   var n = un(t.value),
      r = t.type;
   if (n != null) r === "number" ? (n === 0 && e.value === "" || e.value != n) && (e.value = "" + n) : e.value !== "" + n && (e.value = "" + n);
   else if (r === "submit" || r === "reset") {
      e.removeAttribute("value");
      return
   }
   t.hasOwnProperty("value") ? Bl(e, t.type, n) : t.hasOwnProperty("defaultValue") && Bl(e, t.type, un(t.defaultValue)), t.checked == null && t.defaultChecked != null && (e.defaultChecked = !!t.defaultChecked)
}

function Rc(e, t, n) {
   if (t.hasOwnProperty("value") || t.hasOwnProperty("defaultValue")) {
      var r = t.type;
      if (!(r !== "submit" && r !== "reset" || t.value !== void 0 && t.value !== null)) return;
      t = "" + e._wrapperState.initialValue, n || t === e.value || (e.value = t), e.defaultValue = t
   }
   n = e.name, n !== "" && (e.name = ""), e.defaultChecked = !!e._wrapperState.initialChecked, n !== "" && (e.name = n)
}

function Bl(e, t, n) {
   (t !== "number" || Pi(e.ownerDocument) !== e) && (n == null ? e.defaultValue = "" + e._wrapperState.initialValue : e.defaultValue !== "" + n && (e.defaultValue = "" + n))
}
var Or = Array.isArray;

function qn(e, t, n, r) {
   if (e = e.options, t) {
      t = {};
      for (var o = 0; o < n.length; o++) t["$" + n[o]] = !0;
      for (n = 0; n < e.length; n++) o = t.hasOwnProperty("$" + e[n].value), e[n].selected !== o && (e[n].selected = o), o && r && (e[n].defaultSelected = !0)
   } else {
      for (n = "" + un(n), t = null, o = 0; o < e.length; o++) {
         if (e[o].value === n) {
            e[o].selected = !0, r && (e[o].defaultSelected = !0);
            return
         }
         t !== null || e[o].disabled || (t = e[o])
      }
      t !== null && (t.selected = !0)
   }
}

function Hl(e, t) {
   if (t.dangerouslySetInnerHTML != null) throw Error(P(91));
   return ce({}, t, {
      value: void 0,
      defaultValue: void 0,
      children: "" + e._wrapperState.initialValue
   })
}

function Vc(e, t) {
   var n = t.value;
   if (n == null) {
      if (n = t.children, t = t.defaultValue, n != null) {
         if (t != null) throw Error(P(92));
         if (Or(n)) {
            if (1 < n.length) throw Error(P(93));
            n = n[0]
         }
         t = n
      }
      t == null && (t = ""), n = t
   }
   e._wrapperState = {
      initialValue: un(n)
   }
}

function hp(e, t) {
   var n = un(t.value),
      r = un(t.defaultValue);
   n != null && (n = "" + n, n !== e.value && (e.value = n), t.defaultValue == null && e.defaultValue !== n && (e.defaultValue = n)), r != null && (e.defaultValue = "" + r)
}

function Lc(e) {
   var t = e.textContent;
   t === e._wrapperState.initialValue && t !== "" && t !== null && (e.value = t)
}

function mp(e) {
   switch (e) {
      case "svg":
         return "http://www.w3.org/2000/svg";
      case "math":
         return "http://www.w3.org/1998/Math/MathML";
      default:
         return "http://www.w3.org/1999/xhtml"
   }
}

function bl(e, t) {
   return e == null || e === "http://www.w3.org/1999/xhtml" ? mp(t) : e === "http://www.w3.org/2000/svg" && t === "foreignObject" ? "http://www.w3.org/1999/xhtml" : e
}
var Uo, gp = function (e) {
   return typeof MSApp != "undefined" && MSApp.execUnsafeLocalFunction ? function (t, n, r, o) {
      MSApp.execUnsafeLocalFunction(function () {
         return e(t, n, r, o)
      })
   } : e
}(function (e, t) {
   if (e.namespaceURI !== "http://www.w3.org/2000/svg" || "innerHTML" in e) e.innerHTML = t;
   else {
      for (Uo = Uo || document.createElement("div"), Uo.innerHTML = "<svg>" + t.valueOf().toString() + "</svg>", t = Uo.firstChild; e.firstChild;) e.removeChild(e.firstChild);
      for (; t.firstChild;) e.appendChild(t.firstChild)
   }
});

function to(e, t) {
   if (t) {
      var n = e.firstChild;
      if (n && n === e.lastChild && n.nodeType === 3) {
         n.nodeValue = t;
         return
      }
   }
   e.textContent = t
}
var Ir = {
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
   gg = ["Webkit", "ms", "Moz", "O"];
Object.keys(Ir).forEach(function (e) {
   gg.forEach(function (t) {
      t = t + e.charAt(0).toUpperCase() + e.substring(1), Ir[t] = Ir[e]
   })
});

function vp(e, t, n) {
   return t == null || typeof t == "boolean" || t === "" ? "" : n || typeof t != "number" || t === 0 || Ir.hasOwnProperty(e) && Ir[e] ? ("" + t).trim() : t + "px"
}

function yp(e, t) {
   e = e.style;
   for (var n in t)
      if (t.hasOwnProperty(n)) {
         var r = n.indexOf("--") === 0,
            o = vp(n, t[n], r);
         n === "float" && (n = "cssFloat"), r ? e.setProperty(n, o) : e[n] = o
      }
}
var vg = ce({
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

function Wl(e, t) {
   if (t) {
      if (vg[e] && (t.children != null || t.dangerouslySetInnerHTML != null)) throw Error(P(137, e));
      if (t.dangerouslySetInnerHTML != null) {
         if (t.children != null) throw Error(P(60));
         if (typeof t.dangerouslySetInnerHTML != "object" || !("__html" in t.dangerouslySetInnerHTML)) throw Error(P(61))
      }
      if (t.style != null && typeof t.style != "object") throw Error(P(62))
   }
}

function Gl(e, t) {
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
var Ql = null;

function iu(e) {
   return e = e.target || e.srcElement || window, e.correspondingUseElement && (e = e.correspondingUseElement), e.nodeType === 3 ? e.parentNode : e
}
var Yl = null,
   er = null,
   tr = null;

function Mc(e) {
   if (e = Ro(e)) {
      if (typeof Yl != "function") throw Error(P(280));
      var t = e.stateNode;
      t && (t = ps(t), Yl(e.stateNode, e.type, t))
   }
}

function wp(e) {
   er ? tr ? tr.push(e) : tr = [e] : er = e
}

function Sp() {
   if (er) {
      var e = er,
         t = tr;
      if (tr = er = null, Mc(e), t)
         for (e = 0; e < t.length; e++) Mc(t[e])
   }
}

function xp(e, t) {
   return e(t)
}

function kp() {}
var Js = !1;

function Cp(e, t, n) {
   if (Js) return e(t, n);
   Js = !0;
   try {
      return xp(e, t, n)
   } finally {
      Js = !1, (er !== null || tr !== null) && (kp(), Sp())
   }
}

function no(e, t) {
   var n = e.stateNode;
   if (n === null) return null;
   var r = ps(n);
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
   if (n && typeof n != "function") throw Error(P(231, t, typeof n));
   return n
}
var Kl = !1;
if (Nt) try {
   var Cr = {};
   Object.defineProperty(Cr, "passive", {
      get: function () {
         Kl = !0
      }
   }), window.addEventListener("test", Cr, Cr), window.removeEventListener("test", Cr, Cr)
} catch {
   Kl = !1
}

function yg(e, t, n, r, o, i, s, l, a) {
   var u = Array.prototype.slice.call(arguments, 3);
   try {
      t.apply(n, u)
   } catch (c) {
      this.onError(c)
   }
}
var zr = !1,
   Ei = null,
   Ti = !1,
   Xl = null,
   wg = {
      onError: function (e) {
         zr = !0, Ei = e
      }
   };

function Sg(e, t, n, r, o, i, s, l, a) {
   zr = !1, Ei = null, yg.apply(wg, arguments)
}

function xg(e, t, n, r, o, i, s, l, a) {
   if (Sg.apply(this, arguments), zr) {
      if (zr) {
         var u = Ei;
         zr = !1, Ei = null
      } else throw Error(P(198));
      Ti || (Ti = !0, Xl = u)
   }
}

function On(e) {
   var t = e,
      n = e;
   if (e.alternate)
      for (; t.return;) t = t.return;
   else {
      e = t;
      do t = e, (t.flags & 4098) !== 0 && (n = t.return), e = t.return; while (e)
   }
   return t.tag === 3 ? n : null
}

function Pp(e) {
   if (e.tag === 13) {
      var t = e.memoizedState;
      if (t === null && (e = e.alternate, e !== null && (t = e.memoizedState)), t !== null) return t.dehydrated
   }
   return null
}

function Oc(e) {
   if (On(e) !== e) throw Error(P(188))
}

function kg(e) {
   var t = e.alternate;
   if (!t) {
      if (t = On(e), t === null) throw Error(P(188));
      return t !== e ? null : e
   }
   for (var n = e, r = t;;) {
      var o = n.return;
      if (o === null) break;
      var i = o.alternate;
      if (i === null) {
         if (r = o.return, r !== null) {
            n = r;
            continue
         }
         break
      }
      if (o.child === i.child) {
         for (i = o.child; i;) {
            if (i === n) return Oc(o), e;
            if (i === r) return Oc(o), t;
            i = i.sibling
         }
         throw Error(P(188))
      }
      if (n.return !== r.return) n = o, r = i;
      else {
         for (var s = !1, l = o.child; l;) {
            if (l === n) {
               s = !0, n = o, r = i;
               break
            }
            if (l === r) {
               s = !0, r = o, n = i;
               break
            }
            l = l.sibling
         }
         if (!s) {
            for (l = i.child; l;) {
               if (l === n) {
                  s = !0, n = i, r = o;
                  break
               }
               if (l === r) {
                  s = !0, r = i, n = o;
                  break
               }
               l = l.sibling
            }
            if (!s) throw Error(P(189))
         }
      }
      if (n.alternate !== r) throw Error(P(190))
   }
   if (n.tag !== 3) throw Error(P(188));
   return n.stateNode.current === n ? e : t
}

function Ep(e) {
   return e = kg(e), e !== null ? Tp(e) : null
}

function Tp(e) {
   if (e.tag === 5 || e.tag === 6) return e;
   for (e = e.child; e !== null;) {
      var t = Tp(e);
      if (t !== null) return t;
      e = e.sibling
   }
   return null
}
var _p = Je.unstable_scheduleCallback,
   Dc = Je.unstable_cancelCallback,
   Cg = Je.unstable_shouldYield,
   Pg = Je.unstable_requestPaint,
   ve = Je.unstable_now,
   Eg = Je.unstable_getCurrentPriorityLevel,
   su = Je.unstable_ImmediatePriority,
   Ap = Je.unstable_UserBlockingPriority,
   _i = Je.unstable_NormalPriority,
   Tg = Je.unstable_LowPriority,
   Rp = Je.unstable_IdlePriority,
   us = null,
   Et = null;

function _g(e) {
   if (Et && typeof Et.onCommitFiberRoot == "function") try {
      Et.onCommitFiberRoot(us, e, void 0, (e.current.flags & 128) === 128)
   } catch {}
}
var vt = Math.clz32 ? Math.clz32 : Vg,
   Ag = Math.log,
   Rg = Math.LN2;

function Vg(e) {
   return e >>>= 0, e === 0 ? 32 : 31 - (Ag(e) / Rg | 0) | 0
}
var Bo = 64,
   Ho = 4194304;

function Dr(e) {
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

function Ai(e, t) {
   var n = e.pendingLanes;
   if (n === 0) return 0;
   var r = 0,
      o = e.suspendedLanes,
      i = e.pingedLanes,
      s = n & 268435455;
   if (s !== 0) {
      var l = s & ~o;
      l !== 0 ? r = Dr(l) : (i &= s, i !== 0 && (r = Dr(i)))
   } else s = n & ~o, s !== 0 ? r = Dr(s) : i !== 0 && (r = Dr(i));
   if (r === 0) return 0;
   if (t !== 0 && t !== r && (t & o) === 0 && (o = r & -r, i = t & -t, o >= i || o === 16 && (i & 4194240) !== 0)) return t;
   if ((r & 4) !== 0 && (r |= n & 16), t = e.entangledLanes, t !== 0)
      for (e = e.entanglements, t &= r; 0 < t;) n = 31 - vt(t), o = 1 << n, r |= e[n], t &= ~o;
   return r
}

function Lg(e, t) {
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

function Mg(e, t) {
   for (var n = e.suspendedLanes, r = e.pingedLanes, o = e.expirationTimes, i = e.pendingLanes; 0 < i;) {
      var s = 31 - vt(i),
         l = 1 << s,
         a = o[s];
      a === -1 ? ((l & n) === 0 || (l & r) !== 0) && (o[s] = Lg(l, t)) : a <= t && (e.expiredLanes |= l), i &= ~l
   }
}

function Zl(e) {
   return e = e.pendingLanes & -1073741825, e !== 0 ? e : e & 1073741824 ? 1073741824 : 0
}

function Vp() {
   var e = Bo;
   return Bo <<= 1, (Bo & 4194240) === 0 && (Bo = 64), e
}

function qs(e) {
   for (var t = [], n = 0; 31 > n; n++) t.push(e);
   return t
}

function _o(e, t, n) {
   e.pendingLanes |= t, t !== 536870912 && (e.suspendedLanes = 0, e.pingedLanes = 0), e = e.eventTimes, t = 31 - vt(t), e[t] = n
}

function Og(e, t) {
   var n = e.pendingLanes & ~t;
   e.pendingLanes = t, e.suspendedLanes = 0, e.pingedLanes = 0, e.expiredLanes &= t, e.mutableReadLanes &= t, e.entangledLanes &= t, t = e.entanglements;
   var r = e.eventTimes;
   for (e = e.expirationTimes; 0 < n;) {
      var o = 31 - vt(n),
         i = 1 << o;
      t[o] = 0, r[o] = -1, e[o] = -1, n &= ~i
   }
}

function lu(e, t) {
   var n = e.entangledLanes |= t;
   for (e = e.entanglements; n;) {
      var r = 31 - vt(n),
         o = 1 << r;
      o & t | e[r] & t && (e[r] |= t), n &= ~o
   }
}
var X = 0;

function Lp(e) {
   return e &= -e, 1 < e ? 4 < e ? (e & 268435455) !== 0 ? 16 : 536870912 : 4 : 1
}
var Mp, au, Op, Dp, Np, Jl = !1,
   bo = [],
   qt = null,
   en = null,
   tn = null,
   ro = new Map,
   oo = new Map,
   Qt = [],
   Dg = "mousedown mouseup touchcancel touchend touchstart auxclick dblclick pointercancel pointerdown pointerup dragend dragstart drop compositionend compositionstart keydown keypress keyup input textInput copy cut paste click change contextmenu reset submit".split(" ");

function Nc(e, t) {
   switch (e) {
      case "focusin":
      case "focusout":
         qt = null;
         break;
      case "dragenter":
      case "dragleave":
         en = null;
         break;
      case "mouseover":
      case "mouseout":
         tn = null;
         break;
      case "pointerover":
      case "pointerout":
         ro.delete(t.pointerId);
         break;
      case "gotpointercapture":
      case "lostpointercapture":
         oo.delete(t.pointerId)
   }
}

function Pr(e, t, n, r, o, i) {
   return e === null || e.nativeEvent !== i ? (e = {
      blockedOn: t,
      domEventName: n,
      eventSystemFlags: r,
      nativeEvent: i,
      targetContainers: [o]
   }, t !== null && (t = Ro(t), t !== null && au(t)), e) : (e.eventSystemFlags |= r, t = e.targetContainers, o !== null && t.indexOf(o) === -1 && t.push(o), e)
}

function Ng(e, t, n, r, o) {
   switch (t) {
      case "focusin":
         return qt = Pr(qt, e, t, n, r, o), !0;
      case "dragenter":
         return en = Pr(en, e, t, n, r, o), !0;
      case "mouseover":
         return tn = Pr(tn, e, t, n, r, o), !0;
      case "pointerover":
         var i = o.pointerId;
         return ro.set(i, Pr(ro.get(i) || null, e, t, n, r, o)), !0;
      case "gotpointercapture":
         return i = o.pointerId, oo.set(i, Pr(oo.get(i) || null, e, t, n, r, o)), !0
   }
   return !1
}

function Ip(e) {
   var t = Sn(e.target);
   if (t !== null) {
      var n = On(t);
      if (n !== null) {
         if (t = n.tag, t === 13) {
            if (t = Pp(n), t !== null) {
               e.blockedOn = t, Np(e.priority, function () {
                  Op(n)
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

function ci(e) {
   if (e.blockedOn !== null) return !1;
   for (var t = e.targetContainers; 0 < t.length;) {
      var n = ql(e.domEventName, e.eventSystemFlags, t[0], e.nativeEvent);
      if (n === null) {
         n = e.nativeEvent;
         var r = new n.constructor(n.type, n);
         Ql = r, n.target.dispatchEvent(r), Ql = null
      } else return t = Ro(n), t !== null && au(t), e.blockedOn = n, !1;
      t.shift()
   }
   return !0
}

function Ic(e, t, n) {
   ci(e) && n.delete(t)
}

function Ig() {
   Jl = !1, qt !== null && ci(qt) && (qt = null), en !== null && ci(en) && (en = null), tn !== null && ci(tn) && (tn = null), ro.forEach(Ic), oo.forEach(Ic)
}

function Er(e, t) {
   e.blockedOn === t && (e.blockedOn = null, Jl || (Jl = !0, Je.unstable_scheduleCallback(Je.unstable_NormalPriority, Ig)))
}

function io(e) {
   function t(o) {
      return Er(o, e)
   }
   if (0 < bo.length) {
      Er(bo[0], e);
      for (var n = 1; n < bo.length; n++) {
         var r = bo[n];
         r.blockedOn === e && (r.blockedOn = null)
      }
   }
   for (qt !== null && Er(qt, e), en !== null && Er(en, e), tn !== null && Er(tn, e), ro.forEach(t), oo.forEach(t), n = 0; n < Qt.length; n++) r = Qt[n], r.blockedOn === e && (r.blockedOn = null);
   for (; 0 < Qt.length && (n = Qt[0], n.blockedOn === null);) Ip(n), n.blockedOn === null && Qt.shift()
}
var nr = jt.ReactCurrentBatchConfig,
   Ri = !0;

function zg(e, t, n, r) {
   var o = X,
      i = nr.transition;
   nr.transition = null;
   try {
      X = 1, uu(e, t, n, r)
   } finally {
      X = o, nr.transition = i
   }
}

function Fg(e, t, n, r) {
   var o = X,
      i = nr.transition;
   nr.transition = null;
   try {
      X = 4, uu(e, t, n, r)
   } finally {
      X = o, nr.transition = i
   }
}

function uu(e, t, n, r) {
   if (Ri) {
      var o = ql(e, t, n, r);
      if (o === null) ul(e, t, r, Vi, n), Nc(e, r);
      else if (Ng(o, e, t, n, r)) r.stopPropagation();
      else if (Nc(e, r), t & 4 && -1 < Dg.indexOf(e)) {
         for (; o !== null;) {
            var i = Ro(o);
            if (i !== null && Mp(i), i = ql(e, t, n, r), i === null && ul(e, t, r, Vi, n), i === o) break;
            o = i
         }
         o !== null && r.stopPropagation()
      } else ul(e, t, r, null, n)
   }
}
var Vi = null;

function ql(e, t, n, r) {
   if (Vi = null, e = iu(r), e = Sn(e), e !== null)
      if (t = On(e), t === null) e = null;
      else if (n = t.tag, n === 13) {
      if (e = Pp(t), e !== null) return e;
      e = null
   } else if (n === 3) {
      if (t.stateNode.current.memoizedState.isDehydrated) return t.tag === 3 ? t.stateNode.containerInfo : null;
      e = null
   } else t !== e && (e = null);
   return Vi = e, null
}

function zp(e) {
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
         switch (Eg()) {
            case su:
               return 1;
            case Ap:
               return 4;
            case _i:
            case Tg:
               return 16;
            case Rp:
               return 536870912;
            default:
               return 16
         }
      default:
         return 16
   }
}
var Kt = null,
   cu = null,
   fi = null;

function Fp() {
   if (fi) return fi;
   var e, t = cu,
      n = t.length,
      r, o = "value" in Kt ? Kt.value : Kt.textContent,
      i = o.length;
   for (e = 0; e < n && t[e] === o[e]; e++);
   var s = n - e;
   for (r = 1; r <= s && t[n - r] === o[i - r]; r++);
   return fi = o.slice(e, 1 < r ? 1 - r : void 0)
}

function di(e) {
   var t = e.keyCode;
   return "charCode" in e ? (e = e.charCode, e === 0 && t === 13 && (e = 13)) : e = t, e === 10 && (e = 13), 32 <= e || e === 13 ? e : 0
}

function Wo() {
   return !0
}

function zc() {
   return !1
}

function tt(e) {
   function t(n, r, o, i, s) {
      this._reactName = n, this._targetInst = o, this.type = r, this.nativeEvent = i, this.target = s, this.currentTarget = null;
      for (var l in e) e.hasOwnProperty(l) && (n = e[l], this[l] = n ? n(i) : i[l]);
      return this.isDefaultPrevented = (i.defaultPrevented != null ? i.defaultPrevented : i.returnValue === !1) ? Wo : zc, this.isPropagationStopped = zc, this
   }
   return ce(t.prototype, {
      preventDefault: function () {
         this.defaultPrevented = !0;
         var n = this.nativeEvent;
         n && (n.preventDefault ? n.preventDefault() : typeof n.returnValue != "unknown" && (n.returnValue = !1), this.isDefaultPrevented = Wo)
      },
      stopPropagation: function () {
         var n = this.nativeEvent;
         n && (n.stopPropagation ? n.stopPropagation() : typeof n.cancelBubble != "unknown" && (n.cancelBubble = !0), this.isPropagationStopped = Wo)
      },
      persist: function () {},
      isPersistent: Wo
   }), t
}
var yr = {
      eventPhase: 0,
      bubbles: 0,
      cancelable: 0,
      timeStamp: function (e) {
         return e.timeStamp || Date.now()
      },
      defaultPrevented: 0,
      isTrusted: 0
   },
   fu = tt(yr),
   Ao = ce({}, yr, {
      view: 0,
      detail: 0
   }),
   $g = tt(Ao),
   el, tl, Tr, cs = ce({}, Ao, {
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
      getModifierState: du,
      button: 0,
      buttons: 0,
      relatedTarget: function (e) {
         return e.relatedTarget === void 0 ? e.fromElement === e.srcElement ? e.toElement : e.fromElement : e.relatedTarget
      },
      movementX: function (e) {
         return "movementX" in e ? e.movementX : (e !== Tr && (Tr && e.type === "mousemove" ? (el = e.screenX - Tr.screenX, tl = e.screenY - Tr.screenY) : tl = el = 0, Tr = e), el)
      },
      movementY: function (e) {
         return "movementY" in e ? e.movementY : tl
      }
   }),
   Fc = tt(cs),
   jg = ce({}, cs, {
      dataTransfer: 0
   }),
   Ug = tt(jg),
   Bg = ce({}, Ao, {
      relatedTarget: 0
   }),
   nl = tt(Bg),
   Hg = ce({}, yr, {
      animationName: 0,
      elapsedTime: 0,
      pseudoElement: 0
   }),
   bg = tt(Hg),
   Wg = ce({}, yr, {
      clipboardData: function (e) {
         return "clipboardData" in e ? e.clipboardData : window.clipboardData
      }
   }),
   Gg = tt(Wg),
   Qg = ce({}, yr, {
      data: 0
   }),
   $c = tt(Qg),
   Yg = {
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
   Kg = {
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
   Xg = {
      Alt: "altKey",
      Control: "ctrlKey",
      Meta: "metaKey",
      Shift: "shiftKey"
   };

function Zg(e) {
   var t = this.nativeEvent;
   return t.getModifierState ? t.getModifierState(e) : (e = Xg[e]) ? !!t[e] : !1
}

function du() {
   return Zg
}
var Jg = ce({}, Ao, {
      key: function (e) {
         if (e.key) {
            var t = Yg[e.key] || e.key;
            if (t !== "Unidentified") return t
         }
         return e.type === "keypress" ? (e = di(e), e === 13 ? "Enter" : String.fromCharCode(e)) : e.type === "keydown" || e.type === "keyup" ? Kg[e.keyCode] || "Unidentified" : ""
      },
      code: 0,
      location: 0,
      ctrlKey: 0,
      shiftKey: 0,
      altKey: 0,
      metaKey: 0,
      repeat: 0,
      locale: 0,
      getModifierState: du,
      charCode: function (e) {
         return e.type === "keypress" ? di(e) : 0
      },
      keyCode: function (e) {
         return e.type === "keydown" || e.type === "keyup" ? e.keyCode : 0
      },
      which: function (e) {
         return e.type === "keypress" ? di(e) : e.type === "keydown" || e.type === "keyup" ? e.keyCode : 0
      }
   }),
   qg = tt(Jg),
   ev = ce({}, cs, {
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
   jc = tt(ev),
   tv = ce({}, Ao, {
      touches: 0,
      targetTouches: 0,
      changedTouches: 0,
      altKey: 0,
      metaKey: 0,
      ctrlKey: 0,
      shiftKey: 0,
      getModifierState: du
   }),
   nv = tt(tv),
   rv = ce({}, yr, {
      propertyName: 0,
      elapsedTime: 0,
      pseudoElement: 0
   }),
   ov = tt(rv),
   iv = ce({}, cs, {
      deltaX: function (e) {
         return "deltaX" in e ? e.deltaX : "wheelDeltaX" in e ? -e.wheelDeltaX : 0
      },
      deltaY: function (e) {
         return "deltaY" in e ? e.deltaY : "wheelDeltaY" in e ? -e.wheelDeltaY : "wheelDelta" in e ? -e.wheelDelta : 0
      },
      deltaZ: 0,
      deltaMode: 0
   }),
   sv = tt(iv),
   lv = [9, 13, 27, 32],
   pu = Nt && "CompositionEvent" in window,
   Fr = null;
Nt && "documentMode" in document && (Fr = document.documentMode);
var av = Nt && "TextEvent" in window && !Fr,
   $p = Nt && (!pu || Fr && 8 < Fr && 11 >= Fr),
   Uc = String.fromCharCode(32),
   Bc = !1;

function jp(e, t) {
   switch (e) {
      case "keyup":
         return lv.indexOf(t.keyCode) !== -1;
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

function Up(e) {
   return e = e.detail, typeof e == "object" && "data" in e ? e.data : null
}
var jn = !1;

function uv(e, t) {
   switch (e) {
      case "compositionend":
         return Up(t);
      case "keypress":
         return t.which !== 32 ? null : (Bc = !0, Uc);
      case "textInput":
         return e = t.data, e === Uc && Bc ? null : e;
      default:
         return null
   }
}

function cv(e, t) {
   if (jn) return e === "compositionend" || !pu && jp(e, t) ? (e = Fp(), fi = cu = Kt = null, jn = !1, e) : null;
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
         return $p && t.locale !== "ko" ? null : t.data;
      default:
         return null
   }
}
var fv = {
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

function Hc(e) {
   var t = e && e.nodeName && e.nodeName.toLowerCase();
   return t === "input" ? !!fv[e.type] : t === "textarea"
}

function Bp(e, t, n, r) {
   wp(r), t = Li(t, "onChange"), 0 < t.length && (n = new fu("onChange", "change", null, n, r), e.push({
      event: n,
      listeners: t
   }))
}
var $r = null,
   so = null;

function dv(e) {
   qp(e, 0)
}

function fs(e) {
   var t = Hn(e);
   if (dp(t)) return e
}

function pv(e, t) {
   if (e === "change") return t
}
var Hp = !1;
if (Nt) {
   var rl;
   if (Nt) {
      var ol = "oninput" in document;
      if (!ol) {
         var bc = document.createElement("div");
         bc.setAttribute("oninput", "return;"), ol = typeof bc.oninput == "function"
      }
      rl = ol
   } else rl = !1;
   Hp = rl && (!document.documentMode || 9 < document.documentMode)
}

function Wc() {
   $r && ($r.detachEvent("onpropertychange", bp), so = $r = null)
}

function bp(e) {
   if (e.propertyName === "value" && fs(so)) {
      var t = [];
      Bp(t, so, e, iu(e)), Cp(dv, t)
   }
}

function hv(e, t, n) {
   e === "focusin" ? (Wc(), $r = t, so = n, $r.attachEvent("onpropertychange", bp)) : e === "focusout" && Wc()
}

function mv(e) {
   if (e === "selectionchange" || e === "keyup" || e === "keydown") return fs(so)
}

function gv(e, t) {
   if (e === "click") return fs(t)
}

function vv(e, t) {
   if (e === "input" || e === "change") return fs(t)
}

function yv(e, t) {
   return e === t && (e !== 0 || 1 / e === 1 / t) || e !== e && t !== t
}
var St = typeof Object.is == "function" ? Object.is : yv;

function lo(e, t) {
   if (St(e, t)) return !0;
   if (typeof e != "object" || e === null || typeof t != "object" || t === null) return !1;
   var n = Object.keys(e),
      r = Object.keys(t);
   if (n.length !== r.length) return !1;
   for (r = 0; r < n.length; r++) {
      var o = n[r];
      if (!Nl.call(t, o) || !St(e[o], t[o])) return !1
   }
   return !0
}

function Gc(e) {
   for (; e && e.firstChild;) e = e.firstChild;
   return e
}

function Qc(e, t) {
   var n = Gc(e);
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
      n = Gc(n)
   }
}

function Wp(e, t) {
   return e && t ? e === t ? !0 : e && e.nodeType === 3 ? !1 : t && t.nodeType === 3 ? Wp(e, t.parentNode) : "contains" in e ? e.contains(t) : e.compareDocumentPosition ? !!(e.compareDocumentPosition(t) & 16) : !1 : !1
}

function Gp() {
   for (var e = window, t = Pi(); t instanceof e.HTMLIFrameElement;) {
      try {
         var n = typeof t.contentWindow.location.href == "string"
      } catch {
         n = !1
      }
      if (n) e = t.contentWindow;
      else break;
      t = Pi(e.document)
   }
   return t
}

function hu(e) {
   var t = e && e.nodeName && e.nodeName.toLowerCase();
   return t && (t === "input" && (e.type === "text" || e.type === "search" || e.type === "tel" || e.type === "url" || e.type === "password") || t === "textarea" || e.contentEditable === "true")
}

function wv(e) {
   var t = Gp(),
      n = e.focusedElem,
      r = e.selectionRange;
   if (t !== n && n && n.ownerDocument && Wp(n.ownerDocument.documentElement, n)) {
      if (r !== null && hu(n)) {
         if (t = r.start, e = r.end, e === void 0 && (e = t), "selectionStart" in n) n.selectionStart = t, n.selectionEnd = Math.min(e, n.value.length);
         else if (e = (t = n.ownerDocument || document) && t.defaultView || window, e.getSelection) {
            e = e.getSelection();
            var o = n.textContent.length,
               i = Math.min(r.start, o);
            r = r.end === void 0 ? i : Math.min(r.end, o), !e.extend && i > r && (o = r, r = i, i = o), o = Qc(n, i);
            var s = Qc(n, r);
            o && s && (e.rangeCount !== 1 || e.anchorNode !== o.node || e.anchorOffset !== o.offset || e.focusNode !== s.node || e.focusOffset !== s.offset) && (t = t.createRange(), t.setStart(o.node, o.offset), e.removeAllRanges(), i > r ? (e.addRange(t), e.extend(s.node, s.offset)) : (t.setEnd(s.node, s.offset), e.addRange(t)))
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
var Sv = Nt && "documentMode" in document && 11 >= document.documentMode,
   Un = null,
   ea = null,
   jr = null,
   ta = !1;

function Yc(e, t, n) {
   var r = n.window === n ? n.document : n.nodeType === 9 ? n : n.ownerDocument;
   ta || Un == null || Un !== Pi(r) || (r = Un, "selectionStart" in r && hu(r) ? r = {
      start: r.selectionStart,
      end: r.selectionEnd
   } : (r = (r.ownerDocument && r.ownerDocument.defaultView || window).getSelection(), r = {
      anchorNode: r.anchorNode,
      anchorOffset: r.anchorOffset,
      focusNode: r.focusNode,
      focusOffset: r.focusOffset
   }), jr && lo(jr, r) || (jr = r, r = Li(ea, "onSelect"), 0 < r.length && (t = new fu("onSelect", "select", null, t, n), e.push({
      event: t,
      listeners: r
   }), t.target = Un)))
}

function Go(e, t) {
   var n = {};
   return n[e.toLowerCase()] = t.toLowerCase(), n["Webkit" + e] = "webkit" + t, n["Moz" + e] = "moz" + t, n
}
var Bn = {
      animationend: Go("Animation", "AnimationEnd"),
      animationiteration: Go("Animation", "AnimationIteration"),
      animationstart: Go("Animation", "AnimationStart"),
      transitionend: Go("Transition", "TransitionEnd")
   },
   il = {},
   Qp = {};
Nt && (Qp = document.createElement("div").style, "AnimationEvent" in window || (delete Bn.animationend.animation, delete Bn.animationiteration.animation, delete Bn.animationstart.animation), "TransitionEvent" in window || delete Bn.transitionend.transition);

function ds(e) {
   if (il[e]) return il[e];
   if (!Bn[e]) return e;
   var t = Bn[e],
      n;
   for (n in t)
      if (t.hasOwnProperty(n) && n in Qp) return il[e] = t[n];
   return e
}
var Yp = ds("animationend"),
   Kp = ds("animationiteration"),
   Xp = ds("animationstart"),
   Zp = ds("transitionend"),
   Jp = new Map,
   Kc = "abort auxClick cancel canPlay canPlayThrough click close contextMenu copy cut drag dragEnd dragEnter dragExit dragLeave dragOver dragStart drop durationChange emptied encrypted ended error gotPointerCapture input invalid keyDown keyPress keyUp load loadedData loadedMetadata loadStart lostPointerCapture mouseDown mouseMove mouseOut mouseOver mouseUp paste pause play playing pointerCancel pointerDown pointerMove pointerOut pointerOver pointerUp progress rateChange reset resize seeked seeking stalled submit suspend timeUpdate touchCancel touchEnd touchStart volumeChange scroll toggle touchMove waiting wheel".split(" ");

function dn(e, t) {
   Jp.set(e, t), Mn(t, [e])
}
for (var sl = 0; sl < Kc.length; sl++) {
   var ll = Kc[sl],
      xv = ll.toLowerCase(),
      kv = ll[0].toUpperCase() + ll.slice(1);
   dn(xv, "on" + kv)
}
dn(Yp, "onAnimationEnd");
dn(Kp, "onAnimationIteration");
dn(Xp, "onAnimationStart");
dn("dblclick", "onDoubleClick");
dn("focusin", "onFocus");
dn("focusout", "onBlur");
dn(Zp, "onTransitionEnd");
lr("onMouseEnter", ["mouseout", "mouseover"]);
lr("onMouseLeave", ["mouseout", "mouseover"]);
lr("onPointerEnter", ["pointerout", "pointerover"]);
lr("onPointerLeave", ["pointerout", "pointerover"]);
Mn("onChange", "change click focusin focusout input keydown keyup selectionchange".split(" "));
Mn("onSelect", "focusout contextmenu dragend focusin keydown keyup mousedown mouseup selectionchange".split(" "));
Mn("onBeforeInput", ["compositionend", "keypress", "textInput", "paste"]);
Mn("onCompositionEnd", "compositionend focusout keydown keypress keyup mousedown".split(" "));
Mn("onCompositionStart", "compositionstart focusout keydown keypress keyup mousedown".split(" "));
Mn("onCompositionUpdate", "compositionupdate focusout keydown keypress keyup mousedown".split(" "));
var Nr = "abort canplay canplaythrough durationchange emptied encrypted ended error loadeddata loadedmetadata loadstart pause play playing progress ratechange resize seeked seeking stalled suspend timeupdate volumechange waiting".split(" "),
   Cv = new Set("cancel close invalid load scroll toggle".split(" ").concat(Nr));

function Xc(e, t, n) {
   var r = e.type || "unknown-event";
   e.currentTarget = n, xg(r, t, void 0, e), e.currentTarget = null
}

function qp(e, t) {
   t = (t & 4) !== 0;
   for (var n = 0; n < e.length; n++) {
      var r = e[n],
         o = r.event;
      r = r.listeners;
      e: {
         var i = void 0;
         if (t)
            for (var s = r.length - 1; 0 <= s; s--) {
               var l = r[s],
                  a = l.instance,
                  u = l.currentTarget;
               if (l = l.listener, a !== i && o.isPropagationStopped()) break e;
               Xc(o, l, u), i = a
            } else
               for (s = 0; s < r.length; s++) {
                  if (l = r[s], a = l.instance, u = l.currentTarget, l = l.listener, a !== i && o.isPropagationStopped()) break e;
                  Xc(o, l, u), i = a
               }
      }
   }
   if (Ti) throw e = Xl, Ti = !1, Xl = null, e
}

function re(e, t) {
   var n = t[sa];
   n === void 0 && (n = t[sa] = new Set);
   var r = e + "__bubble";
   n.has(r) || (eh(t, e, 2, !1), n.add(r))
}

function al(e, t, n) {
   var r = 0;
   t && (r |= 4), eh(n, e, r, t)
}
var Qo = "_reactListening" + Math.random().toString(36).slice(2);

function ao(e) {
   if (!e[Qo]) {
      e[Qo] = !0, lp.forEach(function (n) {
         n !== "selectionchange" && (Cv.has(n) || al(n, !1, e), al(n, !0, e))
      });
      var t = e.nodeType === 9 ? e : e.ownerDocument;
      t === null || t[Qo] || (t[Qo] = !0, al("selectionchange", !1, t))
   }
}

function eh(e, t, n, r) {
   switch (zp(t)) {
      case 1:
         var o = zg;
         break;
      case 4:
         o = Fg;
         break;
      default:
         o = uu
   }
   n = o.bind(null, t, n, e), o = void 0, !Kl || t !== "touchstart" && t !== "touchmove" && t !== "wheel" || (o = !0), r ? o !== void 0 ? e.addEventListener(t, n, {
      capture: !0,
      passive: o
   }) : e.addEventListener(t, n, !0) : o !== void 0 ? e.addEventListener(t, n, {
      passive: o
   }) : e.addEventListener(t, n, !1)
}

function ul(e, t, n, r, o) {
   var i = r;
   if ((t & 1) === 0 && (t & 2) === 0 && r !== null) e: for (;;) {
      if (r === null) return;
      var s = r.tag;
      if (s === 3 || s === 4) {
         var l = r.stateNode.containerInfo;
         if (l === o || l.nodeType === 8 && l.parentNode === o) break;
         if (s === 4)
            for (s = r.return; s !== null;) {
               var a = s.tag;
               if ((a === 3 || a === 4) && (a = s.stateNode.containerInfo, a === o || a.nodeType === 8 && a.parentNode === o)) return;
               s = s.return
            }
         for (; l !== null;) {
            if (s = Sn(l), s === null) return;
            if (a = s.tag, a === 5 || a === 6) {
               r = i = s;
               continue e
            }
            l = l.parentNode
         }
      }
      r = r.return
   }
   Cp(function () {
      var u = i,
         c = iu(n),
         f = [];
      e: {
         var d = Jp.get(e);
         if (d !== void 0) {
            var g = fu,
               v = e;
            switch (e) {
               case "keypress":
                  if (di(n) === 0) break e;
               case "keydown":
               case "keyup":
                  g = qg;
                  break;
               case "focusin":
                  v = "focus", g = nl;
                  break;
               case "focusout":
                  v = "blur", g = nl;
                  break;
               case "beforeblur":
               case "afterblur":
                  g = nl;
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
                  g = Fc;
                  break;
               case "drag":
               case "dragend":
               case "dragenter":
               case "dragexit":
               case "dragleave":
               case "dragover":
               case "dragstart":
               case "drop":
                  g = Ug;
                  break;
               case "touchcancel":
               case "touchend":
               case "touchmove":
               case "touchstart":
                  g = nv;
                  break;
               case Yp:
               case Kp:
               case Xp:
                  g = bg;
                  break;
               case Zp:
                  g = ov;
                  break;
               case "scroll":
                  g = $g;
                  break;
               case "wheel":
                  g = sv;
                  break;
               case "copy":
               case "cut":
               case "paste":
                  g = Gg;
                  break;
               case "gotpointercapture":
               case "lostpointercapture":
               case "pointercancel":
               case "pointerdown":
               case "pointermove":
               case "pointerout":
               case "pointerover":
               case "pointerup":
                  g = jc
            }
            var w = (t & 4) !== 0,
               k = !w && e === "scroll",
               m = w ? d !== null ? d + "Capture" : null : d;
            w = [];
            for (var p = u, h; p !== null;) {
               h = p;
               var y = h.stateNode;
               if (h.tag === 5 && y !== null && (h = y, m !== null && (y = no(p, m), y != null && w.push(uo(p, y, h)))), k) break;
               p = p.return
            }
            0 < w.length && (d = new g(d, v, null, n, c), f.push({
               event: d,
               listeners: w
            }))
         }
      }
      if ((t & 7) === 0) {
         e: {
            if (d = e === "mouseover" || e === "pointerover", g = e === "mouseout" || e === "pointerout", d && n !== Ql && (v = n.relatedTarget || n.fromElement) && (Sn(v) || v[It])) break e;
            if ((g || d) && (d = c.window === c ? c : (d = c.ownerDocument) ? d.defaultView || d.parentWindow : window, g ? (v = n.relatedTarget || n.toElement, g = u, v = v ? Sn(v) : null, v !== null && (k = On(v), v !== k || v.tag !== 5 && v.tag !== 6) && (v = null)) : (g = null, v = u), g !== v)) {
               if (w = Fc, y = "onMouseLeave", m = "onMouseEnter", p = "mouse", (e === "pointerout" || e === "pointerover") && (w = jc, y = "onPointerLeave", m = "onPointerEnter", p = "pointer"), k = g == null ? d : Hn(g), h = v == null ? d : Hn(v), d = new w(y, p + "leave", g, n, c), d.target = k, d.relatedTarget = h, y = null, Sn(c) === u && (w = new w(m, p + "enter", v, n, c), w.target = h, w.relatedTarget = k, y = w), k = y, g && v) t: {
                  for (w = g, m = v, p = 0, h = w; h; h = In(h)) p++;
                  for (h = 0, y = m; y; y = In(y)) h++;
                  for (; 0 < p - h;) w = In(w),
                  p--;
                  for (; 0 < h - p;) m = In(m),
                  h--;
                  for (; p--;) {
                     if (w === m || m !== null && w === m.alternate) break t;
                     w = In(w), m = In(m)
                  }
                  w = null
               }
               else w = null;
               g !== null && Zc(f, d, g, w, !1), v !== null && k !== null && Zc(f, k, v, w, !0)
            }
         }
         e: {
            if (d = u ? Hn(u) : window, g = d.nodeName && d.nodeName.toLowerCase(), g === "select" || g === "input" && d.type === "file") var x = pv;
            else if (Hc(d))
               if (Hp) x = vv;
               else {
                  x = mv;
                  var E = hv
               }
            else(g = d.nodeName) && g.toLowerCase() === "input" && (d.type === "checkbox" || d.type === "radio") && (x = gv);
            if (x && (x = x(e, u))) {
               Bp(f, x, n, c);
               break e
            }
            E && E(e, d, u),
            e === "focusout" && (E = d._wrapperState) && E.controlled && d.type === "number" && Bl(d, "number", d.value)
         }
         switch (E = u ? Hn(u) : window, e) {
            case "focusin":
               (Hc(E) || E.contentEditable === "true") && (Un = E, ea = u, jr = null);
               break;
            case "focusout":
               jr = ea = Un = null;
               break;
            case "mousedown":
               ta = !0;
               break;
            case "contextmenu":
            case "mouseup":
            case "dragend":
               ta = !1, Yc(f, n, c);
               break;
            case "selectionchange":
               if (Sv) break;
            case "keydown":
            case "keyup":
               Yc(f, n, c)
         }
         var T;
         if (pu) e: {
            switch (e) {
               case "compositionstart":
                  var A = "onCompositionStart";
                  break e;
               case "compositionend":
                  A = "onCompositionEnd";
                  break e;
               case "compositionupdate":
                  A = "onCompositionUpdate";
                  break e
            }
            A = void 0
         }
         else jn ? jp(e, n) && (A = "onCompositionEnd") : e === "keydown" && n.keyCode === 229 && (A = "onCompositionStart");A && ($p && n.locale !== "ko" && (jn || A !== "onCompositionStart" ? A === "onCompositionEnd" && jn && (T = Fp()) : (Kt = c, cu = "value" in Kt ? Kt.value : Kt.textContent, jn = !0)), E = Li(u, A), 0 < E.length && (A = new $c(A, e, null, n, c), f.push({
            event: A,
            listeners: E
         }), T ? A.data = T : (T = Up(n), T !== null && (A.data = T)))),
         (T = av ? uv(e, n) : cv(e, n)) && (u = Li(u, "onBeforeInput"), 0 < u.length && (c = new $c("onBeforeInput", "beforeinput", null, n, c), f.push({
            event: c,
            listeners: u
         }), c.data = T))
      }
      qp(f, t)
   })
}

function uo(e, t, n) {
   return {
      instance: e,
      listener: t,
      currentTarget: n
   }
}

function Li(e, t) {
   for (var n = t + "Capture", r = []; e !== null;) {
      var o = e,
         i = o.stateNode;
      o.tag === 5 && i !== null && (o = i, i = no(e, n), i != null && r.unshift(uo(e, i, o)), i = no(e, t), i != null && r.push(uo(e, i, o))), e = e.return
   }
   return r
}

function In(e) {
   if (e === null) return null;
   do e = e.return; while (e && e.tag !== 5);
   return e || null
}

function Zc(e, t, n, r, o) {
   for (var i = t._reactName, s = []; n !== null && n !== r;) {
      var l = n,
         a = l.alternate,
         u = l.stateNode;
      if (a !== null && a === r) break;
      l.tag === 5 && u !== null && (l = u, o ? (a = no(n, i), a != null && s.unshift(uo(n, a, l))) : o || (a = no(n, i), a != null && s.push(uo(n, a, l)))), n = n.return
   }
   s.length !== 0 && e.push({
      event: t,
      listeners: s
   })
}
var Pv = /\r\n?/g,
   Ev = /\u0000|\uFFFD/g;

function Jc(e) {
   return (typeof e == "string" ? e : "" + e).replace(Pv, `
`).replace(Ev, "")
}

function Yo(e, t, n) {
   if (t = Jc(t), Jc(e) !== t && n) throw Error(P(425))
}

function Mi() {}
var na = null,
   ra = null;

function oa(e, t) {
   return e === "textarea" || e === "noscript" || typeof t.children == "string" || typeof t.children == "number" || typeof t.dangerouslySetInnerHTML == "object" && t.dangerouslySetInnerHTML !== null && t.dangerouslySetInnerHTML.__html != null
}
var ia = typeof setTimeout == "function" ? setTimeout : void 0,
   Tv = typeof clearTimeout == "function" ? clearTimeout : void 0,
   qc = typeof Promise == "function" ? Promise : void 0,
   _v = typeof queueMicrotask == "function" ? queueMicrotask : typeof qc != "undefined" ? function (e) {
      return qc.resolve(null).then(e).catch(Av)
   } : ia;

function Av(e) {
   setTimeout(function () {
      throw e
   })
}

function cl(e, t) {
   var n = t,
      r = 0;
   do {
      var o = n.nextSibling;
      if (e.removeChild(n), o && o.nodeType === 8)
         if (n = o.data, n === "/$") {
            if (r === 0) {
               e.removeChild(o), io(t);
               return
            }
            r--
         } else n !== "$" && n !== "$?" && n !== "$!" || r++;
      n = o
   } while (n);
   io(t)
}

function nn(e) {
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

function ef(e) {
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
var wr = Math.random().toString(36).slice(2),
   Pt = "__reactFiber$" + wr,
   co = "__reactProps$" + wr,
   It = "__reactContainer$" + wr,
   sa = "__reactEvents$" + wr,
   Rv = "__reactListeners$" + wr,
   Vv = "__reactHandles$" + wr;

function Sn(e) {
   var t = e[Pt];
   if (t) return t;
   for (var n = e.parentNode; n;) {
      if (t = n[It] || n[Pt]) {
         if (n = t.alternate, t.child !== null || n !== null && n.child !== null)
            for (e = ef(e); e !== null;) {
               if (n = e[Pt]) return n;
               e = ef(e)
            }
         return t
      }
      e = n, n = e.parentNode
   }
   return null
}

function Ro(e) {
   return e = e[Pt] || e[It], !e || e.tag !== 5 && e.tag !== 6 && e.tag !== 13 && e.tag !== 3 ? null : e
}

function Hn(e) {
   if (e.tag === 5 || e.tag === 6) return e.stateNode;
   throw Error(P(33))
}

function ps(e) {
   return e[co] || null
}
var la = [],
   bn = -1;

function pn(e) {
   return {
      current: e
   }
}

function oe(e) {
   0 > bn || (e.current = la[bn], la[bn] = null, bn--)
}

function te(e, t) {
   bn++, la[bn] = e.current, e.current = t
}
var cn = {},
   Ie = pn(cn),
   Ge = pn(!1),
   Tn = cn;

function ar(e, t) {
   var n = e.type.contextTypes;
   if (!n) return cn;
   var r = e.stateNode;
   if (r && r.__reactInternalMemoizedUnmaskedChildContext === t) return r.__reactInternalMemoizedMaskedChildContext;
   var o = {},
      i;
   for (i in n) o[i] = t[i];
   return r && (e = e.stateNode, e.__reactInternalMemoizedUnmaskedChildContext = t, e.__reactInternalMemoizedMaskedChildContext = o), o
}

function Qe(e) {
   return e = e.childContextTypes, e != null
}

function Oi() {
   oe(Ge), oe(Ie)
}

function tf(e, t, n) {
   if (Ie.current !== cn) throw Error(P(168));
   te(Ie, t), te(Ge, n)
}

function th(e, t, n) {
   var r = e.stateNode;
   if (t = t.childContextTypes, typeof r.getChildContext != "function") return n;
   r = r.getChildContext();
   for (var o in r)
      if (!(o in t)) throw Error(P(108, hg(e) || "Unknown", o));
   return ce({}, n, r)
}

function Di(e) {
   return e = (e = e.stateNode) && e.__reactInternalMemoizedMergedChildContext || cn, Tn = Ie.current, te(Ie, e), te(Ge, Ge.current), !0
}

function nf(e, t, n) {
   var r = e.stateNode;
   if (!r) throw Error(P(169));
   n ? (e = th(e, t, Tn), r.__reactInternalMemoizedMergedChildContext = e, oe(Ge), oe(Ie), te(Ie, e)) : oe(Ge), te(Ge, n)
}
var Vt = null,
   hs = !1,
   fl = !1;

function nh(e) {
   Vt === null ? Vt = [e] : Vt.push(e)
}

function Lv(e) {
   hs = !0, nh(e)
}

function hn() {
   if (!fl && Vt !== null) {
      fl = !0;
      var e = 0,
         t = X;
      try {
         var n = Vt;
         for (X = 1; e < n.length; e++) {
            var r = n[e];
            do r = r(!0); while (r !== null)
         }
         Vt = null, hs = !1
      } catch (o) {
         throw Vt !== null && (Vt = Vt.slice(e + 1)), _p(su, hn), o
      } finally {
         X = t, fl = !1
      }
   }
   return null
}
var Wn = [],
   Gn = 0,
   Ni = null,
   Ii = 0,
   rt = [],
   ot = 0,
   _n = null,
   Lt = 1,
   Mt = "";

function vn(e, t) {
   Wn[Gn++] = Ii, Wn[Gn++] = Ni, Ni = e, Ii = t
}

function rh(e, t, n) {
   rt[ot++] = Lt, rt[ot++] = Mt, rt[ot++] = _n, _n = e;
   var r = Lt;
   e = Mt;
   var o = 32 - vt(r) - 1;
   r &= ~(1 << o), n += 1;
   var i = 32 - vt(t) + o;
   if (30 < i) {
      var s = o - o % 5;
      i = (r & (1 << s) - 1).toString(32), r >>= s, o -= s, Lt = 1 << 32 - vt(t) + o | n << o | r, Mt = i + e
   } else Lt = 1 << i | n << o | r, Mt = e
}

function mu(e) {
   e.return !== null && (vn(e, 1), rh(e, 1, 0))
}

function gu(e) {
   for (; e === Ni;) Ni = Wn[--Gn], Wn[Gn] = null, Ii = Wn[--Gn], Wn[Gn] = null;
   for (; e === _n;) _n = rt[--ot], rt[ot] = null, Mt = rt[--ot], rt[ot] = null, Lt = rt[--ot], rt[ot] = null
}
var Ze = null,
   Xe = null,
   ie = !1,
   mt = null;

function oh(e, t) {
   var n = it(5, null, null, 0);
   n.elementType = "DELETED", n.stateNode = t, n.return = e, t = e.deletions, t === null ? (e.deletions = [n], e.flags |= 16) : t.push(n)
}

function rf(e, t) {
   switch (e.tag) {
      case 5:
         var n = e.type;
         return t = t.nodeType !== 1 || n.toLowerCase() !== t.nodeName.toLowerCase() ? null : t, t !== null ? (e.stateNode = t, Ze = e, Xe = nn(t.firstChild), !0) : !1;
      case 6:
         return t = e.pendingProps === "" || t.nodeType !== 3 ? null : t, t !== null ? (e.stateNode = t, Ze = e, Xe = null, !0) : !1;
      case 13:
         return t = t.nodeType !== 8 ? null : t, t !== null ? (n = _n !== null ? {
            id: Lt,
            overflow: Mt
         } : null, e.memoizedState = {
            dehydrated: t,
            treeContext: n,
            retryLane: 1073741824
         }, n = it(18, null, null, 0), n.stateNode = t, n.return = e, e.child = n, Ze = e, Xe = null, !0) : !1;
      default:
         return !1
   }
}

function aa(e) {
   return (e.mode & 1) !== 0 && (e.flags & 128) === 0
}

function ua(e) {
   if (ie) {
      var t = Xe;
      if (t) {
         var n = t;
         if (!rf(e, t)) {
            if (aa(e)) throw Error(P(418));
            t = nn(n.nextSibling);
            var r = Ze;
            t && rf(e, t) ? oh(r, n) : (e.flags = e.flags & -4097 | 2, ie = !1, Ze = e)
         }
      } else {
         if (aa(e)) throw Error(P(418));
         e.flags = e.flags & -4097 | 2, ie = !1, Ze = e
      }
   }
}

function of (e) {
   for (e = e.return; e !== null && e.tag !== 5 && e.tag !== 3 && e.tag !== 13;) e = e.return;
   Ze = e
}

function Ko(e) {
   if (e !== Ze) return !1;
   if (!ie) return of(e), ie = !0, !1;
   var t;
   if ((t = e.tag !== 3) && !(t = e.tag !== 5) && (t = e.type, t = t !== "head" && t !== "body" && !oa(e.type, e.memoizedProps)), t && (t = Xe)) {
      if (aa(e)) throw ih(), Error(P(418));
      for (; t;) oh(e, t), t = nn(t.nextSibling)
   }
   if ( of (e), e.tag === 13) {
      if (e = e.memoizedState, e = e !== null ? e.dehydrated : null, !e) throw Error(P(317));
      e: {
         for (e = e.nextSibling, t = 0; e;) {
            if (e.nodeType === 8) {
               var n = e.data;
               if (n === "/$") {
                  if (t === 0) {
                     Xe = nn(e.nextSibling);
                     break e
                  }
                  t--
               } else n !== "$" && n !== "$!" && n !== "$?" || t++
            }
            e = e.nextSibling
         }
         Xe = null
      }
   } else Xe = Ze ? nn(e.stateNode.nextSibling) : null;
   return !0
}

function ih() {
   for (var e = Xe; e;) e = nn(e.nextSibling)
}

function ur() {
   Xe = Ze = null, ie = !1
}

function vu(e) {
   mt === null ? mt = [e] : mt.push(e)
}
var Mv = jt.ReactCurrentBatchConfig;

function pt(e, t) {
   if (e && e.defaultProps) {
      t = ce({}, t), e = e.defaultProps;
      for (var n in e) t[n] === void 0 && (t[n] = e[n]);
      return t
   }
   return t
}
var zi = pn(null),
   Fi = null,
   Qn = null,
   yu = null;

function wu() {
   yu = Qn = Fi = null
}

function Su(e) {
   var t = zi.current;
   oe(zi), e._currentValue = t
}

function ca(e, t, n) {
   for (; e !== null;) {
      var r = e.alternate;
      if ((e.childLanes & t) !== t ? (e.childLanes |= t, r !== null && (r.childLanes |= t)) : r !== null && (r.childLanes & t) !== t && (r.childLanes |= t), e === n) break;
      e = e.return
   }
}

function rr(e, t) {
   Fi = e, yu = Qn = null, e = e.dependencies, e !== null && e.firstContext !== null && ((e.lanes & t) !== 0 && (We = !0), e.firstContext = null)
}

function at(e) {
   var t = e._currentValue;
   if (yu !== e)
      if (e = {
            context: e,
            memoizedValue: t,
            next: null
         }, Qn === null) {
         if (Fi === null) throw Error(P(308));
         Qn = e, Fi.dependencies = {
            lanes: 0,
            firstContext: e
         }
      } else Qn = Qn.next = e;
   return t
}
var xn = null;

function xu(e) {
   xn === null ? xn = [e] : xn.push(e)
}

function sh(e, t, n, r) {
   var o = t.interleaved;
   return o === null ? (n.next = n, xu(t)) : (n.next = o.next, o.next = n), t.interleaved = n, zt(e, r)
}

function zt(e, t) {
   e.lanes |= t;
   var n = e.alternate;
   for (n !== null && (n.lanes |= t), n = e, e = e.return; e !== null;) e.childLanes |= t, n = e.alternate, n !== null && (n.childLanes |= t), n = e, e = e.return;
   return n.tag === 3 ? n.stateNode : null
}
var Wt = !1;

function ku(e) {
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

function lh(e, t) {
   e = e.updateQueue, t.updateQueue === e && (t.updateQueue = {
      baseState: e.baseState,
      firstBaseUpdate: e.firstBaseUpdate,
      lastBaseUpdate: e.lastBaseUpdate,
      shared: e.shared,
      effects: e.effects
   })
}

function Dt(e, t) {
   return {
      eventTime: e,
      lane: t,
      tag: 0,
      payload: null,
      callback: null,
      next: null
   }
}

function rn(e, t, n) {
   var r = e.updateQueue;
   if (r === null) return null;
   if (r = r.shared, (W & 2) !== 0) {
      var o = r.pending;
      return o === null ? t.next = t : (t.next = o.next, o.next = t), r.pending = t, zt(e, n)
   }
   return o = r.interleaved, o === null ? (t.next = t, xu(r)) : (t.next = o.next, o.next = t), r.interleaved = t, zt(e, n)
}

function pi(e, t, n) {
   if (t = t.updateQueue, t !== null && (t = t.shared, (n & 4194240) !== 0)) {
      var r = t.lanes;
      r &= e.pendingLanes, n |= r, t.lanes = n, lu(e, n)
   }
}

function sf(e, t) {
   var n = e.updateQueue,
      r = e.alternate;
   if (r !== null && (r = r.updateQueue, n === r)) {
      var o = null,
         i = null;
      if (n = n.firstBaseUpdate, n !== null) {
         do {
            var s = {
               eventTime: n.eventTime,
               lane: n.lane,
               tag: n.tag,
               payload: n.payload,
               callback: n.callback,
               next: null
            };
            i === null ? o = i = s : i = i.next = s, n = n.next
         } while (n !== null);
         i === null ? o = i = t : i = i.next = t
      } else o = i = t;
      n = {
         baseState: r.baseState,
         firstBaseUpdate: o,
         lastBaseUpdate: i,
         shared: r.shared,
         effects: r.effects
      }, e.updateQueue = n;
      return
   }
   e = n.lastBaseUpdate, e === null ? n.firstBaseUpdate = t : e.next = t, n.lastBaseUpdate = t
}

function $i(e, t, n, r) {
   var o = e.updateQueue;
   Wt = !1;
   var i = o.firstBaseUpdate,
      s = o.lastBaseUpdate,
      l = o.shared.pending;
   if (l !== null) {
      o.shared.pending = null;
      var a = l,
         u = a.next;
      a.next = null, s === null ? i = u : s.next = u, s = a;
      var c = e.alternate;
      c !== null && (c = c.updateQueue, l = c.lastBaseUpdate, l !== s && (l === null ? c.firstBaseUpdate = u : l.next = u, c.lastBaseUpdate = a))
   }
   if (i !== null) {
      var f = o.baseState;
      s = 0, c = u = a = null, l = i;
      do {
         var d = l.lane,
            g = l.eventTime;
         if ((r & d) === d) {
            c !== null && (c = c.next = {
               eventTime: g,
               lane: 0,
               tag: l.tag,
               payload: l.payload,
               callback: l.callback,
               next: null
            });
            e: {
               var v = e,
                  w = l;
               switch (d = t, g = n, w.tag) {
                  case 1:
                     if (v = w.payload, typeof v == "function") {
                        f = v.call(g, f, d);
                        break e
                     }
                     f = v;
                     break e;
                  case 3:
                     v.flags = v.flags & -65537 | 128;
                  case 0:
                     if (v = w.payload, d = typeof v == "function" ? v.call(g, f, d) : v, d == null) break e;
                     f = ce({}, f, d);
                     break e;
                  case 2:
                     Wt = !0
               }
            }
            l.callback !== null && l.lane !== 0 && (e.flags |= 64, d = o.effects, d === null ? o.effects = [l] : d.push(l))
         } else g = {
            eventTime: g,
            lane: d,
            tag: l.tag,
            payload: l.payload,
            callback: l.callback,
            next: null
         }, c === null ? (u = c = g, a = f) : c = c.next = g, s |= d;
         if (l = l.next, l === null) {
            if (l = o.shared.pending, l === null) break;
            d = l, l = d.next, d.next = null, o.lastBaseUpdate = d, o.shared.pending = null
         }
      } while (1);
      if (c === null && (a = f), o.baseState = a, o.firstBaseUpdate = u, o.lastBaseUpdate = c, t = o.shared.interleaved, t !== null) {
         o = t;
         do s |= o.lane, o = o.next; while (o !== t)
      } else i === null && (o.shared.lanes = 0);
      Rn |= s, e.lanes = s, e.memoizedState = f
   }
}

function lf(e, t, n) {
   if (e = t.effects, t.effects = null, e !== null)
      for (t = 0; t < e.length; t++) {
         var r = e[t],
            o = r.callback;
         if (o !== null) {
            if (r.callback = null, r = n, typeof o != "function") throw Error(P(191, o));
            o.call(r)
         }
      }
}
var ah = new sp.Component().refs;

function fa(e, t, n, r) {
   t = e.memoizedState, n = n(r, t), n = n == null ? t : ce({}, t, n), e.memoizedState = n, e.lanes === 0 && (e.updateQueue.baseState = n)
}
var ms = {
   isMounted: function (e) {
      return (e = e._reactInternals) ? On(e) === e : !1
   },
   enqueueSetState: function (e, t, n) {
      e = e._reactInternals;
      var r = $e(),
         o = sn(e),
         i = Dt(r, o);
      i.payload = t, n != null && (i.callback = n), t = rn(e, i, o), t !== null && (yt(t, e, o, r), pi(t, e, o))
   },
   enqueueReplaceState: function (e, t, n) {
      e = e._reactInternals;
      var r = $e(),
         o = sn(e),
         i = Dt(r, o);
      i.tag = 1, i.payload = t, n != null && (i.callback = n), t = rn(e, i, o), t !== null && (yt(t, e, o, r), pi(t, e, o))
   },
   enqueueForceUpdate: function (e, t) {
      e = e._reactInternals;
      var n = $e(),
         r = sn(e),
         o = Dt(n, r);
      o.tag = 2, t != null && (o.callback = t), t = rn(e, o, r), t !== null && (yt(t, e, r, n), pi(t, e, r))
   }
};

function af(e, t, n, r, o, i, s) {
   return e = e.stateNode, typeof e.shouldComponentUpdate == "function" ? e.shouldComponentUpdate(r, i, s) : t.prototype && t.prototype.isPureReactComponent ? !lo(n, r) || !lo(o, i) : !0
}

function uh(e, t, n) {
   var r = !1,
      o = cn,
      i = t.contextType;
   return typeof i == "object" && i !== null ? i = at(i) : (o = Qe(t) ? Tn : Ie.current, r = t.contextTypes, i = (r = r != null) ? ar(e, o) : cn), t = new t(n, i), e.memoizedState = t.state !== null && t.state !== void 0 ? t.state : null, t.updater = ms, e.stateNode = t, t._reactInternals = e, r && (e = e.stateNode, e.__reactInternalMemoizedUnmaskedChildContext = o, e.__reactInternalMemoizedMaskedChildContext = i), t
}

function uf(e, t, n, r) {
   e = t.state, typeof t.componentWillReceiveProps == "function" && t.componentWillReceiveProps(n, r), typeof t.UNSAFE_componentWillReceiveProps == "function" && t.UNSAFE_componentWillReceiveProps(n, r), t.state !== e && ms.enqueueReplaceState(t, t.state, null)
}

function da(e, t, n, r) {
   var o = e.stateNode;
   o.props = n, o.state = e.memoizedState, o.refs = ah, ku(e);
   var i = t.contextType;
   typeof i == "object" && i !== null ? o.context = at(i) : (i = Qe(t) ? Tn : Ie.current, o.context = ar(e, i)), o.state = e.memoizedState, i = t.getDerivedStateFromProps, typeof i == "function" && (fa(e, t, i, n), o.state = e.memoizedState), typeof t.getDerivedStateFromProps == "function" || typeof o.getSnapshotBeforeUpdate == "function" || typeof o.UNSAFE_componentWillMount != "function" && typeof o.componentWillMount != "function" || (t = o.state, typeof o.componentWillMount == "function" && o.componentWillMount(), typeof o.UNSAFE_componentWillMount == "function" && o.UNSAFE_componentWillMount(), t !== o.state && ms.enqueueReplaceState(o, o.state, null), $i(e, n, o, r), o.state = e.memoizedState), typeof o.componentDidMount == "function" && (e.flags |= 4194308)
}

function _r(e, t, n) {
   if (e = n.ref, e !== null && typeof e != "function" && typeof e != "object") {
      if (n._owner) {
         if (n = n._owner, n) {
            if (n.tag !== 1) throw Error(P(309));
            var r = n.stateNode
         }
         if (!r) throw Error(P(147, e));
         var o = r,
            i = "" + e;
         return t !== null && t.ref !== null && typeof t.ref == "function" && t.ref._stringRef === i ? t.ref : (t = function (s) {
            var l = o.refs;
            l === ah && (l = o.refs = {}), s === null ? delete l[i] : l[i] = s
         }, t._stringRef = i, t)
      }
      if (typeof e != "string") throw Error(P(284));
      if (!n._owner) throw Error(P(290, e))
   }
   return e
}

function Xo(e, t) {
   throw e = Object.prototype.toString.call(t), Error(P(31, e === "[object Object]" ? "object with keys {" + Object.keys(t).join(", ") + "}" : e))
}

function cf(e) {
   var t = e._init;
   return t(e._payload)
}

function ch(e) {
   function t(m, p) {
      if (e) {
         var h = m.deletions;
         h === null ? (m.deletions = [p], m.flags |= 16) : h.push(p)
      }
   }

   function n(m, p) {
      if (!e) return null;
      for (; p !== null;) t(m, p), p = p.sibling;
      return null
   }

   function r(m, p) {
      for (m = new Map; p !== null;) p.key !== null ? m.set(p.key, p) : m.set(p.index, p), p = p.sibling;
      return m
   }

   function o(m, p) {
      return m = ln(m, p), m.index = 0, m.sibling = null, m
   }

   function i(m, p, h) {
      return m.index = h, e ? (h = m.alternate, h !== null ? (h = h.index, h < p ? (m.flags |= 2, p) : h) : (m.flags |= 2, p)) : (m.flags |= 1048576, p)
   }

   function s(m) {
      return e && m.alternate === null && (m.flags |= 2), m
   }

   function l(m, p, h, y) {
      return p === null || p.tag !== 6 ? (p = yl(h, m.mode, y), p.return = m, p) : (p = o(p, h), p.return = m, p)
   }

   function a(m, p, h, y) {
      var x = h.type;
      return x === $n ? c(m, p, h.props.children, y, h.key) : p !== null && (p.elementType === x || typeof x == "object" && x !== null && x.$$typeof === bt && cf(x) === p.type) ? (y = o(p, h.props), y.ref = _r(m, p, h), y.return = m, y) : (y = wi(h.type, h.key, h.props, null, m.mode, y), y.ref = _r(m, p, h), y.return = m, y)
   }

   function u(m, p, h, y) {
      return p === null || p.tag !== 4 || p.stateNode.containerInfo !== h.containerInfo || p.stateNode.implementation !== h.implementation ? (p = wl(h, m.mode, y), p.return = m, p) : (p = o(p, h.children || []), p.return = m, p)
   }

   function c(m, p, h, y, x) {
      return p === null || p.tag !== 7 ? (p = En(h, m.mode, y, x), p.return = m, p) : (p = o(p, h), p.return = m, p)
   }

   function f(m, p, h) {
      if (typeof p == "string" && p !== "" || typeof p == "number") return p = yl("" + p, m.mode, h), p.return = m, p;
      if (typeof p == "object" && p !== null) {
         switch (p.$$typeof) {
            case $o:
               return h = wi(p.type, p.key, p.props, null, m.mode, h), h.ref = _r(m, null, p), h.return = m, h;
            case Fn:
               return p = wl(p, m.mode, h), p.return = m, p;
            case bt:
               var y = p._init;
               return f(m, y(p._payload), h)
         }
         if (Or(p) || kr(p)) return p = En(p, m.mode, h, null), p.return = m, p;
         Xo(m, p)
      }
      return null
   }

   function d(m, p, h, y) {
      var x = p !== null ? p.key : null;
      if (typeof h == "string" && h !== "" || typeof h == "number") return x !== null ? null : l(m, p, "" + h, y);
      if (typeof h == "object" && h !== null) {
         switch (h.$$typeof) {
            case $o:
               return h.key === x ? a(m, p, h, y) : null;
            case Fn:
               return h.key === x ? u(m, p, h, y) : null;
            case bt:
               return x = h._init, d(m, p, x(h._payload), y)
         }
         if (Or(h) || kr(h)) return x !== null ? null : c(m, p, h, y, null);
         Xo(m, h)
      }
      return null
   }

   function g(m, p, h, y, x) {
      if (typeof y == "string" && y !== "" || typeof y == "number") return m = m.get(h) || null, l(p, m, "" + y, x);
      if (typeof y == "object" && y !== null) {
         switch (y.$$typeof) {
            case $o:
               return m = m.get(y.key === null ? h : y.key) || null, a(p, m, y, x);
            case Fn:
               return m = m.get(y.key === null ? h : y.key) || null, u(p, m, y, x);
            case bt:
               var E = y._init;
               return g(m, p, h, E(y._payload), x)
         }
         if (Or(y) || kr(y)) return m = m.get(h) || null, c(p, m, y, x, null);
         Xo(p, y)
      }
      return null
   }

   function v(m, p, h, y) {
      for (var x = null, E = null, T = p, A = p = 0, I = null; T !== null && A < h.length; A++) {
         T.index > A ? (I = T, T = null) : I = T.sibling;
         var D = d(m, T, h[A], y);
         if (D === null) {
            T === null && (T = I);
            break
         }
         e && T && D.alternate === null && t(m, T), p = i(D, p, A), E === null ? x = D : E.sibling = D, E = D, T = I
      }
      if (A === h.length) return n(m, T), ie && vn(m, A), x;
      if (T === null) {
         for (; A < h.length; A++) T = f(m, h[A], y), T !== null && (p = i(T, p, A), E === null ? x = T : E.sibling = T, E = T);
         return ie && vn(m, A), x
      }
      for (T = r(m, T); A < h.length; A++) I = g(T, m, A, h[A], y), I !== null && (e && I.alternate !== null && T.delete(I.key === null ? A : I.key), p = i(I, p, A), E === null ? x = I : E.sibling = I, E = I);
      return e && T.forEach(function (se) {
         return t(m, se)
      }), ie && vn(m, A), x
   }

   function w(m, p, h, y) {
      var x = kr(h);
      if (typeof x != "function") throw Error(P(150));
      if (h = x.call(h), h == null) throw Error(P(151));
      for (var E = x = null, T = p, A = p = 0, I = null, D = h.next(); T !== null && !D.done; A++, D = h.next()) {
         T.index > A ? (I = T, T = null) : I = T.sibling;
         var se = d(m, T, D.value, y);
         if (se === null) {
            T === null && (T = I);
            break
         }
         e && T && se.alternate === null && t(m, T), p = i(se, p, A), E === null ? x = se : E.sibling = se, E = se, T = I
      }
      if (D.done) return n(m, T), ie && vn(m, A), x;
      if (T === null) {
         for (; !D.done; A++, D = h.next()) D = f(m, D.value, y), D !== null && (p = i(D, p, A), E === null ? x = D : E.sibling = D, E = D);
         return ie && vn(m, A), x
      }
      for (T = r(m, T); !D.done; A++, D = h.next()) D = g(T, m, A, D.value, y), D !== null && (e && D.alternate !== null && T.delete(D.key === null ? A : D.key), p = i(D, p, A), E === null ? x = D : E.sibling = D, E = D);
      return e && T.forEach(function (J) {
         return t(m, J)
      }), ie && vn(m, A), x
   }

   function k(m, p, h, y) {
      if (typeof h == "object" && h !== null && h.type === $n && h.key === null && (h = h.props.children), typeof h == "object" && h !== null) {
         switch (h.$$typeof) {
            case $o:
               e: {
                  for (var x = h.key, E = p; E !== null;) {
                     if (E.key === x) {
                        if (x = h.type, x === $n) {
                           if (E.tag === 7) {
                              n(m, E.sibling), p = o(E, h.props.children), p.return = m, m = p;
                              break e
                           }
                        } else if (E.elementType === x || typeof x == "object" && x !== null && x.$$typeof === bt && cf(x) === E.type) {
                           n(m, E.sibling), p = o(E, h.props), p.ref = _r(m, E, h), p.return = m, m = p;
                           break e
                        }
                        n(m, E);
                        break
                     } else t(m, E);
                     E = E.sibling
                  }
                  h.type === $n ? (p = En(h.props.children, m.mode, y, h.key), p.return = m, m = p) : (y = wi(h.type, h.key, h.props, null, m.mode, y), y.ref = _r(m, p, h), y.return = m, m = y)
               }
               return s(m);
            case Fn:
               e: {
                  for (E = h.key; p !== null;) {
                     if (p.key === E)
                        if (p.tag === 4 && p.stateNode.containerInfo === h.containerInfo && p.stateNode.implementation === h.implementation) {
                           n(m, p.sibling), p = o(p, h.children || []), p.return = m, m = p;
                           break e
                        } else {
                           n(m, p);
                           break
                        }
                     else t(m, p);
                     p = p.sibling
                  }
                  p = wl(h, m.mode, y),
                  p.return = m,
                  m = p
               }
               return s(m);
            case bt:
               return E = h._init, k(m, p, E(h._payload), y)
         }
         if (Or(h)) return v(m, p, h, y);
         if (kr(h)) return w(m, p, h, y);
         Xo(m, h)
      }
      return typeof h == "string" && h !== "" || typeof h == "number" ? (h = "" + h, p !== null && p.tag === 6 ? (n(m, p.sibling), p = o(p, h), p.return = m, m = p) : (n(m, p), p = yl(h, m.mode, y), p.return = m, m = p), s(m)) : n(m, p)
   }
   return k
}
var cr = ch(!0),
   fh = ch(!1),
   Vo = {},
   Tt = pn(Vo),
   fo = pn(Vo),
   po = pn(Vo);

function kn(e) {
   if (e === Vo) throw Error(P(174));
   return e
}

function Cu(e, t) {
   switch (te(po, t), te(fo, e), te(Tt, Vo), e = t.nodeType, e) {
      case 9:
      case 11:
         t = (t = t.documentElement) ? t.namespaceURI : bl(null, "");
         break;
      default:
         e = e === 8 ? t.parentNode : t, t = e.namespaceURI || null, e = e.tagName, t = bl(t, e)
   }
   oe(Tt), te(Tt, t)
}

function fr() {
   oe(Tt), oe(fo), oe(po)
}

function dh(e) {
   kn(po.current);
   var t = kn(Tt.current),
      n = bl(t, e.type);
   t !== n && (te(fo, e), te(Tt, n))
}

function Pu(e) {
   fo.current === e && (oe(Tt), oe(fo))
}
var ae = pn(0);

function ji(e) {
   for (var t = e; t !== null;) {
      if (t.tag === 13) {
         var n = t.memoizedState;
         if (n !== null && (n = n.dehydrated, n === null || n.data === "$?" || n.data === "$!")) return t
      } else if (t.tag === 19 && t.memoizedProps.revealOrder !== void 0) {
         if ((t.flags & 128) !== 0) return t
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
var dl = [];

function Eu() {
   for (var e = 0; e < dl.length; e++) dl[e]._workInProgressVersionPrimary = null;
   dl.length = 0
}
var hi = jt.ReactCurrentDispatcher,
   pl = jt.ReactCurrentBatchConfig,
   An = 0,
   ue = null,
   xe = null,
   Ce = null,
   Ui = !1,
   Ur = !1,
   ho = 0,
   Ov = 0;

function Oe() {
   throw Error(P(321))
}

function Tu(e, t) {
   if (t === null) return !1;
   for (var n = 0; n < t.length && n < e.length; n++)
      if (!St(e[n], t[n])) return !1;
   return !0
}

function _u(e, t, n, r, o, i) {
   if (An = i, ue = t, t.memoizedState = null, t.updateQueue = null, t.lanes = 0, hi.current = e === null || e.memoizedState === null ? zv : Fv, e = n(r, o), Ur) {
      i = 0;
      do {
         if (Ur = !1, ho = 0, 25 <= i) throw Error(P(301));
         i += 1, Ce = xe = null, t.updateQueue = null, hi.current = $v, e = n(r, o)
      } while (Ur)
   }
   if (hi.current = Bi, t = xe !== null && xe.next !== null, An = 0, Ce = xe = ue = null, Ui = !1, t) throw Error(P(300));
   return e
}

function Au() {
   var e = ho !== 0;
   return ho = 0, e
}

function kt() {
   var e = {
      memoizedState: null,
      baseState: null,
      baseQueue: null,
      queue: null,
      next: null
   };
   return Ce === null ? ue.memoizedState = Ce = e : Ce = Ce.next = e, Ce
}

function ut() {
   if (xe === null) {
      var e = ue.alternate;
      e = e !== null ? e.memoizedState : null
   } else e = xe.next;
   var t = Ce === null ? ue.memoizedState : Ce.next;
   if (t !== null) Ce = t, xe = e;
   else {
      if (e === null) throw Error(P(310));
      xe = e, e = {
         memoizedState: xe.memoizedState,
         baseState: xe.baseState,
         baseQueue: xe.baseQueue,
         queue: xe.queue,
         next: null
      }, Ce === null ? ue.memoizedState = Ce = e : Ce = Ce.next = e
   }
   return Ce
}

function mo(e, t) {
   return typeof t == "function" ? t(e) : t
}

function hl(e) {
   var t = ut(),
      n = t.queue;
   if (n === null) throw Error(P(311));
   n.lastRenderedReducer = e;
   var r = xe,
      o = r.baseQueue,
      i = n.pending;
   if (i !== null) {
      if (o !== null) {
         var s = o.next;
         o.next = i.next, i.next = s
      }
      r.baseQueue = o = i, n.pending = null
   }
   if (o !== null) {
      i = o.next, r = r.baseState;
      var l = s = null,
         a = null,
         u = i;
      do {
         var c = u.lane;
         if ((An & c) === c) a !== null && (a = a.next = {
            lane: 0,
            action: u.action,
            hasEagerState: u.hasEagerState,
            eagerState: u.eagerState,
            next: null
         }), r = u.hasEagerState ? u.eagerState : e(r, u.action);
         else {
            var f = {
               lane: c,
               action: u.action,
               hasEagerState: u.hasEagerState,
               eagerState: u.eagerState,
               next: null
            };
            a === null ? (l = a = f, s = r) : a = a.next = f, ue.lanes |= c, Rn |= c
         }
         u = u.next
      } while (u !== null && u !== i);
      a === null ? s = r : a.next = l, St(r, t.memoizedState) || (We = !0), t.memoizedState = r, t.baseState = s, t.baseQueue = a, n.lastRenderedState = r
   }
   if (e = n.interleaved, e !== null) {
      o = e;
      do i = o.lane, ue.lanes |= i, Rn |= i, o = o.next; while (o !== e)
   } else o === null && (n.lanes = 0);
   return [t.memoizedState, n.dispatch]
}

function ml(e) {
   var t = ut(),
      n = t.queue;
   if (n === null) throw Error(P(311));
   n.lastRenderedReducer = e;
   var r = n.dispatch,
      o = n.pending,
      i = t.memoizedState;
   if (o !== null) {
      n.pending = null;
      var s = o = o.next;
      do i = e(i, s.action), s = s.next; while (s !== o);
      St(i, t.memoizedState) || (We = !0), t.memoizedState = i, t.baseQueue === null && (t.baseState = i), n.lastRenderedState = i
   }
   return [i, r]
}

function ph() {}

function hh(e, t) {
   var n = ue,
      r = ut(),
      o = t(),
      i = !St(r.memoizedState, o);
   if (i && (r.memoizedState = o, We = !0), r = r.queue, Ru(vh.bind(null, n, r, e), [e]), r.getSnapshot !== t || i || Ce !== null && Ce.memoizedState.tag & 1) {
      if (n.flags |= 2048, go(9, gh.bind(null, n, r, o, t), void 0, null), Pe === null) throw Error(P(349));
      (An & 30) !== 0 || mh(n, t, o)
   }
   return o
}

function mh(e, t, n) {
   e.flags |= 16384, e = {
      getSnapshot: t,
      value: n
   }, t = ue.updateQueue, t === null ? (t = {
      lastEffect: null,
      stores: null
   }, ue.updateQueue = t, t.stores = [e]) : (n = t.stores, n === null ? t.stores = [e] : n.push(e))
}

function gh(e, t, n, r) {
   t.value = n, t.getSnapshot = r, yh(t) && wh(e)
}

function vh(e, t, n) {
   return n(function () {
      yh(t) && wh(e)
   })
}

function yh(e) {
   var t = e.getSnapshot;
   e = e.value;
   try {
      var n = t();
      return !St(e, n)
   } catch {
      return !0
   }
}

function wh(e) {
   var t = zt(e, 1);
   t !== null && yt(t, e, 1, -1)
}

function ff(e) {
   var t = kt();
   return typeof e == "function" && (e = e()), t.memoizedState = t.baseState = e, e = {
      pending: null,
      interleaved: null,
      lanes: 0,
      dispatch: null,
      lastRenderedReducer: mo,
      lastRenderedState: e
   }, t.queue = e, e = e.dispatch = Iv.bind(null, ue, e), [t.memoizedState, e]
}

function go(e, t, n, r) {
   return e = {
      tag: e,
      create: t,
      destroy: n,
      deps: r,
      next: null
   }, t = ue.updateQueue, t === null ? (t = {
      lastEffect: null,
      stores: null
   }, ue.updateQueue = t, t.lastEffect = e.next = e) : (n = t.lastEffect, n === null ? t.lastEffect = e.next = e : (r = n.next, n.next = e, e.next = r, t.lastEffect = e)), e
}

function Sh() {
   return ut().memoizedState
}

function mi(e, t, n, r) {
   var o = kt();
   ue.flags |= e, o.memoizedState = go(1 | t, n, void 0, r === void 0 ? null : r)
}

function gs(e, t, n, r) {
   var o = ut();
   r = r === void 0 ? null : r;
   var i = void 0;
   if (xe !== null) {
      var s = xe.memoizedState;
      if (i = s.destroy, r !== null && Tu(r, s.deps)) {
         o.memoizedState = go(t, n, i, r);
         return
      }
   }
   ue.flags |= e, o.memoizedState = go(1 | t, n, i, r)
}

function df(e, t) {
   return mi(8390656, 8, e, t)
}

function Ru(e, t) {
   return gs(2048, 8, e, t)
}

function xh(e, t) {
   return gs(4, 2, e, t)
}

function kh(e, t) {
   return gs(4, 4, e, t)
}

function Ch(e, t) {
   if (typeof t == "function") return e = e(), t(e),
      function () {
         t(null)
      };
   if (t != null) return e = e(), t.current = e,
      function () {
         t.current = null
      }
}

function Ph(e, t, n) {
   return n = n != null ? n.concat([e]) : null, gs(4, 4, Ch.bind(null, t, e), n)
}

function Vu() {}

function Eh(e, t) {
   var n = ut();
   t = t === void 0 ? null : t;
   var r = n.memoizedState;
   return r !== null && t !== null && Tu(t, r[1]) ? r[0] : (n.memoizedState = [e, t], e)
}

function Th(e, t) {
   var n = ut();
   t = t === void 0 ? null : t;
   var r = n.memoizedState;
   return r !== null && t !== null && Tu(t, r[1]) ? r[0] : (e = e(), n.memoizedState = [e, t], e)
}

function _h(e, t, n) {
   return (An & 21) === 0 ? (e.baseState && (e.baseState = !1, We = !0), e.memoizedState = n) : (St(n, t) || (n = Vp(), ue.lanes |= n, Rn |= n, e.baseState = !0), t)
}

function Dv(e, t) {
   var n = X;
   X = n !== 0 && 4 > n ? n : 4, e(!0);
   var r = pl.transition;
   pl.transition = {};
   try {
      e(!1), t()
   } finally {
      X = n, pl.transition = r
   }
}

function Ah() {
   return ut().memoizedState
}

function Nv(e, t, n) {
   var r = sn(e);
   if (n = {
         lane: r,
         action: n,
         hasEagerState: !1,
         eagerState: null,
         next: null
      }, Rh(e)) Vh(t, n);
   else if (n = sh(e, t, n, r), n !== null) {
      var o = $e();
      yt(n, e, r, o), Lh(n, t, r)
   }
}

function Iv(e, t, n) {
   var r = sn(e),
      o = {
         lane: r,
         action: n,
         hasEagerState: !1,
         eagerState: null,
         next: null
      };
   if (Rh(e)) Vh(t, o);
   else {
      var i = e.alternate;
      if (e.lanes === 0 && (i === null || i.lanes === 0) && (i = t.lastRenderedReducer, i !== null)) try {
         var s = t.lastRenderedState,
            l = i(s, n);
         if (o.hasEagerState = !0, o.eagerState = l, St(l, s)) {
            var a = t.interleaved;
            a === null ? (o.next = o, xu(t)) : (o.next = a.next, a.next = o), t.interleaved = o;
            return
         }
      } catch {} finally {}
      n = sh(e, t, o, r), n !== null && (o = $e(), yt(n, e, r, o), Lh(n, t, r))
   }
}

function Rh(e) {
   var t = e.alternate;
   return e === ue || t !== null && t === ue
}

function Vh(e, t) {
   Ur = Ui = !0;
   var n = e.pending;
   n === null ? t.next = t : (t.next = n.next, n.next = t), e.pending = t
}

function Lh(e, t, n) {
   if ((n & 4194240) !== 0) {
      var r = t.lanes;
      r &= e.pendingLanes, n |= r, t.lanes = n, lu(e, n)
   }
}
var Bi = {
      readContext: at,
      useCallback: Oe,
      useContext: Oe,
      useEffect: Oe,
      useImperativeHandle: Oe,
      useInsertionEffect: Oe,
      useLayoutEffect: Oe,
      useMemo: Oe,
      useReducer: Oe,
      useRef: Oe,
      useState: Oe,
      useDebugValue: Oe,
      useDeferredValue: Oe,
      useTransition: Oe,
      useMutableSource: Oe,
      useSyncExternalStore: Oe,
      useId: Oe,
      unstable_isNewReconciler: !1
   },
   zv = {
      readContext: at,
      useCallback: function (e, t) {
         return kt().memoizedState = [e, t === void 0 ? null : t], e
      },
      useContext: at,
      useEffect: df,
      useImperativeHandle: function (e, t, n) {
         return n = n != null ? n.concat([e]) : null, mi(4194308, 4, Ch.bind(null, t, e), n)
      },
      useLayoutEffect: function (e, t) {
         return mi(4194308, 4, e, t)
      },
      useInsertionEffect: function (e, t) {
         return mi(4, 2, e, t)
      },
      useMemo: function (e, t) {
         var n = kt();
         return t = t === void 0 ? null : t, e = e(), n.memoizedState = [e, t], e
      },
      useReducer: function (e, t, n) {
         var r = kt();
         return t = n !== void 0 ? n(t) : t, r.memoizedState = r.baseState = t, e = {
            pending: null,
            interleaved: null,
            lanes: 0,
            dispatch: null,
            lastRenderedReducer: e,
            lastRenderedState: t
         }, r.queue = e, e = e.dispatch = Nv.bind(null, ue, e), [r.memoizedState, e]
      },
      useRef: function (e) {
         var t = kt();
         return e = {
            current: e
         }, t.memoizedState = e
      },
      useState: ff,
      useDebugValue: Vu,
      useDeferredValue: function (e) {
         return kt().memoizedState = e
      },
      useTransition: function () {
         var e = ff(!1),
            t = e[0];
         return e = Dv.bind(null, e[1]), kt().memoizedState = e, [t, e]
      },
      useMutableSource: function () {},
      useSyncExternalStore: function (e, t, n) {
         var r = ue,
            o = kt();
         if (ie) {
            if (n === void 0) throw Error(P(407));
            n = n()
         } else {
            if (n = t(), Pe === null) throw Error(P(349));
            (An & 30) !== 0 || mh(r, t, n)
         }
         o.memoizedState = n;
         var i = {
            value: n,
            getSnapshot: t
         };
         return o.queue = i, df(vh.bind(null, r, i, e), [e]), r.flags |= 2048, go(9, gh.bind(null, r, i, n, t), void 0, null), n
      },
      useId: function () {
         var e = kt(),
            t = Pe.identifierPrefix;
         if (ie) {
            var n = Mt,
               r = Lt;
            n = (r & ~(1 << 32 - vt(r) - 1)).toString(32) + n, t = ":" + t + "R" + n, n = ho++, 0 < n && (t += "H" + n.toString(32)), t += ":"
         } else n = Ov++, t = ":" + t + "r" + n.toString(32) + ":";
         return e.memoizedState = t
      },
      unstable_isNewReconciler: !1
   },
   Fv = {
      readContext: at,
      useCallback: Eh,
      useContext: at,
      useEffect: Ru,
      useImperativeHandle: Ph,
      useInsertionEffect: xh,
      useLayoutEffect: kh,
      useMemo: Th,
      useReducer: hl,
      useRef: Sh,
      useState: function () {
         return hl(mo)
      },
      useDebugValue: Vu,
      useDeferredValue: function (e) {
         var t = ut();
         return _h(t, xe.memoizedState, e)
      },
      useTransition: function () {
         var e = hl(mo)[0],
            t = ut().memoizedState;
         return [e, t]
      },
      useMutableSource: ph,
      useSyncExternalStore: hh,
      useId: Ah,
      unstable_isNewReconciler: !1
   },
   $v = {
      readContext: at,
      useCallback: Eh,
      useContext: at,
      useEffect: Ru,
      useImperativeHandle: Ph,
      useInsertionEffect: xh,
      useLayoutEffect: kh,
      useMemo: Th,
      useReducer: ml,
      useRef: Sh,
      useState: function () {
         return ml(mo)
      },
      useDebugValue: Vu,
      useDeferredValue: function (e) {
         var t = ut();
         return xe === null ? t.memoizedState = e : _h(t, xe.memoizedState, e)
      },
      useTransition: function () {
         var e = ml(mo)[0],
            t = ut().memoizedState;
         return [e, t]
      },
      useMutableSource: ph,
      useSyncExternalStore: hh,
      useId: Ah,
      unstable_isNewReconciler: !1
   };

function dr(e, t) {
   try {
      var n = "",
         r = t;
      do n += pg(r), r = r.return; while (r);
      var o = n
   } catch (i) {
      o = `
Error generating stack: ` + i.message + `
` + i.stack
   }
   return {
      value: e,
      source: t,
      stack: o,
      digest: null
   }
}

function gl(e, t, n) {
   return {
      value: e,
      source: null,
      stack: n != null ? n : null,
      digest: t != null ? t : null
   }
}

function pa(e, t) {
   try {
      console.error(t.value)
   } catch (n) {
      setTimeout(function () {
         throw n
      })
   }
}
var jv = typeof WeakMap == "function" ? WeakMap : Map;

function Mh(e, t, n) {
   n = Dt(-1, n), n.tag = 3, n.payload = {
      element: null
   };
   var r = t.value;
   return n.callback = function () {
      bi || (bi = !0, Ca = r), pa(e, t)
   }, n
}

function Oh(e, t, n) {
   n = Dt(-1, n), n.tag = 3;
   var r = e.type.getDerivedStateFromError;
   if (typeof r == "function") {
      var o = t.value;
      n.payload = function () {
         return r(o)
      }, n.callback = function () {
         pa(e, t)
      }
   }
   var i = e.stateNode;
   return i !== null && typeof i.componentDidCatch == "function" && (n.callback = function () {
      pa(e, t), typeof r != "function" && (on === null ? on = new Set([this]) : on.add(this));
      var s = t.stack;
      this.componentDidCatch(t.value, {
         componentStack: s !== null ? s : ""
      })
   }), n
}

function pf(e, t, n) {
   var r = e.pingCache;
   if (r === null) {
      r = e.pingCache = new jv;
      var o = new Set;
      r.set(t, o)
   } else o = r.get(t), o === void 0 && (o = new Set, r.set(t, o));
   o.has(n) || (o.add(n), e = ey.bind(null, e, t, n), t.then(e, e))
}

function hf(e) {
   do {
      var t;
      if ((t = e.tag === 13) && (t = e.memoizedState, t = t !== null ? t.dehydrated !== null : !0), t) return e;
      e = e.return
   } while (e !== null);
   return null
}

function mf(e, t, n, r, o) {
   return (e.mode & 1) === 0 ? (e === t ? e.flags |= 65536 : (e.flags |= 128, n.flags |= 131072, n.flags &= -52805, n.tag === 1 && (n.alternate === null ? n.tag = 17 : (t = Dt(-1, 1), t.tag = 2, rn(n, t, 1))), n.lanes |= 1), e) : (e.flags |= 65536, e.lanes = o, e)
}
var Uv = jt.ReactCurrentOwner,
   We = !1;

function Fe(e, t, n, r) {
   t.child = e === null ? fh(t, null, n, r) : cr(t, e.child, n, r)
}

function gf(e, t, n, r, o) {
   n = n.render;
   var i = t.ref;
   return rr(t, o), r = _u(e, t, n, r, i, o), n = Au(), e !== null && !We ? (t.updateQueue = e.updateQueue, t.flags &= -2053, e.lanes &= ~o, Ft(e, t, o)) : (ie && n && mu(t), t.flags |= 1, Fe(e, t, r, o), t.child)
}

function vf(e, t, n, r, o) {
   if (e === null) {
      var i = n.type;
      return typeof i == "function" && !Fu(i) && i.defaultProps === void 0 && n.compare === null && n.defaultProps === void 0 ? (t.tag = 15, t.type = i, Dh(e, t, i, r, o)) : (e = wi(n.type, null, r, t, t.mode, o), e.ref = t.ref, e.return = t, t.child = e)
   }
   if (i = e.child, (e.lanes & o) === 0) {
      var s = i.memoizedProps;
      if (n = n.compare, n = n !== null ? n : lo, n(s, r) && e.ref === t.ref) return Ft(e, t, o)
   }
   return t.flags |= 1, e = ln(i, r), e.ref = t.ref, e.return = t, t.child = e
}

function Dh(e, t, n, r, o) {
   if (e !== null) {
      var i = e.memoizedProps;
      if (lo(i, r) && e.ref === t.ref)
         if (We = !1, t.pendingProps = r = i, (e.lanes & o) !== 0)(e.flags & 131072) !== 0 && (We = !0);
         else return t.lanes = e.lanes, Ft(e, t, o)
   }
   return ha(e, t, n, r, o)
}

function Nh(e, t, n) {
   var r = t.pendingProps,
      o = r.children,
      i = e !== null ? e.memoizedState : null;
   if (r.mode === "hidden")
      if ((t.mode & 1) === 0) t.memoizedState = {
         baseLanes: 0,
         cachePool: null,
         transitions: null
      }, te(Kn, Ke), Ke |= n;
      else {
         if ((n & 1073741824) === 0) return e = i !== null ? i.baseLanes | n : n, t.lanes = t.childLanes = 1073741824, t.memoizedState = {
            baseLanes: e,
            cachePool: null,
            transitions: null
         }, t.updateQueue = null, te(Kn, Ke), Ke |= e, null;
         t.memoizedState = {
            baseLanes: 0,
            cachePool: null,
            transitions: null
         }, r = i !== null ? i.baseLanes : n, te(Kn, Ke), Ke |= r
      }
   else i !== null ? (r = i.baseLanes | n, t.memoizedState = null) : r = n, te(Kn, Ke), Ke |= r;
   return Fe(e, t, o, n), t.child
}

function Ih(e, t) {
   var n = t.ref;
   (e === null && n !== null || e !== null && e.ref !== n) && (t.flags |= 512, t.flags |= 2097152)
}

function ha(e, t, n, r, o) {
   var i = Qe(n) ? Tn : Ie.current;
   return i = ar(t, i), rr(t, o), n = _u(e, t, n, r, i, o), r = Au(), e !== null && !We ? (t.updateQueue = e.updateQueue, t.flags &= -2053, e.lanes &= ~o, Ft(e, t, o)) : (ie && r && mu(t), t.flags |= 1, Fe(e, t, n, o), t.child)
}

function yf(e, t, n, r, o) {
   if (Qe(n)) {
      var i = !0;
      Di(t)
   } else i = !1;
   if (rr(t, o), t.stateNode === null) gi(e, t), uh(t, n, r), da(t, n, r, o), r = !0;
   else if (e === null) {
      var s = t.stateNode,
         l = t.memoizedProps;
      s.props = l;
      var a = s.context,
         u = n.contextType;
      typeof u == "object" && u !== null ? u = at(u) : (u = Qe(n) ? Tn : Ie.current, u = ar(t, u));
      var c = n.getDerivedStateFromProps,
         f = typeof c == "function" || typeof s.getSnapshotBeforeUpdate == "function";
      f || typeof s.UNSAFE_componentWillReceiveProps != "function" && typeof s.componentWillReceiveProps != "function" || (l !== r || a !== u) && uf(t, s, r, u), Wt = !1;
      var d = t.memoizedState;
      s.state = d, $i(t, r, s, o), a = t.memoizedState, l !== r || d !== a || Ge.current || Wt ? (typeof c == "function" && (fa(t, n, c, r), a = t.memoizedState), (l = Wt || af(t, n, l, r, d, a, u)) ? (f || typeof s.UNSAFE_componentWillMount != "function" && typeof s.componentWillMount != "function" || (typeof s.componentWillMount == "function" && s.componentWillMount(), typeof s.UNSAFE_componentWillMount == "function" && s.UNSAFE_componentWillMount()), typeof s.componentDidMount == "function" && (t.flags |= 4194308)) : (typeof s.componentDidMount == "function" && (t.flags |= 4194308), t.memoizedProps = r, t.memoizedState = a), s.props = r, s.state = a, s.context = u, r = l) : (typeof s.componentDidMount == "function" && (t.flags |= 4194308), r = !1)
   } else {
      s = t.stateNode, lh(e, t), l = t.memoizedProps, u = t.type === t.elementType ? l : pt(t.type, l), s.props = u, f = t.pendingProps, d = s.context, a = n.contextType, typeof a == "object" && a !== null ? a = at(a) : (a = Qe(n) ? Tn : Ie.current, a = ar(t, a));
      var g = n.getDerivedStateFromProps;
      (c = typeof g == "function" || typeof s.getSnapshotBeforeUpdate == "function") || typeof s.UNSAFE_componentWillReceiveProps != "function" && typeof s.componentWillReceiveProps != "function" || (l !== f || d !== a) && uf(t, s, r, a), Wt = !1, d = t.memoizedState, s.state = d, $i(t, r, s, o);
      var v = t.memoizedState;
      l !== f || d !== v || Ge.current || Wt ? (typeof g == "function" && (fa(t, n, g, r), v = t.memoizedState), (u = Wt || af(t, n, u, r, d, v, a) || !1) ? (c || typeof s.UNSAFE_componentWillUpdate != "function" && typeof s.componentWillUpdate != "function" || (typeof s.componentWillUpdate == "function" && s.componentWillUpdate(r, v, a), typeof s.UNSAFE_componentWillUpdate == "function" && s.UNSAFE_componentWillUpdate(r, v, a)), typeof s.componentDidUpdate == "function" && (t.flags |= 4), typeof s.getSnapshotBeforeUpdate == "function" && (t.flags |= 1024)) : (typeof s.componentDidUpdate != "function" || l === e.memoizedProps && d === e.memoizedState || (t.flags |= 4), typeof s.getSnapshotBeforeUpdate != "function" || l === e.memoizedProps && d === e.memoizedState || (t.flags |= 1024), t.memoizedProps = r, t.memoizedState = v), s.props = r, s.state = v, s.context = a, r = u) : (typeof s.componentDidUpdate != "function" || l === e.memoizedProps && d === e.memoizedState || (t.flags |= 4), typeof s.getSnapshotBeforeUpdate != "function" || l === e.memoizedProps && d === e.memoizedState || (t.flags |= 1024), r = !1)
   }
   return ma(e, t, n, r, i, o)
}

function ma(e, t, n, r, o, i) {
   Ih(e, t);
   var s = (t.flags & 128) !== 0;
   if (!r && !s) return o && nf(t, n, !1), Ft(e, t, i);
   r = t.stateNode, Uv.current = t;
   var l = s && typeof n.getDerivedStateFromError != "function" ? null : r.render();
   return t.flags |= 1, e !== null && s ? (t.child = cr(t, e.child, null, i), t.child = cr(t, null, l, i)) : Fe(e, t, l, i), t.memoizedState = r.state, o && nf(t, n, !0), t.child
}

function zh(e) {
   var t = e.stateNode;
   t.pendingContext ? tf(e, t.pendingContext, t.pendingContext !== t.context) : t.context && tf(e, t.context, !1), Cu(e, t.containerInfo)
}

function wf(e, t, n, r, o) {
   return ur(), vu(o), t.flags |= 256, Fe(e, t, n, r), t.child
}
var ga = {
   dehydrated: null,
   treeContext: null,
   retryLane: 0
};

function va(e) {
   return {
      baseLanes: e,
      cachePool: null,
      transitions: null
   }
}

function Fh(e, t, n) {
   var r = t.pendingProps,
      o = ae.current,
      i = !1,
      s = (t.flags & 128) !== 0,
      l;
   if ((l = s) || (l = e !== null && e.memoizedState === null ? !1 : (o & 2) !== 0), l ? (i = !0, t.flags &= -129) : (e === null || e.memoizedState !== null) && (o |= 1), te(ae, o & 1), e === null) return ua(t), e = t.memoizedState, e !== null && (e = e.dehydrated, e !== null) ? ((t.mode & 1) === 0 ? t.lanes = 1 : e.data === "$!" ? t.lanes = 8 : t.lanes = 1073741824, null) : (s = r.children, e = r.fallback, i ? (r = t.mode, i = t.child, s = {
      mode: "hidden",
      children: s
   }, (r & 1) === 0 && i !== null ? (i.childLanes = 0, i.pendingProps = s) : i = ws(s, r, 0, null), e = En(e, r, n, null), i.return = t, e.return = t, i.sibling = e, t.child = i, t.child.memoizedState = va(n), t.memoizedState = ga, e) : Lu(t, s));
   if (o = e.memoizedState, o !== null && (l = o.dehydrated, l !== null)) return Bv(e, t, s, r, l, o, n);
   if (i) {
      i = r.fallback, s = t.mode, o = e.child, l = o.sibling;
      var a = {
         mode: "hidden",
         children: r.children
      };
      return (s & 1) === 0 && t.child !== o ? (r = t.child, r.childLanes = 0, r.pendingProps = a, t.deletions = null) : (r = ln(o, a), r.subtreeFlags = o.subtreeFlags & 14680064), l !== null ? i = ln(l, i) : (i = En(i, s, n, null), i.flags |= 2), i.return = t, r.return = t, r.sibling = i, t.child = r, r = i, i = t.child, s = e.child.memoizedState, s = s === null ? va(n) : {
         baseLanes: s.baseLanes | n,
         cachePool: null,
         transitions: s.transitions
      }, i.memoizedState = s, i.childLanes = e.childLanes & ~n, t.memoizedState = ga, r
   }
   return i = e.child, e = i.sibling, r = ln(i, {
      mode: "visible",
      children: r.children
   }), (t.mode & 1) === 0 && (r.lanes = n), r.return = t, r.sibling = null, e !== null && (n = t.deletions, n === null ? (t.deletions = [e], t.flags |= 16) : n.push(e)), t.child = r, t.memoizedState = null, r
}

function Lu(e, t) {
   return t = ws({
      mode: "visible",
      children: t
   }, e.mode, 0, null), t.return = e, e.child = t
}

function Zo(e, t, n, r) {
   return r !== null && vu(r), cr(t, e.child, null, n), e = Lu(t, t.pendingProps.children), e.flags |= 2, t.memoizedState = null, e
}

function Bv(e, t, n, r, o, i, s) {
   if (n) return t.flags & 256 ? (t.flags &= -257, r = gl(Error(P(422))), Zo(e, t, s, r)) : t.memoizedState !== null ? (t.child = e.child, t.flags |= 128, null) : (i = r.fallback, o = t.mode, r = ws({
      mode: "visible",
      children: r.children
   }, o, 0, null), i = En(i, o, s, null), i.flags |= 2, r.return = t, i.return = t, r.sibling = i, t.child = r, (t.mode & 1) !== 0 && cr(t, e.child, null, s), t.child.memoizedState = va(s), t.memoizedState = ga, i);
   if ((t.mode & 1) === 0) return Zo(e, t, s, null);
   if (o.data === "$!") {
      if (r = o.nextSibling && o.nextSibling.dataset, r) var l = r.dgst;
      return r = l, i = Error(P(419)), r = gl(i, r, void 0), Zo(e, t, s, r)
   }
   if (l = (s & e.childLanes) !== 0, We || l) {
      if (r = Pe, r !== null) {
         switch (s & -s) {
            case 4:
               o = 2;
               break;
            case 16:
               o = 8;
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
               o = 32;
               break;
            case 536870912:
               o = 268435456;
               break;
            default:
               o = 0
         }
         o = (o & (r.suspendedLanes | s)) !== 0 ? 0 : o, o !== 0 && o !== i.retryLane && (i.retryLane = o, zt(e, o), yt(r, e, o, -1))
      }
      return zu(), r = gl(Error(P(421))), Zo(e, t, s, r)
   }
   return o.data === "$?" ? (t.flags |= 128, t.child = e.child, t = ty.bind(null, e), o._reactRetry = t, null) : (e = i.treeContext, Xe = nn(o.nextSibling), Ze = t, ie = !0, mt = null, e !== null && (rt[ot++] = Lt, rt[ot++] = Mt, rt[ot++] = _n, Lt = e.id, Mt = e.overflow, _n = t), t = Lu(t, r.children), t.flags |= 4096, t)
}

function Sf(e, t, n) {
   e.lanes |= t;
   var r = e.alternate;
   r !== null && (r.lanes |= t), ca(e.return, t, n)
}

function vl(e, t, n, r, o) {
   var i = e.memoizedState;
   i === null ? e.memoizedState = {
      isBackwards: t,
      rendering: null,
      renderingStartTime: 0,
      last: r,
      tail: n,
      tailMode: o
   } : (i.isBackwards = t, i.rendering = null, i.renderingStartTime = 0, i.last = r, i.tail = n, i.tailMode = o)
}

function $h(e, t, n) {
   var r = t.pendingProps,
      o = r.revealOrder,
      i = r.tail;
   if (Fe(e, t, r.children, n), r = ae.current, (r & 2) !== 0) r = r & 1 | 2, t.flags |= 128;
   else {
      if (e !== null && (e.flags & 128) !== 0) e: for (e = t.child; e !== null;) {
         if (e.tag === 13) e.memoizedState !== null && Sf(e, n, t);
         else if (e.tag === 19) Sf(e, n, t);
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
   if (te(ae, r), (t.mode & 1) === 0) t.memoizedState = null;
   else switch (o) {
      case "forwards":
         for (n = t.child, o = null; n !== null;) e = n.alternate, e !== null && ji(e) === null && (o = n), n = n.sibling;
         n = o, n === null ? (o = t.child, t.child = null) : (o = n.sibling, n.sibling = null), vl(t, !1, o, n, i);
         break;
      case "backwards":
         for (n = null, o = t.child, t.child = null; o !== null;) {
            if (e = o.alternate, e !== null && ji(e) === null) {
               t.child = o;
               break
            }
            e = o.sibling, o.sibling = n, n = o, o = e
         }
         vl(t, !0, n, null, i);
         break;
      case "together":
         vl(t, !1, null, null, void 0);
         break;
      default:
         t.memoizedState = null
   }
   return t.child
}

function gi(e, t) {
   (t.mode & 1) === 0 && e !== null && (e.alternate = null, t.alternate = null, t.flags |= 2)
}

function Ft(e, t, n) {
   if (e !== null && (t.dependencies = e.dependencies), Rn |= t.lanes, (n & t.childLanes) === 0) return null;
   if (e !== null && t.child !== e.child) throw Error(P(153));
   if (t.child !== null) {
      for (e = t.child, n = ln(e, e.pendingProps), t.child = n, n.return = t; e.sibling !== null;) e = e.sibling, n = n.sibling = ln(e, e.pendingProps), n.return = t;
      n.sibling = null
   }
   return t.child
}

function Hv(e, t, n) {
   switch (t.tag) {
      case 3:
         zh(t), ur();
         break;
      case 5:
         dh(t);
         break;
      case 1:
         Qe(t.type) && Di(t);
         break;
      case 4:
         Cu(t, t.stateNode.containerInfo);
         break;
      case 10:
         var r = t.type._context,
            o = t.memoizedProps.value;
         te(zi, r._currentValue), r._currentValue = o;
         break;
      case 13:
         if (r = t.memoizedState, r !== null) return r.dehydrated !== null ? (te(ae, ae.current & 1), t.flags |= 128, null) : (n & t.child.childLanes) !== 0 ? Fh(e, t, n) : (te(ae, ae.current & 1), e = Ft(e, t, n), e !== null ? e.sibling : null);
         te(ae, ae.current & 1);
         break;
      case 19:
         if (r = (n & t.childLanes) !== 0, (e.flags & 128) !== 0) {
            if (r) return $h(e, t, n);
            t.flags |= 128
         }
         if (o = t.memoizedState, o !== null && (o.rendering = null, o.tail = null, o.lastEffect = null), te(ae, ae.current), r) break;
         return null;
      case 22:
      case 23:
         return t.lanes = 0, Nh(e, t, n)
   }
   return Ft(e, t, n)
}
var jh, ya, Uh, Bh;
jh = function (e, t) {
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
ya = function () {};
Uh = function (e, t, n, r) {
   var o = e.memoizedProps;
   if (o !== r) {
      e = t.stateNode, kn(Tt.current);
      var i = null;
      switch (n) {
         case "input":
            o = jl(e, o), r = jl(e, r), i = [];
            break;
         case "select":
            o = ce({}, o, {
               value: void 0
            }), r = ce({}, r, {
               value: void 0
            }), i = [];
            break;
         case "textarea":
            o = Hl(e, o), r = Hl(e, r), i = [];
            break;
         default:
            typeof o.onClick != "function" && typeof r.onClick == "function" && (e.onclick = Mi)
      }
      Wl(n, r);
      var s;
      n = null;
      for (u in o)
         if (!r.hasOwnProperty(u) && o.hasOwnProperty(u) && o[u] != null)
            if (u === "style") {
               var l = o[u];
               for (s in l) l.hasOwnProperty(s) && (n || (n = {}), n[s] = "")
            } else u !== "dangerouslySetInnerHTML" && u !== "children" && u !== "suppressContentEditableWarning" && u !== "suppressHydrationWarning" && u !== "autoFocus" && (eo.hasOwnProperty(u) ? i || (i = []) : (i = i || []).push(u, null));
      for (u in r) {
         var a = r[u];
         if (l = o != null ? o[u] : void 0, r.hasOwnProperty(u) && a !== l && (a != null || l != null))
            if (u === "style")
               if (l) {
                  for (s in l) !l.hasOwnProperty(s) || a && a.hasOwnProperty(s) || (n || (n = {}), n[s] = "");
                  for (s in a) a.hasOwnProperty(s) && l[s] !== a[s] && (n || (n = {}), n[s] = a[s])
               } else n || (i || (i = []), i.push(u, n)), n = a;
         else u === "dangerouslySetInnerHTML" ? (a = a ? a.__html : void 0, l = l ? l.__html : void 0, a != null && l !== a && (i = i || []).push(u, a)) : u === "children" ? typeof a != "string" && typeof a != "number" || (i = i || []).push(u, "" + a) : u !== "suppressContentEditableWarning" && u !== "suppressHydrationWarning" && (eo.hasOwnProperty(u) ? (a != null && u === "onScroll" && re("scroll", e), i || l === a || (i = [])) : (i = i || []).push(u, a))
      }
      n && (i = i || []).push("style", n);
      var u = i;
      (t.updateQueue = u) && (t.flags |= 4)
   }
};
Bh = function (e, t, n, r) {
   n !== r && (t.flags |= 4)
};

function Ar(e, t) {
   if (!ie) switch (e.tailMode) {
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

function De(e) {
   var t = e.alternate !== null && e.alternate.child === e.child,
      n = 0,
      r = 0;
   if (t)
      for (var o = e.child; o !== null;) n |= o.lanes | o.childLanes, r |= o.subtreeFlags & 14680064, r |= o.flags & 14680064, o.return = e, o = o.sibling;
   else
      for (o = e.child; o !== null;) n |= o.lanes | o.childLanes, r |= o.subtreeFlags, r |= o.flags, o.return = e, o = o.sibling;
   return e.subtreeFlags |= r, e.childLanes = n, t
}

function bv(e, t, n) {
   var r = t.pendingProps;
   switch (gu(t), t.tag) {
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
         return De(t), null;
      case 1:
         return Qe(t.type) && Oi(), De(t), null;
      case 3:
         return r = t.stateNode, fr(), oe(Ge), oe(Ie), Eu(), r.pendingContext && (r.context = r.pendingContext, r.pendingContext = null), (e === null || e.child === null) && (Ko(t) ? t.flags |= 4 : e === null || e.memoizedState.isDehydrated && (t.flags & 256) === 0 || (t.flags |= 1024, mt !== null && (Ta(mt), mt = null))), ya(e, t), De(t), null;
      case 5:
         Pu(t);
         var o = kn(po.current);
         if (n = t.type, e !== null && t.stateNode != null) Uh(e, t, n, r, o), e.ref !== t.ref && (t.flags |= 512, t.flags |= 2097152);
         else {
            if (!r) {
               if (t.stateNode === null) throw Error(P(166));
               return De(t), null
            }
            if (e = kn(Tt.current), Ko(t)) {
               r = t.stateNode, n = t.type;
               var i = t.memoizedProps;
               switch (r[Pt] = t, r[co] = i, e = (t.mode & 1) !== 0, n) {
                  case "dialog":
                     re("cancel", r), re("close", r);
                     break;
                  case "iframe":
                  case "object":
                  case "embed":
                     re("load", r);
                     break;
                  case "video":
                  case "audio":
                     for (o = 0; o < Nr.length; o++) re(Nr[o], r);
                     break;
                  case "source":
                     re("error", r);
                     break;
                  case "img":
                  case "image":
                  case "link":
                     re("error", r), re("load", r);
                     break;
                  case "details":
                     re("toggle", r);
                     break;
                  case "input":
                     Ac(r, i), re("invalid", r);
                     break;
                  case "select":
                     r._wrapperState = {
                        wasMultiple: !!i.multiple
                     }, re("invalid", r);
                     break;
                  case "textarea":
                     Vc(r, i), re("invalid", r)
               }
               Wl(n, i), o = null;
               for (var s in i)
                  if (i.hasOwnProperty(s)) {
                     var l = i[s];
                     s === "children" ? typeof l == "string" ? r.textContent !== l && (i.suppressHydrationWarning !== !0 && Yo(r.textContent, l, e), o = ["children", l]) : typeof l == "number" && r.textContent !== "" + l && (i.suppressHydrationWarning !== !0 && Yo(r.textContent, l, e), o = ["children", "" + l]) : eo.hasOwnProperty(s) && l != null && s === "onScroll" && re("scroll", r)
                  } switch (n) {
                  case "input":
                     jo(r), Rc(r, i, !0);
                     break;
                  case "textarea":
                     jo(r), Lc(r);
                     break;
                  case "select":
                  case "option":
                     break;
                  default:
                     typeof i.onClick == "function" && (r.onclick = Mi)
               }
               r = o, t.updateQueue = r, r !== null && (t.flags |= 4)
            } else {
               s = o.nodeType === 9 ? o : o.ownerDocument, e === "http://www.w3.org/1999/xhtml" && (e = mp(n)), e === "http://www.w3.org/1999/xhtml" ? n === "script" ? (e = s.createElement("div"), e.innerHTML = "<script><\/script>", e = e.removeChild(e.firstChild)) : typeof r.is == "string" ? e = s.createElement(n, {
                  is: r.is
               }) : (e = s.createElement(n), n === "select" && (s = e, r.multiple ? s.multiple = !0 : r.size && (s.size = r.size))) : e = s.createElementNS(e, n), e[Pt] = t, e[co] = r, jh(e, t, !1, !1), t.stateNode = e;
               e: {
                  switch (s = Gl(n, r), n) {
                     case "dialog":
                        re("cancel", e), re("close", e), o = r;
                        break;
                     case "iframe":
                     case "object":
                     case "embed":
                        re("load", e), o = r;
                        break;
                     case "video":
                     case "audio":
                        for (o = 0; o < Nr.length; o++) re(Nr[o], e);
                        o = r;
                        break;
                     case "source":
                        re("error", e), o = r;
                        break;
                     case "img":
                     case "image":
                     case "link":
                        re("error", e), re("load", e), o = r;
                        break;
                     case "details":
                        re("toggle", e), o = r;
                        break;
                     case "input":
                        Ac(e, r), o = jl(e, r), re("invalid", e);
                        break;
                     case "option":
                        o = r;
                        break;
                     case "select":
                        e._wrapperState = {
                           wasMultiple: !!r.multiple
                        }, o = ce({}, r, {
                           value: void 0
                        }), re("invalid", e);
                        break;
                     case "textarea":
                        Vc(e, r), o = Hl(e, r), re("invalid", e);
                        break;
                     default:
                        o = r
                  }
                  Wl(n, o),
                  l = o;
                  for (i in l)
                     if (l.hasOwnProperty(i)) {
                        var a = l[i];
                        i === "style" ? yp(e, a) : i === "dangerouslySetInnerHTML" ? (a = a ? a.__html : void 0, a != null && gp(e, a)) : i === "children" ? typeof a == "string" ? (n !== "textarea" || a !== "") && to(e, a) : typeof a == "number" && to(e, "" + a) : i !== "suppressContentEditableWarning" && i !== "suppressHydrationWarning" && i !== "autoFocus" && (eo.hasOwnProperty(i) ? a != null && i === "onScroll" && re("scroll", e) : a != null && tu(e, i, a, s))
                     } switch (n) {
                     case "input":
                        jo(e), Rc(e, r, !1);
                        break;
                     case "textarea":
                        jo(e), Lc(e);
                        break;
                     case "option":
                        r.value != null && e.setAttribute("value", "" + un(r.value));
                        break;
                     case "select":
                        e.multiple = !!r.multiple, i = r.value, i != null ? qn(e, !!r.multiple, i, !1) : r.defaultValue != null && qn(e, !!r.multiple, r.defaultValue, !0);
                        break;
                     default:
                        typeof o.onClick == "function" && (e.onclick = Mi)
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
         return De(t), null;
      case 6:
         if (e && t.stateNode != null) Bh(e, t, e.memoizedProps, r);
         else {
            if (typeof r != "string" && t.stateNode === null) throw Error(P(166));
            if (n = kn(po.current), kn(Tt.current), Ko(t)) {
               if (r = t.stateNode, n = t.memoizedProps, r[Pt] = t, (i = r.nodeValue !== n) && (e = Ze, e !== null)) switch (e.tag) {
                  case 3:
                     Yo(r.nodeValue, n, (e.mode & 1) !== 0);
                     break;
                  case 5:
                     e.memoizedProps.suppressHydrationWarning !== !0 && Yo(r.nodeValue, n, (e.mode & 1) !== 0)
               }
               i && (t.flags |= 4)
            } else r = (n.nodeType === 9 ? n : n.ownerDocument).createTextNode(r), r[Pt] = t, t.stateNode = r
         }
         return De(t), null;
      case 13:
         if (oe(ae), r = t.memoizedState, e === null || e.memoizedState !== null && e.memoizedState.dehydrated !== null) {
            if (ie && Xe !== null && (t.mode & 1) !== 0 && (t.flags & 128) === 0) ih(), ur(), t.flags |= 98560, i = !1;
            else if (i = Ko(t), r !== null && r.dehydrated !== null) {
               if (e === null) {
                  if (!i) throw Error(P(318));
                  if (i = t.memoizedState, i = i !== null ? i.dehydrated : null, !i) throw Error(P(317));
                  i[Pt] = t
               } else ur(), (t.flags & 128) === 0 && (t.memoizedState = null), t.flags |= 4;
               De(t), i = !1
            } else mt !== null && (Ta(mt), mt = null), i = !0;
            if (!i) return t.flags & 65536 ? t : null
         }
         return (t.flags & 128) !== 0 ? (t.lanes = n, t) : (r = r !== null, r !== (e !== null && e.memoizedState !== null) && r && (t.child.flags |= 8192, (t.mode & 1) !== 0 && (e === null || (ae.current & 1) !== 0 ? ke === 0 && (ke = 3) : zu())), t.updateQueue !== null && (t.flags |= 4), De(t), null);
      case 4:
         return fr(), ya(e, t), e === null && ao(t.stateNode.containerInfo), De(t), null;
      case 10:
         return Su(t.type._context), De(t), null;
      case 17:
         return Qe(t.type) && Oi(), De(t), null;
      case 19:
         if (oe(ae), i = t.memoizedState, i === null) return De(t), null;
         if (r = (t.flags & 128) !== 0, s = i.rendering, s === null)
            if (r) Ar(i, !1);
            else {
               if (ke !== 0 || e !== null && (e.flags & 128) !== 0)
                  for (e = t.child; e !== null;) {
                     if (s = ji(e), s !== null) {
                        for (t.flags |= 128, Ar(i, !1), r = s.updateQueue, r !== null && (t.updateQueue = r, t.flags |= 4), t.subtreeFlags = 0, r = n, n = t.child; n !== null;) i = n, e = r, i.flags &= 14680066, s = i.alternate, s === null ? (i.childLanes = 0, i.lanes = e, i.child = null, i.subtreeFlags = 0, i.memoizedProps = null, i.memoizedState = null, i.updateQueue = null, i.dependencies = null, i.stateNode = null) : (i.childLanes = s.childLanes, i.lanes = s.lanes, i.child = s.child, i.subtreeFlags = 0, i.deletions = null, i.memoizedProps = s.memoizedProps, i.memoizedState = s.memoizedState, i.updateQueue = s.updateQueue, i.type = s.type, e = s.dependencies, i.dependencies = e === null ? null : {
                           lanes: e.lanes,
                           firstContext: e.firstContext
                        }), n = n.sibling;
                        return te(ae, ae.current & 1 | 2), t.child
                     }
                     e = e.sibling
                  }
               i.tail !== null && ve() > pr && (t.flags |= 128, r = !0, Ar(i, !1), t.lanes = 4194304)
            }
         else {
            if (!r)
               if (e = ji(s), e !== null) {
                  if (t.flags |= 128, r = !0, n = e.updateQueue, n !== null && (t.updateQueue = n, t.flags |= 4), Ar(i, !0), i.tail === null && i.tailMode === "hidden" && !s.alternate && !ie) return De(t), null
               } else 2 * ve() - i.renderingStartTime > pr && n !== 1073741824 && (t.flags |= 128, r = !0, Ar(i, !1), t.lanes = 4194304);
            i.isBackwards ? (s.sibling = t.child, t.child = s) : (n = i.last, n !== null ? n.sibling = s : t.child = s, i.last = s)
         }
         return i.tail !== null ? (t = i.tail, i.rendering = t, i.tail = t.sibling, i.renderingStartTime = ve(), t.sibling = null, n = ae.current, te(ae, r ? n & 1 | 2 : n & 1), t) : (De(t), null);
      case 22:
      case 23:
         return Iu(), r = t.memoizedState !== null, e !== null && e.memoizedState !== null !== r && (t.flags |= 8192), r && (t.mode & 1) !== 0 ? (Ke & 1073741824) !== 0 && (De(t), t.subtreeFlags & 6 && (t.flags |= 8192)) : De(t), null;
      case 24:
         return null;
      case 25:
         return null
   }
   throw Error(P(156, t.tag))
}

function Wv(e, t) {
   switch (gu(t), t.tag) {
      case 1:
         return Qe(t.type) && Oi(), e = t.flags, e & 65536 ? (t.flags = e & -65537 | 128, t) : null;
      case 3:
         return fr(), oe(Ge), oe(Ie), Eu(), e = t.flags, (e & 65536) !== 0 && (e & 128) === 0 ? (t.flags = e & -65537 | 128, t) : null;
      case 5:
         return Pu(t), null;
      case 13:
         if (oe(ae), e = t.memoizedState, e !== null && e.dehydrated !== null) {
            if (t.alternate === null) throw Error(P(340));
            ur()
         }
         return e = t.flags, e & 65536 ? (t.flags = e & -65537 | 128, t) : null;
      case 19:
         return oe(ae), null;
      case 4:
         return fr(), null;
      case 10:
         return Su(t.type._context), null;
      case 22:
      case 23:
         return Iu(), null;
      case 24:
         return null;
      default:
         return null
   }
}
var Jo = !1,
   Ne = !1,
   Gv = typeof WeakSet == "function" ? WeakSet : Set,
   O = null;

function Yn(e, t) {
   var n = e.ref;
   if (n !== null)
      if (typeof n == "function") try {
         n(null)
      } catch (r) {
         pe(e, t, r)
      } else n.current = null
}

function wa(e, t, n) {
   try {
      n()
   } catch (r) {
      pe(e, t, r)
   }
}
var xf = !1;

function Qv(e, t) {
   if (na = Ri, e = Gp(), hu(e)) {
      if ("selectionStart" in e) var n = {
         start: e.selectionStart,
         end: e.selectionEnd
      };
      else e: {
         n = (n = e.ownerDocument) && n.defaultView || window;
         var r = n.getSelection && n.getSelection();
         if (r && r.rangeCount !== 0) {
            n = r.anchorNode;
            var o = r.anchorOffset,
               i = r.focusNode;
            r = r.focusOffset;
            try {
               n.nodeType, i.nodeType
            } catch {
               n = null;
               break e
            }
            var s = 0,
               l = -1,
               a = -1,
               u = 0,
               c = 0,
               f = e,
               d = null;
            t: for (;;) {
               for (var g; f !== n || o !== 0 && f.nodeType !== 3 || (l = s + o), f !== i || r !== 0 && f.nodeType !== 3 || (a = s + r), f.nodeType === 3 && (s += f.nodeValue.length), (g = f.firstChild) !== null;) d = f, f = g;
               for (;;) {
                  if (f === e) break t;
                  if (d === n && ++u === o && (l = s), d === i && ++c === r && (a = s), (g = f.nextSibling) !== null) break;
                  f = d, d = f.parentNode
               }
               f = g
            }
            n = l === -1 || a === -1 ? null : {
               start: l,
               end: a
            }
         } else n = null
      }
      n = n || {
         start: 0,
         end: 0
      }
   } else n = null;
   for (ra = {
         focusedElem: e,
         selectionRange: n
      }, Ri = !1, O = t; O !== null;)
      if (t = O, e = t.child, (t.subtreeFlags & 1028) !== 0 && e !== null) e.return = t, O = e;
      else
         for (; O !== null;) {
            t = O;
            try {
               var v = t.alternate;
               if ((t.flags & 1024) !== 0) switch (t.tag) {
                  case 0:
                  case 11:
                  case 15:
                     break;
                  case 1:
                     if (v !== null) {
                        var w = v.memoizedProps,
                           k = v.memoizedState,
                           m = t.stateNode,
                           p = m.getSnapshotBeforeUpdate(t.elementType === t.type ? w : pt(t.type, w), k);
                        m.__reactInternalSnapshotBeforeUpdate = p
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
                     throw Error(P(163))
               }
            } catch (y) {
               pe(t, t.return, y)
            }
            if (e = t.sibling, e !== null) {
               e.return = t.return, O = e;
               break
            }
            O = t.return
         }
   return v = xf, xf = !1, v
}

function Br(e, t, n) {
   var r = t.updateQueue;
   if (r = r !== null ? r.lastEffect : null, r !== null) {
      var o = r = r.next;
      do {
         if ((o.tag & e) === e) {
            var i = o.destroy;
            o.destroy = void 0, i !== void 0 && wa(t, n, i)
         }
         o = o.next
      } while (o !== r)
   }
}

function vs(e, t) {
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

function Sa(e) {
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

function Hh(e) {
   var t = e.alternate;
   t !== null && (e.alternate = null, Hh(t)), e.child = null, e.deletions = null, e.sibling = null, e.tag === 5 && (t = e.stateNode, t !== null && (delete t[Pt], delete t[co], delete t[sa], delete t[Rv], delete t[Vv])), e.stateNode = null, e.return = null, e.dependencies = null, e.memoizedProps = null, e.memoizedState = null, e.pendingProps = null, e.stateNode = null, e.updateQueue = null
}

function bh(e) {
   return e.tag === 5 || e.tag === 3 || e.tag === 4
}

function kf(e) {
   e: for (;;) {
      for (; e.sibling === null;) {
         if (e.return === null || bh(e.return)) return null;
         e = e.return
      }
      for (e.sibling.return = e.return, e = e.sibling; e.tag !== 5 && e.tag !== 6 && e.tag !== 18;) {
         if (e.flags & 2 || e.child === null || e.tag === 4) continue e;
         e.child.return = e, e = e.child
      }
      if (!(e.flags & 2)) return e.stateNode
   }
}

function xa(e, t, n) {
   var r = e.tag;
   if (r === 5 || r === 6) e = e.stateNode, t ? n.nodeType === 8 ? n.parentNode.insertBefore(e, t) : n.insertBefore(e, t) : (n.nodeType === 8 ? (t = n.parentNode, t.insertBefore(e, n)) : (t = n, t.appendChild(e)), n = n._reactRootContainer, n != null || t.onclick !== null || (t.onclick = Mi));
   else if (r !== 4 && (e = e.child, e !== null))
      for (xa(e, t, n), e = e.sibling; e !== null;) xa(e, t, n), e = e.sibling
}

function ka(e, t, n) {
   var r = e.tag;
   if (r === 5 || r === 6) e = e.stateNode, t ? n.insertBefore(e, t) : n.appendChild(e);
   else if (r !== 4 && (e = e.child, e !== null))
      for (ka(e, t, n), e = e.sibling; e !== null;) ka(e, t, n), e = e.sibling
}
var Re = null,
   ht = !1;

function Bt(e, t, n) {
   for (n = n.child; n !== null;) Wh(e, t, n), n = n.sibling
}

function Wh(e, t, n) {
   if (Et && typeof Et.onCommitFiberUnmount == "function") try {
      Et.onCommitFiberUnmount(us, n)
   } catch {}
   switch (n.tag) {
      case 5:
         Ne || Yn(n, t);
      case 6:
         var r = Re,
            o = ht;
         Re = null, Bt(e, t, n), Re = r, ht = o, Re !== null && (ht ? (e = Re, n = n.stateNode, e.nodeType === 8 ? e.parentNode.removeChild(n) : e.removeChild(n)) : Re.removeChild(n.stateNode));
         break;
      case 18:
         Re !== null && (ht ? (e = Re, n = n.stateNode, e.nodeType === 8 ? cl(e.parentNode, n) : e.nodeType === 1 && cl(e, n), io(e)) : cl(Re, n.stateNode));
         break;
      case 4:
         r = Re, o = ht, Re = n.stateNode.containerInfo, ht = !0, Bt(e, t, n), Re = r, ht = o;
         break;
      case 0:
      case 11:
      case 14:
      case 15:
         if (!Ne && (r = n.updateQueue, r !== null && (r = r.lastEffect, r !== null))) {
            o = r = r.next;
            do {
               var i = o,
                  s = i.destroy;
               i = i.tag, s !== void 0 && ((i & 2) !== 0 || (i & 4) !== 0) && wa(n, t, s), o = o.next
            } while (o !== r)
         }
         Bt(e, t, n);
         break;
      case 1:
         if (!Ne && (Yn(n, t), r = n.stateNode, typeof r.componentWillUnmount == "function")) try {
            r.props = n.memoizedProps, r.state = n.memoizedState, r.componentWillUnmount()
         } catch (l) {
            pe(n, t, l)
         }
         Bt(e, t, n);
         break;
      case 21:
         Bt(e, t, n);
         break;
      case 22:
         n.mode & 1 ? (Ne = (r = Ne) || n.memoizedState !== null, Bt(e, t, n), Ne = r) : Bt(e, t, n);
         break;
      default:
         Bt(e, t, n)
   }
}

function Cf(e) {
   var t = e.updateQueue;
   if (t !== null) {
      e.updateQueue = null;
      var n = e.stateNode;
      n === null && (n = e.stateNode = new Gv), t.forEach(function (r) {
         var o = ny.bind(null, e, r);
         n.has(r) || (n.add(r), r.then(o, o))
      })
   }
}

function ft(e, t) {
   var n = t.deletions;
   if (n !== null)
      for (var r = 0; r < n.length; r++) {
         var o = n[r];
         try {
            var i = e,
               s = t,
               l = s;
            e: for (; l !== null;) {
               switch (l.tag) {
                  case 5:
                     Re = l.stateNode, ht = !1;
                     break e;
                  case 3:
                     Re = l.stateNode.containerInfo, ht = !0;
                     break e;
                  case 4:
                     Re = l.stateNode.containerInfo, ht = !0;
                     break e
               }
               l = l.return
            }
            if (Re === null) throw Error(P(160));
            Wh(i, s, o), Re = null, ht = !1;
            var a = o.alternate;
            a !== null && (a.return = null), o.return = null
         } catch (u) {
            pe(o, t, u)
         }
      }
   if (t.subtreeFlags & 12854)
      for (t = t.child; t !== null;) Gh(t, e), t = t.sibling
}

function Gh(e, t) {
   var n = e.alternate,
      r = e.flags;
   switch (e.tag) {
      case 0:
      case 11:
      case 14:
      case 15:
         if (ft(t, e), xt(e), r & 4) {
            try {
               Br(3, e, e.return), vs(3, e)
            } catch (w) {
               pe(e, e.return, w)
            }
            try {
               Br(5, e, e.return)
            } catch (w) {
               pe(e, e.return, w)
            }
         }
         break;
      case 1:
         ft(t, e), xt(e), r & 512 && n !== null && Yn(n, n.return);
         break;
      case 5:
         if (ft(t, e), xt(e), r & 512 && n !== null && Yn(n, n.return), e.flags & 32) {
            var o = e.stateNode;
            try {
               to(o, "")
            } catch (w) {
               pe(e, e.return, w)
            }
         }
         if (r & 4 && (o = e.stateNode, o != null)) {
            var i = e.memoizedProps,
               s = n !== null ? n.memoizedProps : i,
               l = e.type,
               a = e.updateQueue;
            if (e.updateQueue = null, a !== null) try {
               l === "input" && i.type === "radio" && i.name != null && pp(o, i), Gl(l, s);
               var u = Gl(l, i);
               for (s = 0; s < a.length; s += 2) {
                  var c = a[s],
                     f = a[s + 1];
                  c === "style" ? yp(o, f) : c === "dangerouslySetInnerHTML" ? gp(o, f) : c === "children" ? to(o, f) : tu(o, c, f, u)
               }
               switch (l) {
                  case "input":
                     Ul(o, i);
                     break;
                  case "textarea":
                     hp(o, i);
                     break;
                  case "select":
                     var d = o._wrapperState.wasMultiple;
                     o._wrapperState.wasMultiple = !!i.multiple;
                     var g = i.value;
                     g != null ? qn(o, !!i.multiple, g, !1) : d !== !!i.multiple && (i.defaultValue != null ? qn(o, !!i.multiple, i.defaultValue, !0) : qn(o, !!i.multiple, i.multiple ? [] : "", !1))
               }
               o[co] = i
            } catch (w) {
               pe(e, e.return, w)
            }
         }
         break;
      case 6:
         if (ft(t, e), xt(e), r & 4) {
            if (e.stateNode === null) throw Error(P(162));
            o = e.stateNode, i = e.memoizedProps;
            try {
               o.nodeValue = i
            } catch (w) {
               pe(e, e.return, w)
            }
         }
         break;
      case 3:
         if (ft(t, e), xt(e), r & 4 && n !== null && n.memoizedState.isDehydrated) try {
            io(t.containerInfo)
         } catch (w) {
            pe(e, e.return, w)
         }
         break;
      case 4:
         ft(t, e), xt(e);
         break;
      case 13:
         ft(t, e), xt(e), o = e.child, o.flags & 8192 && (i = o.memoizedState !== null, o.stateNode.isHidden = i, !i || o.alternate !== null && o.alternate.memoizedState !== null || (Du = ve())), r & 4 && Cf(e);
         break;
      case 22:
         if (c = n !== null && n.memoizedState !== null, e.mode & 1 ? (Ne = (u = Ne) || c, ft(t, e), Ne = u) : ft(t, e), xt(e), r & 8192) {
            if (u = e.memoizedState !== null, (e.stateNode.isHidden = u) && !c && (e.mode & 1) !== 0)
               for (O = e, c = e.child; c !== null;) {
                  for (f = O = c; O !== null;) {
                     switch (d = O, g = d.child, d.tag) {
                        case 0:
                        case 11:
                        case 14:
                        case 15:
                           Br(4, d, d.return);
                           break;
                        case 1:
                           Yn(d, d.return);
                           var v = d.stateNode;
                           if (typeof v.componentWillUnmount == "function") {
                              r = d, n = d.return;
                              try {
                                 t = r, v.props = t.memoizedProps, v.state = t.memoizedState, v.componentWillUnmount()
                              } catch (w) {
                                 pe(r, n, w)
                              }
                           }
                           break;
                        case 5:
                           Yn(d, d.return);
                           break;
                        case 22:
                           if (d.memoizedState !== null) {
                              Ef(f);
                              continue
                           }
                     }
                     g !== null ? (g.return = d, O = g) : Ef(f)
                  }
                  c = c.sibling
               }
            e: for (c = null, f = e;;) {
               if (f.tag === 5) {
                  if (c === null) {
                     c = f;
                     try {
                        o = f.stateNode, u ? (i = o.style, typeof i.setProperty == "function" ? i.setProperty("display", "none", "important") : i.display = "none") : (l = f.stateNode, a = f.memoizedProps.style, s = a != null && a.hasOwnProperty("display") ? a.display : null, l.style.display = vp("display", s))
                     } catch (w) {
                        pe(e, e.return, w)
                     }
                  }
               } else if (f.tag === 6) {
                  if (c === null) try {
                     f.stateNode.nodeValue = u ? "" : f.memoizedProps
                  } catch (w) {
                     pe(e, e.return, w)
                  }
               } else if ((f.tag !== 22 && f.tag !== 23 || f.memoizedState === null || f === e) && f.child !== null) {
                  f.child.return = f, f = f.child;
                  continue
               }
               if (f === e) break e;
               for (; f.sibling === null;) {
                  if (f.return === null || f.return === e) break e;
                  c === f && (c = null), f = f.return
               }
               c === f && (c = null), f.sibling.return = f.return, f = f.sibling
            }
         }
         break;
      case 19:
         ft(t, e), xt(e), r & 4 && Cf(e);
         break;
      case 21:
         break;
      default:
         ft(t, e), xt(e)
   }
}

function xt(e) {
   var t = e.flags;
   if (t & 2) {
      try {
         e: {
            for (var n = e.return; n !== null;) {
               if (bh(n)) {
                  var r = n;
                  break e
               }
               n = n.return
            }
            throw Error(P(160))
         }
         switch (r.tag) {
            case 5:
               var o = r.stateNode;
               r.flags & 32 && (to(o, ""), r.flags &= -33);
               var i = kf(e);
               ka(e, i, o);
               break;
            case 3:
            case 4:
               var s = r.stateNode.containerInfo,
                  l = kf(e);
               xa(e, l, s);
               break;
            default:
               throw Error(P(161))
         }
      }
      catch (a) {
         pe(e, e.return, a)
      }
      e.flags &= -3
   }
   t & 4096 && (e.flags &= -4097)
}

function Yv(e, t, n) {
   O = e, Qh(e)
}

function Qh(e, t, n) {
   for (var r = (e.mode & 1) !== 0; O !== null;) {
      var o = O,
         i = o.child;
      if (o.tag === 22 && r) {
         var s = o.memoizedState !== null || Jo;
         if (!s) {
            var l = o.alternate,
               a = l !== null && l.memoizedState !== null || Ne;
            l = Jo;
            var u = Ne;
            if (Jo = s, (Ne = a) && !u)
               for (O = o; O !== null;) s = O, a = s.child, s.tag === 22 && s.memoizedState !== null ? Tf(o) : a !== null ? (a.return = s, O = a) : Tf(o);
            for (; i !== null;) O = i, Qh(i), i = i.sibling;
            O = o, Jo = l, Ne = u
         }
         Pf(e)
      } else(o.subtreeFlags & 8772) !== 0 && i !== null ? (i.return = o, O = i) : Pf(e)
   }
}

function Pf(e) {
   for (; O !== null;) {
      var t = O;
      if ((t.flags & 8772) !== 0) {
         var n = t.alternate;
         try {
            if ((t.flags & 8772) !== 0) switch (t.tag) {
               case 0:
               case 11:
               case 15:
                  Ne || vs(5, t);
                  break;
               case 1:
                  var r = t.stateNode;
                  if (t.flags & 4 && !Ne)
                     if (n === null) r.componentDidMount();
                     else {
                        var o = t.elementType === t.type ? n.memoizedProps : pt(t.type, n.memoizedProps);
                        r.componentDidUpdate(o, n.memoizedState, r.__reactInternalSnapshotBeforeUpdate)
                     } var i = t.updateQueue;
                  i !== null && lf(t, i, r);
                  break;
               case 3:
                  var s = t.updateQueue;
                  if (s !== null) {
                     if (n = null, t.child !== null) switch (t.child.tag) {
                        case 5:
                           n = t.child.stateNode;
                           break;
                        case 1:
                           n = t.child.stateNode
                     }
                     lf(t, s, n)
                  }
                  break;
               case 5:
                  var l = t.stateNode;
                  if (n === null && t.flags & 4) {
                     n = l;
                     var a = t.memoizedProps;
                     switch (t.type) {
                        case "button":
                        case "input":
                        case "select":
                        case "textarea":
                           a.autoFocus && n.focus();
                           break;
                        case "img":
                           a.src && (n.src = a.src)
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
                     var u = t.alternate;
                     if (u !== null) {
                        var c = u.memoizedState;
                        if (c !== null) {
                           var f = c.dehydrated;
                           f !== null && io(f)
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
                  throw Error(P(163))
            }
            Ne || t.flags & 512 && Sa(t)
         } catch (d) {
            pe(t, t.return, d)
         }
      }
      if (t === e) {
         O = null;
         break
      }
      if (n = t.sibling, n !== null) {
         n.return = t.return, O = n;
         break
      }
      O = t.return
   }
}

function Ef(e) {
   for (; O !== null;) {
      var t = O;
      if (t === e) {
         O = null;
         break
      }
      var n = t.sibling;
      if (n !== null) {
         n.return = t.return, O = n;
         break
      }
      O = t.return
   }
}

function Tf(e) {
   for (; O !== null;) {
      var t = O;
      try {
         switch (t.tag) {
            case 0:
            case 11:
            case 15:
               var n = t.return;
               try {
                  vs(4, t)
               } catch (a) {
                  pe(t, n, a)
               }
               break;
            case 1:
               var r = t.stateNode;
               if (typeof r.componentDidMount == "function") {
                  var o = t.return;
                  try {
                     r.componentDidMount()
                  } catch (a) {
                     pe(t, o, a)
                  }
               }
               var i = t.return;
               try {
                  Sa(t)
               } catch (a) {
                  pe(t, i, a)
               }
               break;
            case 5:
               var s = t.return;
               try {
                  Sa(t)
               } catch (a) {
                  pe(t, s, a)
               }
         }
      } catch (a) {
         pe(t, t.return, a)
      }
      if (t === e) {
         O = null;
         break
      }
      var l = t.sibling;
      if (l !== null) {
         l.return = t.return, O = l;
         break
      }
      O = t.return
   }
}
var Kv = Math.ceil,
   Hi = jt.ReactCurrentDispatcher,
   Mu = jt.ReactCurrentOwner,
   st = jt.ReactCurrentBatchConfig,
   W = 0,
   Pe = null,
   ye = null,
   Ve = 0,
   Ke = 0,
   Kn = pn(0),
   ke = 0,
   vo = null,
   Rn = 0,
   ys = 0,
   Ou = 0,
   Hr = null,
   be = null,
   Du = 0,
   pr = 1 / 0,
   Rt = null,
   bi = !1,
   Ca = null,
   on = null,
   qo = !1,
   Xt = null,
   Wi = 0,
   br = 0,
   Pa = null,
   vi = -1,
   yi = 0;

function $e() {
   return (W & 6) !== 0 ? ve() : vi !== -1 ? vi : vi = ve()
}

function sn(e) {
   return (e.mode & 1) === 0 ? 1 : (W & 2) !== 0 && Ve !== 0 ? Ve & -Ve : Mv.transition !== null ? (yi === 0 && (yi = Vp()), yi) : (e = X, e !== 0 || (e = window.event, e = e === void 0 ? 16 : zp(e.type)), e)
}

function yt(e, t, n, r) {
   if (50 < br) throw br = 0, Pa = null, Error(P(185));
   _o(e, n, r), ((W & 2) === 0 || e !== Pe) && (e === Pe && ((W & 2) === 0 && (ys |= n), ke === 4 && Yt(e, Ve)), Ye(e, r), n === 1 && W === 0 && (t.mode & 1) === 0 && (pr = ve() + 500, hs && hn()))
}

function Ye(e, t) {
   var n = e.callbackNode;
   Mg(e, t);
   var r = Ai(e, e === Pe ? Ve : 0);
   if (r === 0) n !== null && Dc(n), e.callbackNode = null, e.callbackPriority = 0;
   else if (t = r & -r, e.callbackPriority !== t) {
      if (n != null && Dc(n), t === 1) e.tag === 0 ? Lv(_f.bind(null, e)) : nh(_f.bind(null, e)), _v(function () {
         (W & 6) === 0 && hn()
      }), n = null;
      else {
         switch (Lp(r)) {
            case 1:
               n = su;
               break;
            case 4:
               n = Ap;
               break;
            case 16:
               n = _i;
               break;
            case 536870912:
               n = Rp;
               break;
            default:
               n = _i
         }
         n = tm(n, Yh.bind(null, e))
      }
      e.callbackPriority = t, e.callbackNode = n
   }
}

function Yh(e, t) {
   if (vi = -1, yi = 0, (W & 6) !== 0) throw Error(P(327));
   var n = e.callbackNode;
   if (or() && e.callbackNode !== n) return null;
   var r = Ai(e, e === Pe ? Ve : 0);
   if (r === 0) return null;
   if ((r & 30) !== 0 || (r & e.expiredLanes) !== 0 || t) t = Gi(e, r);
   else {
      t = r;
      var o = W;
      W |= 2;
      var i = Xh();
      (Pe !== e || Ve !== t) && (Rt = null, pr = ve() + 500, Pn(e, t));
      do try {
         Jv();
         break
      } catch (l) {
         Kh(e, l)
      }
      while (1);
      wu(), Hi.current = i, W = o, ye !== null ? t = 0 : (Pe = null, Ve = 0, t = ke)
   }
   if (t !== 0) {
      if (t === 2 && (o = Zl(e), o !== 0 && (r = o, t = Ea(e, o))), t === 1) throw n = vo, Pn(e, 0), Yt(e, r), Ye(e, ve()), n;
      if (t === 6) Yt(e, r);
      else {
         if (o = e.current.alternate, (r & 30) === 0 && !Xv(o) && (t = Gi(e, r), t === 2 && (i = Zl(e), i !== 0 && (r = i, t = Ea(e, i))), t === 1)) throw n = vo, Pn(e, 0), Yt(e, r), Ye(e, ve()), n;
         switch (e.finishedWork = o, e.finishedLanes = r, t) {
            case 0:
            case 1:
               throw Error(P(345));
            case 2:
               yn(e, be, Rt);
               break;
            case 3:
               if (Yt(e, r), (r & 130023424) === r && (t = Du + 500 - ve(), 10 < t)) {
                  if (Ai(e, 0) !== 0) break;
                  if (o = e.suspendedLanes, (o & r) !== r) {
                     $e(), e.pingedLanes |= e.suspendedLanes & o;
                     break
                  }
                  e.timeoutHandle = ia(yn.bind(null, e, be, Rt), t);
                  break
               }
               yn(e, be, Rt);
               break;
            case 4:
               if (Yt(e, r), (r & 4194240) === r) break;
               for (t = e.eventTimes, o = -1; 0 < r;) {
                  var s = 31 - vt(r);
                  i = 1 << s, s = t[s], s > o && (o = s), r &= ~i
               }
               if (r = o, r = ve() - r, r = (120 > r ? 120 : 480 > r ? 480 : 1080 > r ? 1080 : 1920 > r ? 1920 : 3e3 > r ? 3e3 : 4320 > r ? 4320 : 1960 * Kv(r / 1960)) - r, 10 < r) {
                  e.timeoutHandle = ia(yn.bind(null, e, be, Rt), r);
                  break
               }
               yn(e, be, Rt);
               break;
            case 5:
               yn(e, be, Rt);
               break;
            default:
               throw Error(P(329))
         }
      }
   }
   return Ye(e, ve()), e.callbackNode === n ? Yh.bind(null, e) : null
}

function Ea(e, t) {
   var n = Hr;
   return e.current.memoizedState.isDehydrated && (Pn(e, t).flags |= 256), e = Gi(e, t), e !== 2 && (t = be, be = n, t !== null && Ta(t)), e
}

function Ta(e) {
   be === null ? be = e : be.push.apply(be, e)
}

function Xv(e) {
   for (var t = e;;) {
      if (t.flags & 16384) {
         var n = t.updateQueue;
         if (n !== null && (n = n.stores, n !== null))
            for (var r = 0; r < n.length; r++) {
               var o = n[r],
                  i = o.getSnapshot;
               o = o.value;
               try {
                  if (!St(i(), o)) return !1
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

function Yt(e, t) {
   for (t &= ~Ou, t &= ~ys, e.suspendedLanes |= t, e.pingedLanes &= ~t, e = e.expirationTimes; 0 < t;) {
      var n = 31 - vt(t),
         r = 1 << n;
      e[n] = -1, t &= ~r
   }
}

function _f(e) {
   if ((W & 6) !== 0) throw Error(P(327));
   or();
   var t = Ai(e, 0);
   if ((t & 1) === 0) return Ye(e, ve()), null;
   var n = Gi(e, t);
   if (e.tag !== 0 && n === 2) {
      var r = Zl(e);
      r !== 0 && (t = r, n = Ea(e, r))
   }
   if (n === 1) throw n = vo, Pn(e, 0), Yt(e, t), Ye(e, ve()), n;
   if (n === 6) throw Error(P(345));
   return e.finishedWork = e.current.alternate, e.finishedLanes = t, yn(e, be, Rt), Ye(e, ve()), null
}

function Nu(e, t) {
   var n = W;
   W |= 1;
   try {
      return e(t)
   } finally {
      W = n, W === 0 && (pr = ve() + 500, hs && hn())
   }
}

function Vn(e) {
   Xt !== null && Xt.tag === 0 && (W & 6) === 0 && or();
   var t = W;
   W |= 1;
   var n = st.transition,
      r = X;
   try {
      if (st.transition = null, X = 1, e) return e()
   } finally {
      X = r, st.transition = n, W = t, (W & 6) === 0 && hn()
   }
}

function Iu() {
   Ke = Kn.current, oe(Kn)
}

function Pn(e, t) {
   e.finishedWork = null, e.finishedLanes = 0;
   var n = e.timeoutHandle;
   if (n !== -1 && (e.timeoutHandle = -1, Tv(n)), ye !== null)
      for (n = ye.return; n !== null;) {
         var r = n;
         switch (gu(r), r.tag) {
            case 1:
               r = r.type.childContextTypes, r != null && Oi();
               break;
            case 3:
               fr(), oe(Ge), oe(Ie), Eu();
               break;
            case 5:
               Pu(r);
               break;
            case 4:
               fr();
               break;
            case 13:
               oe(ae);
               break;
            case 19:
               oe(ae);
               break;
            case 10:
               Su(r.type._context);
               break;
            case 22:
            case 23:
               Iu()
         }
         n = n.return
      }
   if (Pe = e, ye = e = ln(e.current, null), Ve = Ke = t, ke = 0, vo = null, Ou = ys = Rn = 0, be = Hr = null, xn !== null) {
      for (t = 0; t < xn.length; t++)
         if (n = xn[t], r = n.interleaved, r !== null) {
            n.interleaved = null;
            var o = r.next,
               i = n.pending;
            if (i !== null) {
               var s = i.next;
               i.next = o, r.next = s
            }
            n.pending = r
         } xn = null
   }
   return e
}

function Kh(e, t) {
   do {
      var n = ye;
      try {
         if (wu(), hi.current = Bi, Ui) {
            for (var r = ue.memoizedState; r !== null;) {
               var o = r.queue;
               o !== null && (o.pending = null), r = r.next
            }
            Ui = !1
         }
         if (An = 0, Ce = xe = ue = null, Ur = !1, ho = 0, Mu.current = null, n === null || n.return === null) {
            ke = 1, vo = t, ye = null;
            break
         }
         e: {
            var i = e,
               s = n.return,
               l = n,
               a = t;
            if (t = Ve, l.flags |= 32768, a !== null && typeof a == "object" && typeof a.then == "function") {
               var u = a,
                  c = l,
                  f = c.tag;
               if ((c.mode & 1) === 0 && (f === 0 || f === 11 || f === 15)) {
                  var d = c.alternate;
                  d ? (c.updateQueue = d.updateQueue, c.memoizedState = d.memoizedState, c.lanes = d.lanes) : (c.updateQueue = null, c.memoizedState = null)
               }
               var g = hf(s);
               if (g !== null) {
                  g.flags &= -257, mf(g, s, l, i, t), g.mode & 1 && pf(i, u, t), t = g, a = u;
                  var v = t.updateQueue;
                  if (v === null) {
                     var w = new Set;
                     w.add(a), t.updateQueue = w
                  } else v.add(a);
                  break e
               } else {
                  if ((t & 1) === 0) {
                     pf(i, u, t), zu();
                     break e
                  }
                  a = Error(P(426))
               }
            } else if (ie && l.mode & 1) {
               var k = hf(s);
               if (k !== null) {
                  (k.flags & 65536) === 0 && (k.flags |= 256), mf(k, s, l, i, t), vu(dr(a, l));
                  break e
               }
            }
            i = a = dr(a, l),
            ke !== 4 && (ke = 2),
            Hr === null ? Hr = [i] : Hr.push(i),
            i = s;do {
               switch (i.tag) {
                  case 3:
                     i.flags |= 65536, t &= -t, i.lanes |= t;
                     var m = Mh(i, a, t);
                     sf(i, m);
                     break e;
                  case 1:
                     l = a;
                     var p = i.type,
                        h = i.stateNode;
                     if ((i.flags & 128) === 0 && (typeof p.getDerivedStateFromError == "function" || h !== null && typeof h.componentDidCatch == "function" && (on === null || !on.has(h)))) {
                        i.flags |= 65536, t &= -t, i.lanes |= t;
                        var y = Oh(i, l, t);
                        sf(i, y);
                        break e
                     }
               }
               i = i.return
            } while (i !== null)
         }
         Jh(n)
      } catch (x) {
         t = x, ye === n && n !== null && (ye = n = n.return);
         continue
      }
      break
   } while (1)
}

function Xh() {
   var e = Hi.current;
   return Hi.current = Bi, e === null ? Bi : e
}

function zu() {
   (ke === 0 || ke === 3 || ke === 2) && (ke = 4), Pe === null || (Rn & 268435455) === 0 && (ys & 268435455) === 0 || Yt(Pe, Ve)
}

function Gi(e, t) {
   var n = W;
   W |= 2;
   var r = Xh();
   (Pe !== e || Ve !== t) && (Rt = null, Pn(e, t));
   do try {
      Zv();
      break
   } catch (o) {
      Kh(e, o)
   }
   while (1);
   if (wu(), W = n, Hi.current = r, ye !== null) throw Error(P(261));
   return Pe = null, Ve = 0, ke
}

function Zv() {
   for (; ye !== null;) Zh(ye)
}

function Jv() {
   for (; ye !== null && !Cg();) Zh(ye)
}

function Zh(e) {
   var t = em(e.alternate, e, Ke);
   e.memoizedProps = e.pendingProps, t === null ? Jh(e) : ye = t, Mu.current = null
}

function Jh(e) {
   var t = e;
   do {
      var n = t.alternate;
      if (e = t.return, (t.flags & 32768) === 0) {
         if (n = bv(n, t, Ke), n !== null) {
            ye = n;
            return
         }
      } else {
         if (n = Wv(n, t), n !== null) {
            n.flags &= 32767, ye = n;
            return
         }
         if (e !== null) e.flags |= 32768, e.subtreeFlags = 0, e.deletions = null;
         else {
            ke = 6, ye = null;
            return
         }
      }
      if (t = t.sibling, t !== null) {
         ye = t;
         return
      }
      ye = t = e
   } while (t !== null);
   ke === 0 && (ke = 5)
}

function yn(e, t, n) {
   var r = X,
      o = st.transition;
   try {
      st.transition = null, X = 1, qv(e, t, n, r)
   } finally {
      st.transition = o, X = r
   }
   return null
}

function qv(e, t, n, r) {
   do or(); while (Xt !== null);
   if ((W & 6) !== 0) throw Error(P(327));
   n = e.finishedWork;
   var o = e.finishedLanes;
   if (n === null) return null;
   if (e.finishedWork = null, e.finishedLanes = 0, n === e.current) throw Error(P(177));
   e.callbackNode = null, e.callbackPriority = 0;
   var i = n.lanes | n.childLanes;
   if (Og(e, i), e === Pe && (ye = Pe = null, Ve = 0), (n.subtreeFlags & 2064) === 0 && (n.flags & 2064) === 0 || qo || (qo = !0, tm(_i, function () {
         return or(), null
      })), i = (n.flags & 15990) !== 0, (n.subtreeFlags & 15990) !== 0 || i) {
      i = st.transition, st.transition = null;
      var s = X;
      X = 1;
      var l = W;
      W |= 4, Mu.current = null, Qv(e, n), Gh(n, e), wv(ra), Ri = !!na, ra = na = null, e.current = n, Yv(n), Pg(), W = l, X = s, st.transition = i
   } else e.current = n;
   if (qo && (qo = !1, Xt = e, Wi = o), i = e.pendingLanes, i === 0 && (on = null), _g(n.stateNode), Ye(e, ve()), t !== null)
      for (r = e.onRecoverableError, n = 0; n < t.length; n++) o = t[n], r(o.value, {
         componentStack: o.stack,
         digest: o.digest
      });
   if (bi) throw bi = !1, e = Ca, Ca = null, e;
   return (Wi & 1) !== 0 && e.tag !== 0 && or(), i = e.pendingLanes, (i & 1) !== 0 ? e === Pa ? br++ : (br = 0, Pa = e) : br = 0, hn(), null
}

function or() {
   if (Xt !== null) {
      var e = Lp(Wi),
         t = st.transition,
         n = X;
      try {
         if (st.transition = null, X = 16 > e ? 16 : e, Xt === null) var r = !1;
         else {
            if (e = Xt, Xt = null, Wi = 0, (W & 6) !== 0) throw Error(P(331));
            var o = W;
            for (W |= 4, O = e.current; O !== null;) {
               var i = O,
                  s = i.child;
               if ((O.flags & 16) !== 0) {
                  var l = i.deletions;
                  if (l !== null) {
                     for (var a = 0; a < l.length; a++) {
                        var u = l[a];
                        for (O = u; O !== null;) {
                           var c = O;
                           switch (c.tag) {
                              case 0:
                              case 11:
                              case 15:
                                 Br(8, c, i)
                           }
                           var f = c.child;
                           if (f !== null) f.return = c, O = f;
                           else
                              for (; O !== null;) {
                                 c = O;
                                 var d = c.sibling,
                                    g = c.return;
                                 if (Hh(c), c === u) {
                                    O = null;
                                    break
                                 }
                                 if (d !== null) {
                                    d.return = g, O = d;
                                    break
                                 }
                                 O = g
                              }
                        }
                     }
                     var v = i.alternate;
                     if (v !== null) {
                        var w = v.child;
                        if (w !== null) {
                           v.child = null;
                           do {
                              var k = w.sibling;
                              w.sibling = null, w = k
                           } while (w !== null)
                        }
                     }
                     O = i
                  }
               }
               if ((i.subtreeFlags & 2064) !== 0 && s !== null) s.return = i, O = s;
               else e: for (; O !== null;) {
                  if (i = O, (i.flags & 2048) !== 0) switch (i.tag) {
                     case 0:
                     case 11:
                     case 15:
                        Br(9, i, i.return)
                  }
                  var m = i.sibling;
                  if (m !== null) {
                     m.return = i.return, O = m;
                     break e
                  }
                  O = i.return
               }
            }
            var p = e.current;
            for (O = p; O !== null;) {
               s = O;
               var h = s.child;
               if ((s.subtreeFlags & 2064) !== 0 && h !== null) h.return = s, O = h;
               else e: for (s = p; O !== null;) {
                  if (l = O, (l.flags & 2048) !== 0) try {
                     switch (l.tag) {
                        case 0:
                        case 11:
                        case 15:
                           vs(9, l)
                     }
                  } catch (x) {
                     pe(l, l.return, x)
                  }
                  if (l === s) {
                     O = null;
                     break e
                  }
                  var y = l.sibling;
                  if (y !== null) {
                     y.return = l.return, O = y;
                     break e
                  }
                  O = l.return
               }
            }
            if (W = o, hn(), Et && typeof Et.onPostCommitFiberRoot == "function") try {
               Et.onPostCommitFiberRoot(us, e)
            } catch {}
            r = !0
         }
         return r
      } finally {
         X = n, st.transition = t
      }
   }
   return !1
}

function Af(e, t, n) {
   t = dr(n, t), t = Mh(e, t, 1), e = rn(e, t, 1), t = $e(), e !== null && (_o(e, 1, t), Ye(e, t))
}

function pe(e, t, n) {
   if (e.tag === 3) Af(e, e, n);
   else
      for (; t !== null;) {
         if (t.tag === 3) {
            Af(t, e, n);
            break
         } else if (t.tag === 1) {
            var r = t.stateNode;
            if (typeof t.type.getDerivedStateFromError == "function" || typeof r.componentDidCatch == "function" && (on === null || !on.has(r))) {
               e = dr(n, e), e = Oh(t, e, 1), t = rn(t, e, 1), e = $e(), t !== null && (_o(t, 1, e), Ye(t, e));
               break
            }
         }
         t = t.return
      }
}

function ey(e, t, n) {
   var r = e.pingCache;
   r !== null && r.delete(t), t = $e(), e.pingedLanes |= e.suspendedLanes & n, Pe === e && (Ve & n) === n && (ke === 4 || ke === 3 && (Ve & 130023424) === Ve && 500 > ve() - Du ? Pn(e, 0) : Ou |= n), Ye(e, t)
}

function qh(e, t) {
   t === 0 && ((e.mode & 1) === 0 ? t = 1 : (t = Ho, Ho <<= 1, (Ho & 130023424) === 0 && (Ho = 4194304)));
   var n = $e();
   e = zt(e, t), e !== null && (_o(e, t, n), Ye(e, n))
}

function ty(e) {
   var t = e.memoizedState,
      n = 0;
   t !== null && (n = t.retryLane), qh(e, n)
}

function ny(e, t) {
   var n = 0;
   switch (e.tag) {
      case 13:
         var r = e.stateNode,
            o = e.memoizedState;
         o !== null && (n = o.retryLane);
         break;
      case 19:
         r = e.stateNode;
         break;
      default:
         throw Error(P(314))
   }
   r !== null && r.delete(t), qh(e, n)
}
var em;
em = function (e, t, n) {
   if (e !== null)
      if (e.memoizedProps !== t.pendingProps || Ge.current) We = !0;
      else {
         if ((e.lanes & n) === 0 && (t.flags & 128) === 0) return We = !1, Hv(e, t, n);
         We = (e.flags & 131072) !== 0
      }
   else We = !1, ie && (t.flags & 1048576) !== 0 && rh(t, Ii, t.index);
   switch (t.lanes = 0, t.tag) {
      case 2:
         var r = t.type;
         gi(e, t), e = t.pendingProps;
         var o = ar(t, Ie.current);
         rr(t, n), o = _u(null, t, r, e, o, n);
         var i = Au();
         return t.flags |= 1, typeof o == "object" && o !== null && typeof o.render == "function" && o.$$typeof === void 0 ? (t.tag = 1, t.memoizedState = null, t.updateQueue = null, Qe(r) ? (i = !0, Di(t)) : i = !1, t.memoizedState = o.state !== null && o.state !== void 0 ? o.state : null, ku(t), o.updater = ms, t.stateNode = o, o._reactInternals = t, da(t, r, e, n), t = ma(null, t, r, !0, i, n)) : (t.tag = 0, ie && i && mu(t), Fe(null, t, o, n), t = t.child), t;
      case 16:
         r = t.elementType;
         e: {
            switch (gi(e, t), e = t.pendingProps, o = r._init, r = o(r._payload), t.type = r, o = t.tag = oy(r), e = pt(r, e), o) {
               case 0:
                  t = ha(null, t, r, e, n);
                  break e;
               case 1:
                  t = yf(null, t, r, e, n);
                  break e;
               case 11:
                  t = gf(null, t, r, e, n);
                  break e;
               case 14:
                  t = vf(null, t, r, pt(r.type, e), n);
                  break e
            }
            throw Error(P(306, r, ""))
         }
         return t;
      case 0:
         return r = t.type, o = t.pendingProps, o = t.elementType === r ? o : pt(r, o), ha(e, t, r, o, n);
      case 1:
         return r = t.type, o = t.pendingProps, o = t.elementType === r ? o : pt(r, o), yf(e, t, r, o, n);
      case 3:
         e: {
            if (zh(t), e === null) throw Error(P(387));r = t.pendingProps,
            i = t.memoizedState,
            o = i.element,
            lh(e, t),
            $i(t, r, null, n);
            var s = t.memoizedState;
            if (r = s.element, i.isDehydrated)
               if (i = {
                     element: r,
                     isDehydrated: !1,
                     cache: s.cache,
                     pendingSuspenseBoundaries: s.pendingSuspenseBoundaries,
                     transitions: s.transitions
                  }, t.updateQueue.baseState = i, t.memoizedState = i, t.flags & 256) {
                  o = dr(Error(P(423)), t), t = wf(e, t, r, n, o);
                  break e
               } else if (r !== o) {
               o = dr(Error(P(424)), t), t = wf(e, t, r, n, o);
               break e
            } else
               for (Xe = nn(t.stateNode.containerInfo.firstChild), Ze = t, ie = !0, mt = null, n = fh(t, null, r, n), t.child = n; n;) n.flags = n.flags & -3 | 4096, n = n.sibling;
            else {
               if (ur(), r === o) {
                  t = Ft(e, t, n);
                  break e
               }
               Fe(e, t, r, n)
            }
            t = t.child
         }
         return t;
      case 5:
         return dh(t), e === null && ua(t), r = t.type, o = t.pendingProps, i = e !== null ? e.memoizedProps : null, s = o.children, oa(r, o) ? s = null : i !== null && oa(r, i) && (t.flags |= 32), Ih(e, t), Fe(e, t, s, n), t.child;
      case 6:
         return e === null && ua(t), null;
      case 13:
         return Fh(e, t, n);
      case 4:
         return Cu(t, t.stateNode.containerInfo), r = t.pendingProps, e === null ? t.child = cr(t, null, r, n) : Fe(e, t, r, n), t.child;
      case 11:
         return r = t.type, o = t.pendingProps, o = t.elementType === r ? o : pt(r, o), gf(e, t, r, o, n);
      case 7:
         return Fe(e, t, t.pendingProps, n), t.child;
      case 8:
         return Fe(e, t, t.pendingProps.children, n), t.child;
      case 12:
         return Fe(e, t, t.pendingProps.children, n), t.child;
      case 10:
         e: {
            if (r = t.type._context, o = t.pendingProps, i = t.memoizedProps, s = o.value, te(zi, r._currentValue), r._currentValue = s, i !== null)
               if (St(i.value, s)) {
                  if (i.children === o.children && !Ge.current) {
                     t = Ft(e, t, n);
                     break e
                  }
               } else
                  for (i = t.child, i !== null && (i.return = t); i !== null;) {
                     var l = i.dependencies;
                     if (l !== null) {
                        s = i.child;
                        for (var a = l.firstContext; a !== null;) {
                           if (a.context === r) {
                              if (i.tag === 1) {
                                 a = Dt(-1, n & -n), a.tag = 2;
                                 var u = i.updateQueue;
                                 if (u !== null) {
                                    u = u.shared;
                                    var c = u.pending;
                                    c === null ? a.next = a : (a.next = c.next, c.next = a), u.pending = a
                                 }
                              }
                              i.lanes |= n, a = i.alternate, a !== null && (a.lanes |= n), ca(i.return, n, t), l.lanes |= n;
                              break
                           }
                           a = a.next
                        }
                     } else if (i.tag === 10) s = i.type === t.type ? null : i.child;
                     else if (i.tag === 18) {
                        if (s = i.return, s === null) throw Error(P(341));
                        s.lanes |= n, l = s.alternate, l !== null && (l.lanes |= n), ca(s, n, t), s = i.sibling
                     } else s = i.child;
                     if (s !== null) s.return = i;
                     else
                        for (s = i; s !== null;) {
                           if (s === t) {
                              s = null;
                              break
                           }
                           if (i = s.sibling, i !== null) {
                              i.return = s.return, s = i;
                              break
                           }
                           s = s.return
                        }
                     i = s
                  }
            Fe(e, t, o.children, n),
            t = t.child
         }
         return t;
      case 9:
         return o = t.type, r = t.pendingProps.children, rr(t, n), o = at(o), r = r(o), t.flags |= 1, Fe(e, t, r, n), t.child;
      case 14:
         return r = t.type, o = pt(r, t.pendingProps), o = pt(r.type, o), vf(e, t, r, o, n);
      case 15:
         return Dh(e, t, t.type, t.pendingProps, n);
      case 17:
         return r = t.type, o = t.pendingProps, o = t.elementType === r ? o : pt(r, o), gi(e, t), t.tag = 1, Qe(r) ? (e = !0, Di(t)) : e = !1, rr(t, n), uh(t, r, o), da(t, r, o, n), ma(null, t, r, !0, e, n);
      case 19:
         return $h(e, t, n);
      case 22:
         return Nh(e, t, n)
   }
   throw Error(P(156, t.tag))
};

function tm(e, t) {
   return _p(e, t)
}

function ry(e, t, n, r) {
   this.tag = e, this.key = n, this.sibling = this.child = this.return = this.stateNode = this.type = this.elementType = null, this.index = 0, this.ref = null, this.pendingProps = t, this.dependencies = this.memoizedState = this.updateQueue = this.memoizedProps = null, this.mode = r, this.subtreeFlags = this.flags = 0, this.deletions = null, this.childLanes = this.lanes = 0, this.alternate = null
}

function it(e, t, n, r) {
   return new ry(e, t, n, r)
}

function Fu(e) {
   return e = e.prototype, !(!e || !e.isReactComponent)
}

function oy(e) {
   if (typeof e == "function") return Fu(e) ? 1 : 0;
   if (e != null) {
      if (e = e.$$typeof, e === ru) return 11;
      if (e === ou) return 14
   }
   return 2
}

function ln(e, t) {
   var n = e.alternate;
   return n === null ? (n = it(e.tag, t, e.key, e.mode), n.elementType = e.elementType, n.type = e.type, n.stateNode = e.stateNode, n.alternate = e, e.alternate = n) : (n.pendingProps = t, n.type = e.type, n.flags = 0, n.subtreeFlags = 0, n.deletions = null), n.flags = e.flags & 14680064, n.childLanes = e.childLanes, n.lanes = e.lanes, n.child = e.child, n.memoizedProps = e.memoizedProps, n.memoizedState = e.memoizedState, n.updateQueue = e.updateQueue, t = e.dependencies, n.dependencies = t === null ? null : {
      lanes: t.lanes,
      firstContext: t.firstContext
   }, n.sibling = e.sibling, n.index = e.index, n.ref = e.ref, n
}

function wi(e, t, n, r, o, i) {
   var s = 2;
   if (r = e, typeof e == "function") Fu(e) && (s = 1);
   else if (typeof e == "string") s = 5;
   else e: switch (e) {
      case $n:
         return En(n.children, o, i, t);
      case nu:
         s = 8, o |= 8;
         break;
      case Il:
         return e = it(12, n, t, o | 2), e.elementType = Il, e.lanes = i, e;
      case zl:
         return e = it(13, n, t, o), e.elementType = zl, e.lanes = i, e;
      case Fl:
         return e = it(19, n, t, o), e.elementType = Fl, e.lanes = i, e;
      case cp:
         return ws(n, o, i, t);
      default:
         if (typeof e == "object" && e !== null) switch (e.$$typeof) {
            case ap:
               s = 10;
               break e;
            case up:
               s = 9;
               break e;
            case ru:
               s = 11;
               break e;
            case ou:
               s = 14;
               break e;
            case bt:
               s = 16, r = null;
               break e
         }
         throw Error(P(130, e == null ? e : typeof e, ""))
   }
   return t = it(s, n, t, o), t.elementType = e, t.type = r, t.lanes = i, t
}

function En(e, t, n, r) {
   return e = it(7, e, r, t), e.lanes = n, e
}

function ws(e, t, n, r) {
   return e = it(22, e, r, t), e.elementType = cp, e.lanes = n, e.stateNode = {
      isHidden: !1
   }, e
}

function yl(e, t, n) {
   return e = it(6, e, null, t), e.lanes = n, e
}

function wl(e, t, n) {
   return t = it(4, e.children !== null ? e.children : [], e.key, t), t.lanes = n, t.stateNode = {
      containerInfo: e.containerInfo,
      pendingChildren: null,
      implementation: e.implementation
   }, t
}

function iy(e, t, n, r, o) {
   this.tag = t, this.containerInfo = e, this.finishedWork = this.pingCache = this.current = this.pendingChildren = null, this.timeoutHandle = -1, this.callbackNode = this.pendingContext = this.context = null, this.callbackPriority = 0, this.eventTimes = qs(0), this.expirationTimes = qs(-1), this.entangledLanes = this.finishedLanes = this.mutableReadLanes = this.expiredLanes = this.pingedLanes = this.suspendedLanes = this.pendingLanes = 0, this.entanglements = qs(0), this.identifierPrefix = r, this.onRecoverableError = o, this.mutableSourceEagerHydrationData = null
}

function $u(e, t, n, r, o, i, s, l, a) {
   return e = new iy(e, t, n, l, a), t === 1 ? (t = 1, i === !0 && (t |= 8)) : t = 0, i = it(3, null, null, t), e.current = i, i.stateNode = e, i.memoizedState = {
      element: r,
      isDehydrated: n,
      cache: null,
      transitions: null,
      pendingSuspenseBoundaries: null
   }, ku(i), e
}

function sy(e, t, n) {
   var r = 3 < arguments.length && arguments[3] !== void 0 ? arguments[3] : null;
   return {
      $$typeof: Fn,
      key: r == null ? null : "" + r,
      children: e,
      containerInfo: t,
      implementation: n
   }
}

function nm(e) {
   if (!e) return cn;
   e = e._reactInternals;
   e: {
      if (On(e) !== e || e.tag !== 1) throw Error(P(170));
      var t = e;do {
         switch (t.tag) {
            case 3:
               t = t.stateNode.context;
               break e;
            case 1:
               if (Qe(t.type)) {
                  t = t.stateNode.__reactInternalMemoizedMergedChildContext;
                  break e
               }
         }
         t = t.return
      } while (t !== null);
      throw Error(P(171))
   }
   if (e.tag === 1) {
      var n = e.type;
      if (Qe(n)) return th(e, n, t)
   }
   return t
}

function rm(e, t, n, r, o, i, s, l, a) {
   return e = $u(n, r, !0, e, o, i, s, l, a), e.context = nm(null), n = e.current, r = $e(), o = sn(n), i = Dt(r, o), i.callback = t != null ? t : null, rn(n, i, o), e.current.lanes = o, _o(e, o, r), Ye(e, r), e
}

function Ss(e, t, n, r) {
   var o = t.current,
      i = $e(),
      s = sn(o);
   return n = nm(n), t.context === null ? t.context = n : t.pendingContext = n, t = Dt(i, s), t.payload = {
      element: e
   }, r = r === void 0 ? null : r, r !== null && (t.callback = r), e = rn(o, t, s), e !== null && (yt(e, o, s, i), pi(e, o, s)), s
}

function Qi(e) {
   if (e = e.current, !e.child) return null;
   switch (e.child.tag) {
      case 5:
         return e.child.stateNode;
      default:
         return e.child.stateNode
   }
}

function Rf(e, t) {
   if (e = e.memoizedState, e !== null && e.dehydrated !== null) {
      var n = e.retryLane;
      e.retryLane = n !== 0 && n < t ? n : t
   }
}

function ju(e, t) {
   Rf(e, t), (e = e.alternate) && Rf(e, t)
}

function ly() {
   return null
}
var om = typeof reportError == "function" ? reportError : function (e) {
   console.error(e)
};

function Uu(e) {
   this._internalRoot = e
}
xs.prototype.render = Uu.prototype.render = function (e) {
   var t = this._internalRoot;
   if (t === null) throw Error(P(409));
   Ss(e, t, null, null)
};
xs.prototype.unmount = Uu.prototype.unmount = function () {
   var e = this._internalRoot;
   if (e !== null) {
      this._internalRoot = null;
      var t = e.containerInfo;
      Vn(function () {
         Ss(null, e, null, null)
      }), t[It] = null
   }
};

function xs(e) {
   this._internalRoot = e
}
xs.prototype.unstable_scheduleHydration = function (e) {
   if (e) {
      var t = Dp();
      e = {
         blockedOn: null,
         target: e,
         priority: t
      };
      for (var n = 0; n < Qt.length && t !== 0 && t < Qt[n].priority; n++);
      Qt.splice(n, 0, e), n === 0 && Ip(e)
   }
};

function Bu(e) {
   return !(!e || e.nodeType !== 1 && e.nodeType !== 9 && e.nodeType !== 11)
}

function ks(e) {
   return !(!e || e.nodeType !== 1 && e.nodeType !== 9 && e.nodeType !== 11 && (e.nodeType !== 8 || e.nodeValue !== " react-mount-point-unstable "))
}

function Vf() {}

function ay(e, t, n, r, o) {
   if (o) {
      if (typeof r == "function") {
         var i = r;
         r = function () {
            var u = Qi(s);
            i.call(u)
         }
      }
      var s = rm(t, r, e, 0, null, !1, !1, "", Vf);
      return e._reactRootContainer = s, e[It] = s.current, ao(e.nodeType === 8 ? e.parentNode : e), Vn(), s
   }
   for (; o = e.lastChild;) e.removeChild(o);
   if (typeof r == "function") {
      var l = r;
      r = function () {
         var u = Qi(a);
         l.call(u)
      }
   }
   var a = $u(e, 0, !1, null, null, !1, !1, "", Vf);
   return e._reactRootContainer = a, e[It] = a.current, ao(e.nodeType === 8 ? e.parentNode : e), Vn(function () {
      Ss(t, a, n, r)
   }), a
}

function Cs(e, t, n, r, o) {
   var i = n._reactRootContainer;
   if (i) {
      var s = i;
      if (typeof o == "function") {
         var l = o;
         o = function () {
            var a = Qi(s);
            l.call(a)
         }
      }
      Ss(t, s, e, o)
   } else s = ay(n, t, e, o, r);
   return Qi(s)
}
Mp = function (e) {
   switch (e.tag) {
      case 3:
         var t = e.stateNode;
         if (t.current.memoizedState.isDehydrated) {
            var n = Dr(t.pendingLanes);
            n !== 0 && (lu(t, n | 1), Ye(t, ve()), (W & 6) === 0 && (pr = ve() + 500, hn()))
         }
         break;
      case 13:
         Vn(function () {
            var r = zt(e, 1);
            if (r !== null) {
               var o = $e();
               yt(r, e, 1, o)
            }
         }), ju(e, 1)
   }
};
au = function (e) {
   if (e.tag === 13) {
      var t = zt(e, 134217728);
      if (t !== null) {
         var n = $e();
         yt(t, e, 134217728, n)
      }
      ju(e, 134217728)
   }
};
Op = function (e) {
   if (e.tag === 13) {
      var t = sn(e),
         n = zt(e, t);
      if (n !== null) {
         var r = $e();
         yt(n, e, t, r)
      }
      ju(e, t)
   }
};
Dp = function () {
   return X
};
Np = function (e, t) {
   var n = X;
   try {
      return X = e, t()
   } finally {
      X = n
   }
};
Yl = function (e, t, n) {
   switch (t) {
      case "input":
         if (Ul(e, n), t = n.name, n.type === "radio" && t != null) {
            for (n = e; n.parentNode;) n = n.parentNode;
            for (n = n.querySelectorAll("input[name=" + JSON.stringify("" + t) + '][type="radio"]'), t = 0; t < n.length; t++) {
               var r = n[t];
               if (r !== e && r.form === e.form) {
                  var o = ps(r);
                  if (!o) throw Error(P(90));
                  dp(r), Ul(r, o)
               }
            }
         }
         break;
      case "textarea":
         hp(e, n);
         break;
      case "select":
         t = n.value, t != null && qn(e, !!n.multiple, t, !1)
   }
};
xp = Nu;
kp = Vn;
var uy = {
      usingClientEntryPoint: !1,
      Events: [Ro, Hn, ps, wp, Sp, Nu]
   },
   Rr = {
      findFiberByHostInstance: Sn,
      bundleType: 0,
      version: "18.2.0",
      rendererPackageName: "react-dom"
   },
   cy = {
      bundleType: Rr.bundleType,
      version: Rr.version,
      rendererPackageName: Rr.rendererPackageName,
      rendererConfig: Rr.rendererConfig,
      overrideHookState: null,
      overrideHookStateDeletePath: null,
      overrideHookStateRenamePath: null,
      overrideProps: null,
      overridePropsDeletePath: null,
      overridePropsRenamePath: null,
      setErrorHandler: null,
      setSuspenseHandler: null,
      scheduleUpdate: null,
      currentDispatcherRef: jt.ReactCurrentDispatcher,
      findHostInstanceByFiber: function (e) {
         return e = Ep(e), e === null ? null : e.stateNode
      },
      findFiberByHostInstance: Rr.findFiberByHostInstance || ly,
      findHostInstancesForRefresh: null,
      scheduleRefresh: null,
      scheduleRoot: null,
      setRefreshHandler: null,
      getCurrentFiber: null,
      reconcilerVersion: "18.2.0-next-9e3b772b8-20220608"
   };
if (typeof __REACT_DEVTOOLS_GLOBAL_HOOK__ != "undefined") {
   var ei = __REACT_DEVTOOLS_GLOBAL_HOOK__;
   if (!ei.isDisabled && ei.supportsFiber) try {
      us = ei.inject(cy), Et = ei
   } catch {}
}
et.__SECRET_INTERNALS_DO_NOT_USE_OR_YOU_WILL_BE_FIRED = uy;
et.createPortal = function (e, t) {
   var n = 2 < arguments.length && arguments[2] !== void 0 ? arguments[2] : null;
   if (!Bu(t)) throw Error(P(200));
   return sy(e, t, null, n)
};
et.createRoot = function (e, t) {
   if (!Bu(e)) throw Error(P(299));
   var n = !1,
      r = "",
      o = om;
   return t != null && (t.unstable_strictMode === !0 && (n = !0), t.identifierPrefix !== void 0 && (r = t.identifierPrefix), t.onRecoverableError !== void 0 && (o = t.onRecoverableError)), t = $u(e, 1, !1, null, null, n, !1, r, o), e[It] = t.current, ao(e.nodeType === 8 ? e.parentNode : e), new Uu(t)
};
et.findDOMNode = function (e) {
   if (e == null) return null;
   if (e.nodeType === 1) return e;
   var t = e._reactInternals;
   if (t === void 0) throw typeof e.render == "function" ? Error(P(188)) : (e = Object.keys(e).join(","), Error(P(268, e)));
   return e = Ep(t), e = e === null ? null : e.stateNode, e
};
et.flushSync = function (e) {
   return Vn(e)
};
et.hydrate = function (e, t, n) {
   if (!ks(t)) throw Error(P(200));
   return Cs(null, e, t, !0, n)
};
et.hydrateRoot = function (e, t, n) {
   if (!Bu(e)) throw Error(P(405));
   var r = n != null && n.hydratedSources || null,
      o = !1,
      i = "",
      s = om;
   if (n != null && (n.unstable_strictMode === !0 && (o = !0), n.identifierPrefix !== void 0 && (i = n.identifierPrefix), n.onRecoverableError !== void 0 && (s = n.onRecoverableError)), t = rm(t, null, e, 1, n != null ? n : null, o, !1, i, s), e[It] = t.current, ao(e), r)
      for (e = 0; e < r.length; e++) n = r[e], o = n._getVersion, o = o(n._source), t.mutableSourceEagerHydrationData == null ? t.mutableSourceEagerHydrationData = [n, o] : t.mutableSourceEagerHydrationData.push(n, o);
   return new xs(t)
};
et.render = function (e, t, n) {
   if (!ks(t)) throw Error(P(200));
   return Cs(null, e, t, !1, n)
};
et.unmountComponentAtNode = function (e) {
   if (!ks(e)) throw Error(P(40));
   return e._reactRootContainer ? (Vn(function () {
      Cs(null, null, e, !1, function () {
         e._reactRootContainer = null, e[It] = null
      })
   }), !0) : !1
};
et.unstable_batchedUpdates = Nu;
et.unstable_renderSubtreeIntoContainer = function (e, t, n, r) {
   if (!ks(n)) throw Error(P(200));
   if (e == null || e._reactInternals === void 0) throw Error(P(38));
   return Cs(e, t, n, !1, r)
};
et.version = "18.2.0-next-9e3b772b8-20220608";

function im() {
   if (!(typeof __REACT_DEVTOOLS_GLOBAL_HOOK__ == "undefined" || typeof __REACT_DEVTOOLS_GLOBAL_HOOK__.checkDCE != "function")) try {
      __REACT_DEVTOOLS_GLOBAL_HOOK__.checkDCE(im)
   } catch (e) {
      console.error(e)
   }
}
im(), rp.exports = et;
var Lf = rp.exports;
Dl.createRoot = Lf.createRoot, Dl.hydrateRoot = Lf.hydrateRoot;
const sm = () => !window.invokeNative,
   fy = () => {},
   lm = (e, t) => {
      const n = C.exports.useRef(fy);
      C.exports.useEffect(() => {
         n.current = t
      }, [t]), C.exports.useEffect(() => {
         const r = o => {
            const {
               action: i,
               data: s
            } = o.data;
            n.current && i === e && n.current(s)
         };
         return window.addEventListener("message", r), () => window.removeEventListener("message", r)
      }, [e])
   };
async function Wr(e, t, n) {
   const r = {
      method: "post",
      headers: {
         "Content-Type": "application/json; charset=UTF-8"
      },
      body: JSON.stringify(t)
   };
   if (sm() && n) return n;
   const o = window.GetParentResourceName ? window.GetParentResourceName() : "creative-groups";
   return await (await fetch(`https://${o}/${e}`, r)).json()
}
var Ps = {
      exports: {}
   },
   Es = {};
/**
 * @license React
 * react-jsx-runtime.production.min.js
 *
 * Copyright (c) Facebook, Inc. and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */
var dy = C.exports,
   py = Symbol.for("react.element"),
   hy = Symbol.for("react.fragment"),
   my = Object.prototype.hasOwnProperty,
   gy = dy.__SECRET_INTERNALS_DO_NOT_USE_OR_YOU_WILL_BE_FIRED.ReactCurrentOwner,
   vy = {
      key: !0,
      ref: !0,
      __self: !0,
      __source: !0
   };

function am(e, t, n) {
   var r, o = {},
      i = null,
      s = null;
   n !== void 0 && (i = "" + n), t.key !== void 0 && (i = "" + t.key), t.ref !== void 0 && (s = t.ref);
   for (r in t) my.call(t, r) && !vy.hasOwnProperty(r) && (o[r] = t[r]);
   if (e && e.defaultProps)
      for (r in t = e.defaultProps, t) o[r] === void 0 && (o[r] = t[r]);
   return {
      $$typeof: py,
      type: e,
      key: i,
      ref: s,
      props: o,
      _owner: gy.current
   }
}
Es.Fragment = hy;
Es.jsx = am;
Es.jsxs = am;
Ps.exports = Es;
const B = Ps.exports.jsx,
   gt = Ps.exports.jsxs,
   yy = Ps.exports.Fragment,
   um = C.exports.createContext(null),
   wy = ({
      children: e
   }) => {
      const [t, n] = C.exports.useState(!1);
      return lm("setVisible", n), C.exports.useEffect(() => {
         if (!t) return;
         const r = o => {
            ["Escape"].includes(o.code) && (sm() ? n(!t) : (Wr("close"), n(!1)))
         };
         return window.addEventListener("keydown", r), () => window.removeEventListener("keydown", r)
      }, [t]), B(um.Provider, {
         value: {
            visible: t,
            setVisible: n
         },
         children: e
      })
   },
   Sy = () => C.exports.useContext(um);
var Ts = {
      exports: {}
   },
   Z = {};
/** @license React v16.13.1
 * react-is.production.min.js
 *
 * Copyright (c) Facebook, Inc. and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */
var Ee = typeof Symbol == "function" && Symbol.for,
   Hu = Ee ? Symbol.for("react.element") : 60103,
   bu = Ee ? Symbol.for("react.portal") : 60106,
   _s = Ee ? Symbol.for("react.fragment") : 60107,
   As = Ee ? Symbol.for("react.strict_mode") : 60108,
   Rs = Ee ? Symbol.for("react.profiler") : 60114,
   Vs = Ee ? Symbol.for("react.provider") : 60109,
   Ls = Ee ? Symbol.for("react.context") : 60110,
   Wu = Ee ? Symbol.for("react.async_mode") : 60111,
   Ms = Ee ? Symbol.for("react.concurrent_mode") : 60111,
   Os = Ee ? Symbol.for("react.forward_ref") : 60112,
   Ds = Ee ? Symbol.for("react.suspense") : 60113,
   xy = Ee ? Symbol.for("react.suspense_list") : 60120,
   Ns = Ee ? Symbol.for("react.memo") : 60115,
   Is = Ee ? Symbol.for("react.lazy") : 60116,
   ky = Ee ? Symbol.for("react.block") : 60121,
   Cy = Ee ? Symbol.for("react.fundamental") : 60117,
   Py = Ee ? Symbol.for("react.responder") : 60118,
   Ey = Ee ? Symbol.for("react.scope") : 60119;

function nt(e) {
   if (typeof e == "object" && e !== null) {
      var t = e.$$typeof;
      switch (t) {
         case Hu:
            switch (e = e.type, e) {
               case Wu:
               case Ms:
               case _s:
               case Rs:
               case As:
               case Ds:
                  return e;
               default:
                  switch (e = e && e.$$typeof, e) {
                     case Ls:
                     case Os:
                     case Is:
                     case Ns:
                     case Vs:
                        return e;
                     default:
                        return t
                  }
            }
         case bu:
            return t
      }
   }
}

function cm(e) {
   return nt(e) === Ms
}
Z.AsyncMode = Wu;
Z.ConcurrentMode = Ms;
Z.ContextConsumer = Ls;
Z.ContextProvider = Vs;
Z.Element = Hu;
Z.ForwardRef = Os;
Z.Fragment = _s;
Z.Lazy = Is;
Z.Memo = Ns;
Z.Portal = bu;
Z.Profiler = Rs;
Z.StrictMode = As;
Z.Suspense = Ds;
Z.isAsyncMode = function (e) {
   return cm(e) || nt(e) === Wu
};
Z.isConcurrentMode = cm;
Z.isContextConsumer = function (e) {
   return nt(e) === Ls
};
Z.isContextProvider = function (e) {
   return nt(e) === Vs
};
Z.isElement = function (e) {
   return typeof e == "object" && e !== null && e.$$typeof === Hu
};
Z.isForwardRef = function (e) {
   return nt(e) === Os
};
Z.isFragment = function (e) {
   return nt(e) === _s
};
Z.isLazy = function (e) {
   return nt(e) === Is
};
Z.isMemo = function (e) {
   return nt(e) === Ns
};
Z.isPortal = function (e) {
   return nt(e) === bu
};
Z.isProfiler = function (e) {
   return nt(e) === Rs
};
Z.isStrictMode = function (e) {
   return nt(e) === As
};
Z.isSuspense = function (e) {
   return nt(e) === Ds
};
Z.isValidElementType = function (e) {
   return typeof e == "string" || typeof e == "function" || e === _s || e === Ms || e === Rs || e === As || e === Ds || e === xy || typeof e == "object" && e !== null && (e.$$typeof === Is || e.$$typeof === Ns || e.$$typeof === Vs || e.$$typeof === Ls || e.$$typeof === Os || e.$$typeof === Cy || e.$$typeof === Py || e.$$typeof === Ey || e.$$typeof === ky)
};
Z.typeOf = nt;
Ts.exports = Z;

function Ty(e) {
   function t(V, L, M, $, S) {
      for (var b = 0, R = 0, de = 0, Q = 0, K, U, Te = 0, He = 0, G, Me = G = K = 0, Y = 0, _e = 0, Sr = 0, Ae = 0, zo = M.length, xr = zo - 1, ct, j = "", ge = "", Gs = "", Qs = "", Ut; Y < zo;) {
         if (U = M.charCodeAt(Y), Y === xr && R + Q + de + b !== 0 && (R !== 0 && (U = R === 47 ? 10 : 47), Q = de = b = 0, zo++, xr++), R + Q + de + b === 0) {
            if (Y === xr && (0 < _e && (j = j.replace(d, "")), 0 < j.trim().length)) {
               switch (U) {
                  case 32:
                  case 9:
                  case 59:
                  case 13:
                  case 10:
                     break;
                  default:
                     j += M.charAt(Y)
               }
               U = 59
            }
            switch (U) {
               case 123:
                  for (j = j.trim(), K = j.charCodeAt(0), G = 1, Ae = ++Y; Y < zo;) {
                     switch (U = M.charCodeAt(Y)) {
                        case 123:
                           G++;
                           break;
                        case 125:
                           G--;
                           break;
                        case 47:
                           switch (U = M.charCodeAt(Y + 1)) {
                              case 42:
                              case 47:
                                 e: {
                                    for (Me = Y + 1; Me < xr; ++Me) switch (M.charCodeAt(Me)) {
                                       case 47:
                                          if (U === 42 && M.charCodeAt(Me - 1) === 42 && Y + 2 !== Me) {
                                             Y = Me + 1;
                                             break e
                                          }
                                          break;
                                       case 10:
                                          if (U === 47) {
                                             Y = Me + 1;
                                             break e
                                          }
                                    }
                                    Y = Me
                                 }
                           }
                           break;
                        case 91:
                           U++;
                        case 40:
                           U++;
                        case 34:
                        case 39:
                           for (; Y++ < xr && M.charCodeAt(Y) !== U;);
                     }
                     if (G === 0) break;
                     Y++
                  }
                  switch (G = M.substring(Ae, Y), K === 0 && (K = (j = j.replace(f, "").trim()).charCodeAt(0)), K) {
                     case 64:
                        switch (0 < _e && (j = j.replace(d, "")), U = j.charCodeAt(1), U) {
                           case 100:
                           case 109:
                           case 115:
                           case 45:
                              _e = L;
                              break;
                           default:
                              _e = ne
                        }
                        if (G = t(L, _e, G, U, S + 1), Ae = G.length, 0 < _ && (_e = n(ne, j, Sr), Ut = l(3, G, _e, L, fe, J, Ae, U, S, $), j = _e.join(""), Ut !== void 0 && (Ae = (G = Ut.trim()).length) === 0 && (U = 0, G = "")), 0 < Ae) switch (U) {
                           case 115:
                              j = j.replace(E, s);
                           case 100:
                           case 109:
                           case 45:
                              G = j + "{" + G + "}";
                              break;
                           case 107:
                              j = j.replace(p, "$1 $2"), G = j + "{" + G + "}", G = le === 1 || le === 2 && i("@" + G, 3) ? "@-webkit-" + G + "@" + G : "@" + G;
                              break;
                           default:
                              G = j + G, $ === 112 && (G = (ge += G, ""))
                        } else G = "";
                        break;
                     default:
                        G = t(L, n(L, j, Sr), G, $, S + 1)
                  }
                  Gs += G, G = Sr = _e = Me = K = 0, j = "", U = M.charCodeAt(++Y);
                  break;
               case 125:
               case 59:
                  if (j = (0 < _e ? j.replace(d, "") : j).trim(), 1 < (Ae = j.length)) switch (Me === 0 && (K = j.charCodeAt(0), K === 45 || 96 < K && 123 > K) && (Ae = (j = j.replace(" ", ":")).length), 0 < _ && (Ut = l(1, j, L, V, fe, J, ge.length, $, S, $)) !== void 0 && (Ae = (j = Ut.trim()).length) === 0 && (j = "\0\0"), K = j.charCodeAt(0), U = j.charCodeAt(1), K) {
                     case 0:
                        break;
                     case 64:
                        if (U === 105 || U === 99) {
                           Qs += j + M.charAt(Y);
                           break
                        }
                     default:
                        j.charCodeAt(Ae - 1) !== 58 && (ge += o(j, K, U, j.charCodeAt(2)))
                  }
                  Sr = _e = Me = K = 0, j = "", U = M.charCodeAt(++Y)
            }
         }
         switch (U) {
            case 13:
            case 10:
               R === 47 ? R = 0 : 1 + K === 0 && $ !== 107 && 0 < j.length && (_e = 1, j += "\0"), 0 < _ * F && l(0, j, L, V, fe, J, ge.length, $, S, $), J = 1, fe++;
               break;
            case 59:
            case 125:
               if (R + Q + de + b === 0) {
                  J++;
                  break
               }
            default:
               switch (J++, ct = M.charAt(Y), U) {
                  case 9:
                  case 32:
                     if (Q + b + R === 0) switch (Te) {
                        case 44:
                        case 58:
                        case 9:
                        case 32:
                           ct = "";
                           break;
                        default:
                           U !== 32 && (ct = " ")
                     }
                     break;
                  case 0:
                     ct = "\\0";
                     break;
                  case 12:
                     ct = "\\f";
                     break;
                  case 11:
                     ct = "\\v";
                     break;
                  case 38:
                     Q + R + b === 0 && (_e = Sr = 1, ct = "\f" + ct);
                     break;
                  case 108:
                     if (Q + R + b + we === 0 && 0 < Me) switch (Y - Me) {
                        case 2:
                           Te === 112 && M.charCodeAt(Y - 3) === 58 && (we = Te);
                        case 8:
                           He === 111 && (we = He)
                     }
                     break;
                  case 58:
                     Q + R + b === 0 && (Me = Y);
                     break;
                  case 44:
                     R + de + Q + b === 0 && (_e = 1, ct += "\r");
                     break;
                  case 34:
                  case 39:
                     R === 0 && (Q = Q === U ? 0 : Q === 0 ? U : Q);
                     break;
                  case 91:
                     Q + R + de === 0 && b++;
                     break;
                  case 93:
                     Q + R + de === 0 && b--;
                     break;
                  case 41:
                     Q + R + b === 0 && de--;
                     break;
                  case 40:
                     if (Q + R + b === 0) {
                        if (K === 0) switch (2 * Te + 3 * He) {
                           case 533:
                              break;
                           default:
                              K = 1
                        }
                        de++
                     }
                     break;
                  case 64:
                     R + de + Q + b + Me + G === 0 && (G = 1);
                     break;
                  case 42:
                  case 47:
                     if (!(0 < Q + b + de)) switch (R) {
                        case 0:
                           switch (2 * U + 3 * M.charCodeAt(Y + 1)) {
                              case 235:
                                 R = 47;
                                 break;
                              case 220:
                                 Ae = Y, R = 42
                           }
                           break;
                        case 42:
                           U === 47 && Te === 42 && Ae + 2 !== Y && (M.charCodeAt(Ae + 2) === 33 && (ge += M.substring(Ae, Y + 1)), ct = "", R = 0)
                     }
               }
               R === 0 && (j += ct)
         }
         He = Te, Te = U, Y++
      }
      if (Ae = ge.length, 0 < Ae) {
         if (_e = L, 0 < _ && (Ut = l(2, ge, _e, V, fe, J, Ae, $, S, $), Ut !== void 0 && (ge = Ut).length === 0)) return Qs + ge + Gs;
         if (ge = _e.join(",") + "{" + ge + "}", le * we !== 0) {
            switch (le !== 2 || i(ge, 2) || (we = 0), we) {
               case 111:
                  ge = ge.replace(y, ":-moz-$1") + ge;
                  break;
               case 112:
                  ge = ge.replace(h, "::-webkit-input-$1") + ge.replace(h, "::-moz-$1") + ge.replace(h, ":-ms-input-$1") + ge
            }
            we = 0
         }
      }
      return Qs + ge + Gs
   }

   function n(V, L, M) {
      var $ = L.trim().split(k);
      L = $;
      var S = $.length,
         b = V.length;
      switch (b) {
         case 0:
         case 1:
            var R = 0;
            for (V = b === 0 ? "" : V[0] + " "; R < S; ++R) L[R] = r(V, L[R], M).trim();
            break;
         default:
            var de = R = 0;
            for (L = []; R < S; ++R)
               for (var Q = 0; Q < b; ++Q) L[de++] = r(V[Q] + " ", $[R], M).trim()
      }
      return L
   }

   function r(V, L, M) {
      var $ = L.charCodeAt(0);
      switch (33 > $ && ($ = (L = L.trim()).charCodeAt(0)), $) {
         case 38:
            return L.replace(m, "$1" + V.trim());
         case 58:
            return V.trim() + L.replace(m, "$1" + V.trim());
         default:
            if (0 < 1 * M && 0 < L.indexOf("\f")) return L.replace(m, (V.charCodeAt(0) === 58 ? "" : "$1") + V.trim())
      }
      return V + L
   }

   function o(V, L, M, $) {
      var S = V + ";",
         b = 2 * L + 3 * M + 4 * $;
      if (b === 944) {
         V = S.indexOf(":", 9) + 1;
         var R = S.substring(V, S.length - 1).trim();
         return R = S.substring(0, V).trim() + R + ";", le === 1 || le === 2 && i(R, 1) ? "-webkit-" + R + R : R
      }
      if (le === 0 || le === 2 && !i(S, 1)) return S;
      switch (b) {
         case 1015:
            return S.charCodeAt(10) === 97 ? "-webkit-" + S + S : S;
         case 951:
            return S.charCodeAt(3) === 116 ? "-webkit-" + S + S : S;
         case 963:
            return S.charCodeAt(5) === 110 ? "-webkit-" + S + S : S;
         case 1009:
            if (S.charCodeAt(4) !== 100) break;
         case 969:
         case 942:
            return "-webkit-" + S + S;
         case 978:
            return "-webkit-" + S + "-moz-" + S + S;
         case 1019:
         case 983:
            return "-webkit-" + S + "-moz-" + S + "-ms-" + S + S;
         case 883:
            if (S.charCodeAt(8) === 45) return "-webkit-" + S + S;
            if (0 < S.indexOf("image-set(", 11)) return S.replace(se, "$1-webkit-$2") + S;
            break;
         case 932:
            if (S.charCodeAt(4) === 45) switch (S.charCodeAt(5)) {
               case 103:
                  return "-webkit-box-" + S.replace("-grow", "") + "-webkit-" + S + "-ms-" + S.replace("grow", "positive") + S;
               case 115:
                  return "-webkit-" + S + "-ms-" + S.replace("shrink", "negative") + S;
               case 98:
                  return "-webkit-" + S + "-ms-" + S.replace("basis", "preferred-size") + S
            }
            return "-webkit-" + S + "-ms-" + S + S;
         case 964:
            return "-webkit-" + S + "-ms-flex-" + S + S;
         case 1023:
            if (S.charCodeAt(8) !== 99) break;
            return R = S.substring(S.indexOf(":", 15)).replace("flex-", "").replace("space-between", "justify"), "-webkit-box-pack" + R + "-webkit-" + S + "-ms-flex-pack" + R + S;
         case 1005:
            return v.test(S) ? S.replace(g, ":-webkit-") + S.replace(g, ":-moz-") + S : S;
         case 1e3:
            switch (R = S.substring(13).trim(), L = R.indexOf("-") + 1, R.charCodeAt(0) + R.charCodeAt(L)) {
               case 226:
                  R = S.replace(x, "tb");
                  break;
               case 232:
                  R = S.replace(x, "tb-rl");
                  break;
               case 220:
                  R = S.replace(x, "lr");
                  break;
               default:
                  return S
            }
            return "-webkit-" + S + "-ms-" + R + S;
         case 1017:
            if (S.indexOf("sticky", 9) === -1) break;
         case 975:
            switch (L = (S = V).length - 10, R = (S.charCodeAt(L) === 33 ? S.substring(0, L) : S).substring(V.indexOf(":", 7) + 1).trim(), b = R.charCodeAt(0) + (R.charCodeAt(7) | 0)) {
               case 203:
                  if (111 > R.charCodeAt(8)) break;
               case 115:
                  S = S.replace(R, "-webkit-" + R) + ";" + S;
                  break;
               case 207:
               case 102:
                  S = S.replace(R, "-webkit-" + (102 < b ? "inline-" : "") + "box") + ";" + S.replace(R, "-webkit-" + R) + ";" + S.replace(R, "-ms-" + R + "box") + ";" + S
            }
            return S + ";";
         case 938:
            if (S.charCodeAt(5) === 45) switch (S.charCodeAt(6)) {
               case 105:
                  return R = S.replace("-items", ""), "-webkit-" + S + "-webkit-box-" + R + "-ms-flex-" + R + S;
               case 115:
                  return "-webkit-" + S + "-ms-flex-item-" + S.replace(A, "") + S;
               default:
                  return "-webkit-" + S + "-ms-flex-line-pack" + S.replace("align-content", "").replace(A, "") + S
            }
            break;
         case 973:
         case 989:
            if (S.charCodeAt(3) !== 45 || S.charCodeAt(4) === 122) break;
         case 931:
         case 953:
            if (D.test(V) === !0) return (R = V.substring(V.indexOf(":") + 1)).charCodeAt(0) === 115 ? o(V.replace("stretch", "fill-available"), L, M, $).replace(":fill-available", ":stretch") : S.replace(R, "-webkit-" + R) + S.replace(R, "-moz-" + R.replace("fill-", "")) + S;
            break;
         case 962:
            if (S = "-webkit-" + S + (S.charCodeAt(5) === 102 ? "-ms-" + S : "") + S, M + $ === 211 && S.charCodeAt(13) === 105 && 0 < S.indexOf("transform", 10)) return S.substring(0, S.indexOf(";", 27) + 1).replace(w, "$1-webkit-$2") + S
      }
      return S
   }

   function i(V, L) {
      var M = V.indexOf(L === 1 ? ":" : "{"),
         $ = V.substring(0, L !== 3 ? M : 10);
      return M = V.substring(M + 1, V.length - 1), z(L !== 2 ? $ : $.replace(I, "$1"), M, L)
   }

   function s(V, L) {
      var M = o(L, L.charCodeAt(0), L.charCodeAt(1), L.charCodeAt(2));
      return M !== L + ";" ? M.replace(T, " or ($1)").substring(4) : "(" + L + ")"
   }

   function l(V, L, M, $, S, b, R, de, Q, K) {
      for (var U = 0, Te = L, He; U < _; ++U) switch (He = me[U].call(c, V, Te, M, $, S, b, R, de, Q, K)) {
         case void 0:
         case !1:
         case !0:
         case null:
            break;
         default:
            Te = He
      }
      if (Te !== L) return Te
   }

   function a(V) {
      switch (V) {
         case void 0:
         case null:
            _ = me.length = 0;
            break;
         default:
            if (typeof V == "function") me[_++] = V;
            else if (typeof V == "object")
               for (var L = 0, M = V.length; L < M; ++L) a(V[L]);
            else F = !!V | 0
      }
      return a
   }

   function u(V) {
      return V = V.prefix, V !== void 0 && (z = null, V ? typeof V != "function" ? le = 1 : (le = 2, z = V) : le = 0), u
   }

   function c(V, L) {
      var M = V;
      if (33 > M.charCodeAt(0) && (M = M.trim()), q = M, M = [q], 0 < _) {
         var $ = l(-1, L, M, M, fe, J, 0, 0, 0, 0);
         $ !== void 0 && typeof $ == "string" && (L = $)
      }
      var S = t(ne, M, L, 0, 0);
      return 0 < _ && ($ = l(-2, S, M, M, fe, J, S.length, 0, 0, 0), $ !== void 0 && (S = $)), q = "", we = 0, J = fe = 1, S
   }
   var f = /^\0+/g,
      d = /[\0\r\f]/g,
      g = /: */g,
      v = /zoo|gra/,
      w = /([,: ])(transform)/g,
      k = /,\r+?/g,
      m = /([\t\r\n ])*\f?&/g,
      p = /@(k\w+)\s*(\S*)\s*/,
      h = /::(place)/g,
      y = /:(read-only)/g,
      x = /[svh]\w+-[tblr]{2}/,
      E = /\(\s*(.*)\s*\)/g,
      T = /([\s\S]*?);/g,
      A = /-self|flex-/g,
      I = /[^]*?(:[rp][el]a[\w-]+)[^]*/,
      D = /stretch|:\s*\w+\-(?:conte|avail)/,
      se = /([^-])(image-set\()/,
      J = 1,
      fe = 1,
      we = 0,
      le = 1,
      ne = [],
      me = [],
      _ = 0,
      z = null,
      F = 0,
      q = "";
   return c.use = a, c.set = u, e !== void 0 && u(e), c
}
var _y = {
   animationIterationCount: 1,
   borderImageOutset: 1,
   borderImageSlice: 1,
   borderImageWidth: 1,
   boxFlex: 1,
   boxFlexGroup: 1,
   boxOrdinalGroup: 1,
   columnCount: 1,
   columns: 1,
   flex: 1,
   flexGrow: 1,
   flexPositive: 1,
   flexShrink: 1,
   flexNegative: 1,
   flexOrder: 1,
   gridRow: 1,
   gridRowEnd: 1,
   gridRowSpan: 1,
   gridRowStart: 1,
   gridColumn: 1,
   gridColumnEnd: 1,
   gridColumnSpan: 1,
   gridColumnStart: 1,
   msGridRow: 1,
   msGridRowSpan: 1,
   msGridColumn: 1,
   msGridColumnSpan: 1,
   fontWeight: 1,
   lineHeight: 1,
   opacity: 1,
   order: 1,
   orphans: 1,
   tabSize: 1,
   widows: 1,
   zIndex: 1,
   zoom: 1,
   WebkitLineClamp: 1,
   fillOpacity: 1,
   floodOpacity: 1,
   stopOpacity: 1,
   strokeDasharray: 1,
   strokeDashoffset: 1,
   strokeMiterlimit: 1,
   strokeOpacity: 1,
   strokeWidth: 1
};

function Ay(e) {
   var t = Object.create(null);
   return function (n) {
      return t[n] === void 0 && (t[n] = e(n)), t[n]
   }
}
var Ry = /^((children|dangerouslySetInnerHTML|key|ref|autoFocus|defaultValue|defaultChecked|innerHTML|suppressContentEditableWarning|suppressHydrationWarning|valueLink|abbr|accept|acceptCharset|accessKey|action|allow|allowUserMedia|allowPaymentRequest|allowFullScreen|allowTransparency|alt|async|autoComplete|autoPlay|capture|cellPadding|cellSpacing|challenge|charSet|checked|cite|classID|className|cols|colSpan|content|contentEditable|contextMenu|controls|controlsList|coords|crossOrigin|data|dateTime|decoding|default|defer|dir|disabled|disablePictureInPicture|download|draggable|encType|enterKeyHint|form|formAction|formEncType|formMethod|formNoValidate|formTarget|frameBorder|headers|height|hidden|high|href|hrefLang|htmlFor|httpEquiv|id|inputMode|integrity|is|keyParams|keyType|kind|label|lang|list|loading|loop|low|marginHeight|marginWidth|max|maxLength|media|mediaGroup|method|min|minLength|multiple|muted|name|nonce|noValidate|open|optimum|pattern|placeholder|playsInline|poster|preload|profile|radioGroup|readOnly|referrerPolicy|rel|required|reversed|role|rows|rowSpan|sandbox|scope|scoped|scrolling|seamless|selected|shape|size|sizes|slot|span|spellCheck|src|srcDoc|srcLang|srcSet|start|step|style|summary|tabIndex|target|title|translate|type|useMap|value|width|wmode|wrap|about|datatype|inlist|prefix|property|resource|typeof|vocab|autoCapitalize|autoCorrect|autoSave|color|incremental|fallback|inert|itemProp|itemScope|itemType|itemID|itemRef|on|option|results|security|unselectable|accentHeight|accumulate|additive|alignmentBaseline|allowReorder|alphabetic|amplitude|arabicForm|ascent|attributeName|attributeType|autoReverse|azimuth|baseFrequency|baselineShift|baseProfile|bbox|begin|bias|by|calcMode|capHeight|clip|clipPathUnits|clipPath|clipRule|colorInterpolation|colorInterpolationFilters|colorProfile|colorRendering|contentScriptType|contentStyleType|cursor|cx|cy|d|decelerate|descent|diffuseConstant|direction|display|divisor|dominantBaseline|dur|dx|dy|edgeMode|elevation|enableBackground|end|exponent|externalResourcesRequired|fill|fillOpacity|fillRule|filter|filterRes|filterUnits|floodColor|floodOpacity|focusable|fontFamily|fontSize|fontSizeAdjust|fontStretch|fontStyle|fontVariant|fontWeight|format|from|fr|fx|fy|g1|g2|glyphName|glyphOrientationHorizontal|glyphOrientationVertical|glyphRef|gradientTransform|gradientUnits|hanging|horizAdvX|horizOriginX|ideographic|imageRendering|in|in2|intercept|k|k1|k2|k3|k4|kernelMatrix|kernelUnitLength|kerning|keyPoints|keySplines|keyTimes|lengthAdjust|letterSpacing|lightingColor|limitingConeAngle|local|markerEnd|markerMid|markerStart|markerHeight|markerUnits|markerWidth|mask|maskContentUnits|maskUnits|mathematical|mode|numOctaves|offset|opacity|operator|order|orient|orientation|origin|overflow|overlinePosition|overlineThickness|panose1|paintOrder|pathLength|patternContentUnits|patternTransform|patternUnits|pointerEvents|points|pointsAtX|pointsAtY|pointsAtZ|preserveAlpha|preserveAspectRatio|primitiveUnits|r|radius|refX|refY|renderingIntent|repeatCount|repeatDur|requiredExtensions|requiredFeatures|restart|result|rotate|rx|ry|scale|seed|shapeRendering|slope|spacing|specularConstant|specularExponent|speed|spreadMethod|startOffset|stdDeviation|stemh|stemv|stitchTiles|stopColor|stopOpacity|strikethroughPosition|strikethroughThickness|string|stroke|strokeDasharray|strokeDashoffset|strokeLinecap|strokeLinejoin|strokeMiterlimit|strokeOpacity|strokeWidth|surfaceScale|systemLanguage|tableValues|targetX|targetY|textAnchor|textDecoration|textRendering|textLength|to|transform|u1|u2|underlinePosition|underlineThickness|unicode|unicodeBidi|unicodeRange|unitsPerEm|vAlphabetic|vHanging|vIdeographic|vMathematical|values|vectorEffect|version|vertAdvY|vertOriginX|vertOriginY|viewBox|viewTarget|visibility|widths|wordSpacing|writingMode|x|xHeight|x1|x2|xChannelSelector|xlinkActuate|xlinkArcrole|xlinkHref|xlinkRole|xlinkShow|xlinkTitle|xlinkType|xmlBase|xmlns|xmlnsXlink|xmlLang|xmlSpace|y|y1|y2|yChannelSelector|z|zoomAndPan|for|class|autofocus)|(([Dd][Aa][Tt][Aa]|[Aa][Rr][Ii][Aa]|x)-.*))$/,
   Mf = Ay(function (e) {
      return Ry.test(e) || e.charCodeAt(0) === 111 && e.charCodeAt(1) === 110 && e.charCodeAt(2) < 91
   }),
   Gu = Ts.exports,
   Vy = {
      childContextTypes: !0,
      contextType: !0,
      contextTypes: !0,
      defaultProps: !0,
      displayName: !0,
      getDefaultProps: !0,
      getDerivedStateFromError: !0,
      getDerivedStateFromProps: !0,
      mixins: !0,
      propTypes: !0,
      type: !0
   },
   Ly = {
      name: !0,
      length: !0,
      prototype: !0,
      caller: !0,
      callee: !0,
      arguments: !0,
      arity: !0
   },
   My = {
      $$typeof: !0,
      render: !0,
      defaultProps: !0,
      displayName: !0,
      propTypes: !0
   },
   fm = {
      $$typeof: !0,
      compare: !0,
      defaultProps: !0,
      displayName: !0,
      propTypes: !0,
      type: !0
   },
   Qu = {};
Qu[Gu.ForwardRef] = My;
Qu[Gu.Memo] = fm;

function Of(e) {
   return Gu.isMemo(e) ? fm : Qu[e.$$typeof] || Vy
}
var Oy = Object.defineProperty,
   Dy = Object.getOwnPropertyNames,
   Df = Object.getOwnPropertySymbols,
   Ny = Object.getOwnPropertyDescriptor,
   Iy = Object.getPrototypeOf,
   Nf = Object.prototype;

function dm(e, t, n) {
   if (typeof t != "string") {
      if (Nf) {
         var r = Iy(t);
         r && r !== Nf && dm(e, r, n)
      }
      var o = Dy(t);
      Df && (o = o.concat(Df(t)));
      for (var i = Of(e), s = Of(t), l = 0; l < o.length; ++l) {
         var a = o[l];
         if (!Ly[a] && !(n && n[a]) && !(s && s[a]) && !(i && i[a])) {
            var u = Ny(t, a);
            try {
               Oy(e, a, u)
            } catch {}
         }
      }
   }
   return e
}
var zy = dm;

function Ot() {
   return (Ot = Object.assign || function (e) {
      for (var t = 1; t < arguments.length; t++) {
         var n = arguments[t];
         for (var r in n) Object.prototype.hasOwnProperty.call(n, r) && (e[r] = n[r])
      }
      return e
   }).apply(this, arguments)
}
var If = function (e, t) {
      for (var n = [e[0]], r = 0, o = t.length; r < o; r += 1) n.push(t[r], e[r + 1]);
      return n
   },
   _a = function (e) {
      return e !== null && typeof e == "object" && (e.toString ? e.toString() : Object.prototype.toString.call(e)) === "[object Object]" && !Ts.exports.typeOf(e)
   },
   Yi = Object.freeze([]),
   an = Object.freeze({});

function yo(e) {
   return typeof e == "function"
}

function zf(e) {
   return e.displayName || e.name || "Component"
}

function Yu(e) {
   return e && typeof e.styledComponentId == "string"
}
var hr = typeof process != "undefined" && ({}.REACT_APP_SC_ATTR || {}.SC_ATTR) || "data-styled",
   Ku = typeof window != "undefined" && "HTMLElement" in window,
   Fy = Boolean(typeof SC_DISABLE_SPEEDY == "boolean" ? SC_DISABLE_SPEEDY : typeof process != "undefined" && {}.REACT_APP_SC_DISABLE_SPEEDY !== void 0 && {}.REACT_APP_SC_DISABLE_SPEEDY !== "" ? {}.REACT_APP_SC_DISABLE_SPEEDY !== "false" && {}.REACT_APP_SC_DISABLE_SPEEDY : typeof process != "undefined" && {}.SC_DISABLE_SPEEDY !== void 0 && {}.SC_DISABLE_SPEEDY !== "" ? {}.SC_DISABLE_SPEEDY !== "false" && {}.SC_DISABLE_SPEEDY : !1);

function Lo(e) {
   for (var t = arguments.length, n = new Array(t > 1 ? t - 1 : 0), r = 1; r < t; r++) n[r - 1] = arguments[r];
   throw new Error("An error occurred. See https://git.io/JUIaE#" + e + " for more information." + (n.length > 0 ? " Args: " + n.join(", ") : ""))
}
var $y = function () {
      function e(n) {
         this.groupSizes = new Uint32Array(512), this.length = 512, this.tag = n
      }
      var t = e.prototype;
      return t.indexOfGroup = function (n) {
         for (var r = 0, o = 0; o < n; o++) r += this.groupSizes[o];
         return r
      }, t.insertRules = function (n, r) {
         if (n >= this.groupSizes.length) {
            for (var o = this.groupSizes, i = o.length, s = i; n >= s;)(s <<= 1) < 0 && Lo(16, "" + n);
            this.groupSizes = new Uint32Array(s), this.groupSizes.set(o), this.length = s;
            for (var l = i; l < s; l++) this.groupSizes[l] = 0
         }
         for (var a = this.indexOfGroup(n + 1), u = 0, c = r.length; u < c; u++) this.tag.insertRule(a, r[u]) && (this.groupSizes[n]++, a++)
      }, t.clearGroup = function (n) {
         if (n < this.length) {
            var r = this.groupSizes[n],
               o = this.indexOfGroup(n),
               i = o + r;
            this.groupSizes[n] = 0;
            for (var s = o; s < i; s++) this.tag.deleteRule(o)
         }
      }, t.getGroup = function (n) {
         var r = "";
         if (n >= this.length || this.groupSizes[n] === 0) return r;
         for (var o = this.groupSizes[n], i = this.indexOfGroup(n), s = i + o, l = i; l < s; l++) r += this.tag.getRule(l) + `/*!sc*/
`;
         return r
      }, e
   }(),
   Si = new Map,
   Ki = new Map,
   Gr = 1,
   ti = function (e) {
      if (Si.has(e)) return Si.get(e);
      for (; Ki.has(Gr);) Gr++;
      var t = Gr++;
      return Si.set(e, t), Ki.set(t, e), t
   },
   jy = function (e) {
      return Ki.get(e)
   },
   Uy = function (e, t) {
      t >= Gr && (Gr = t + 1), Si.set(e, t), Ki.set(t, e)
   },
   By = "style[" + hr + '][data-styled-version="5.3.6"]',
   Hy = new RegExp("^" + hr + '\\.g(\\d+)\\[id="([\\w\\d-]+)"\\].*?"([^"]*)'),
   by = function (e, t, n) {
      for (var r, o = n.split(","), i = 0, s = o.length; i < s; i++)(r = o[i]) && e.registerName(t, r)
   },
   Wy = function (e, t) {
      for (var n = (t.textContent || "").split(`/*!sc*/
`), r = [], o = 0, i = n.length; o < i; o++) {
         var s = n[o].trim();
         if (s) {
            var l = s.match(Hy);
            if (l) {
               var a = 0 | parseInt(l[1], 10),
                  u = l[2];
               a !== 0 && (Uy(u, a), by(e, u, l[3]), e.getTag().insertRules(a, r)), r.length = 0
            } else r.push(s)
         }
      }
   },
   Gy = function () {
      return typeof __webpack_nonce__ != "undefined" ? __webpack_nonce__ : null
   },
   pm = function (e) {
      var t = document.head,
         n = e || t,
         r = document.createElement("style"),
         o = function (l) {
            for (var a = l.childNodes, u = a.length; u >= 0; u--) {
               var c = a[u];
               if (c && c.nodeType === 1 && c.hasAttribute(hr)) return c
            }
         }(n),
         i = o !== void 0 ? o.nextSibling : null;
      r.setAttribute(hr, "active"), r.setAttribute("data-styled-version", "5.3.6");
      var s = Gy();
      return s && r.setAttribute("nonce", s), n.insertBefore(r, i), r
   },
   Qy = function () {
      function e(n) {
         var r = this.element = pm(n);
         r.appendChild(document.createTextNode("")), this.sheet = function (o) {
            if (o.sheet) return o.sheet;
            for (var i = document.styleSheets, s = 0, l = i.length; s < l; s++) {
               var a = i[s];
               if (a.ownerNode === o) return a
            }
            Lo(17)
         }(r), this.length = 0
      }
      var t = e.prototype;
      return t.insertRule = function (n, r) {
         try {
            return this.sheet.insertRule(r, n), this.length++, !0
         } catch {
            return !1
         }
      }, t.deleteRule = function (n) {
         this.sheet.deleteRule(n), this.length--
      }, t.getRule = function (n) {
         var r = this.sheet.cssRules[n];
         return r !== void 0 && typeof r.cssText == "string" ? r.cssText : ""
      }, e
   }(),
   Yy = function () {
      function e(n) {
         var r = this.element = pm(n);
         this.nodes = r.childNodes, this.length = 0
      }
      var t = e.prototype;
      return t.insertRule = function (n, r) {
         if (n <= this.length && n >= 0) {
            var o = document.createTextNode(r),
               i = this.nodes[n];
            return this.element.insertBefore(o, i || null), this.length++, !0
         }
         return !1
      }, t.deleteRule = function (n) {
         this.element.removeChild(this.nodes[n]), this.length--
      }, t.getRule = function (n) {
         return n < this.length ? this.nodes[n].textContent : ""
      }, e
   }(),
   Ky = function () {
      function e(n) {
         this.rules = [], this.length = 0
      }
      var t = e.prototype;
      return t.insertRule = function (n, r) {
         return n <= this.length && (this.rules.splice(n, 0, r), this.length++, !0)
      }, t.deleteRule = function (n) {
         this.rules.splice(n, 1), this.length--
      }, t.getRule = function (n) {
         return n < this.length ? this.rules[n] : ""
      }, e
   }(),
   Ff = Ku,
   Xy = {
      isServer: !Ku,
      useCSSOMInjection: !Fy
   },
   hm = function () {
      function e(n, r, o) {
         n === void 0 && (n = an), r === void 0 && (r = {}), this.options = Ot({}, Xy, {}, n), this.gs = r, this.names = new Map(o), this.server = !!n.isServer, !this.server && Ku && Ff && (Ff = !1, function (i) {
            for (var s = document.querySelectorAll(By), l = 0, a = s.length; l < a; l++) {
               var u = s[l];
               u && u.getAttribute(hr) !== "active" && (Wy(i, u), u.parentNode && u.parentNode.removeChild(u))
            }
         }(this))
      }
      e.registerId = function (n) {
         return ti(n)
      };
      var t = e.prototype;
      return t.reconstructWithOptions = function (n, r) {
         return r === void 0 && (r = !0), new e(Ot({}, this.options, {}, n), this.gs, r && this.names || void 0)
      }, t.allocateGSInstance = function (n) {
         return this.gs[n] = (this.gs[n] || 0) + 1
      }, t.getTag = function () {
         return this.tag || (this.tag = (o = (r = this.options).isServer, i = r.useCSSOMInjection, s = r.target, n = o ? new Ky(s) : i ? new Qy(s) : new Yy(s), new $y(n)));
         var n, r, o, i, s
      }, t.hasNameForId = function (n, r) {
         return this.names.has(n) && this.names.get(n).has(r)
      }, t.registerName = function (n, r) {
         if (ti(n), this.names.has(n)) this.names.get(n).add(r);
         else {
            var o = new Set;
            o.add(r), this.names.set(n, o)
         }
      }, t.insertRules = function (n, r, o) {
         this.registerName(n, r), this.getTag().insertRules(ti(n), o)
      }, t.clearNames = function (n) {
         this.names.has(n) && this.names.get(n).clear()
      }, t.clearRules = function (n) {
         this.getTag().clearGroup(ti(n)), this.clearNames(n)
      }, t.clearTag = function () {
         this.tag = void 0
      }, t.toString = function () {
         return function (n) {
            for (var r = n.getTag(), o = r.length, i = "", s = 0; s < o; s++) {
               var l = jy(s);
               if (l !== void 0) {
                  var a = n.names.get(l),
                     u = r.getGroup(s);
                  if (a && u && a.size) {
                     var c = hr + ".g" + s + '[id="' + l + '"]',
                        f = "";
                     a !== void 0 && a.forEach(function (d) {
                        d.length > 0 && (f += d + ",")
                     }), i += "" + u + c + '{content:"' + f + `"}/*!sc*/
`
                  }
               }
            }
            return i
         }(this)
      }, e
   }(),
   Zy = /(a)(d)/gi,
   $f = function (e) {
      return String.fromCharCode(e + (e > 25 ? 39 : 97))
   };

function Aa(e) {
   var t, n = "";
   for (t = Math.abs(e); t > 52; t = t / 52 | 0) n = $f(t % 52) + n;
   return ($f(t % 52) + n).replace(Zy, "$1-$2")
}
var Xn = function (e, t) {
      for (var n = t.length; n;) e = 33 * e ^ t.charCodeAt(--n);
      return e
   },
   mm = function (e) {
      return Xn(5381, e)
   };

function Jy(e) {
   for (var t = 0; t < e.length; t += 1) {
      var n = e[t];
      if (yo(n) && !Yu(n)) return !1
   }
   return !0
}
var qy = mm("5.3.6"),
   e1 = function () {
      function e(t, n, r) {
         this.rules = t, this.staticRulesId = "", this.isStatic = (r === void 0 || r.isStatic) && Jy(t), this.componentId = n, this.baseHash = Xn(qy, n), this.baseStyle = r, hm.registerId(n)
      }
      return e.prototype.generateAndInjectStyles = function (t, n, r) {
         var o = this.componentId,
            i = [];
         if (this.baseStyle && i.push(this.baseStyle.generateAndInjectStyles(t, n, r)), this.isStatic && !r.hash)
            if (this.staticRulesId && n.hasNameForId(o, this.staticRulesId)) i.push(this.staticRulesId);
            else {
               var s = mr(this.rules, t, n, r).join(""),
                  l = Aa(Xn(this.baseHash, s) >>> 0);
               if (!n.hasNameForId(o, l)) {
                  var a = r(s, "." + l, void 0, o);
                  n.insertRules(o, l, a)
               }
               i.push(l), this.staticRulesId = l
            }
         else {
            for (var u = this.rules.length, c = Xn(this.baseHash, r.hash), f = "", d = 0; d < u; d++) {
               var g = this.rules[d];
               if (typeof g == "string") f += g;
               else if (g) {
                  var v = mr(g, t, n, r),
                     w = Array.isArray(v) ? v.join("") : v;
                  c = Xn(c, w + d), f += w
               }
            }
            if (f) {
               var k = Aa(c >>> 0);
               if (!n.hasNameForId(o, k)) {
                  var m = r(f, "." + k, void 0, o);
                  n.insertRules(o, k, m)
               }
               i.push(k)
            }
         }
         return i.join(" ")
      }, e
   }(),
   t1 = /^\s*\/\/.*$/gm,
   n1 = [":", "[", ".", "#"];

function r1(e) {
   var t, n, r, o, i = e === void 0 ? an : e,
      s = i.options,
      l = s === void 0 ? an : s,
      a = i.plugins,
      u = a === void 0 ? Yi : a,
      c = new Ty(l),
      f = [],
      d = function (w) {
         function k(m) {
            if (m) try {
               w(m + "}")
            } catch {}
         }
         return function (m, p, h, y, x, E, T, A, I, D) {
            switch (m) {
               case 1:
                  if (I === 0 && p.charCodeAt(0) === 64) return w(p + ";"), "";
                  break;
               case 2:
                  if (A === 0) return p + "/*|*/";
                  break;
               case 3:
                  switch (A) {
                     case 102:
                     case 112:
                        return w(h[0] + p), "";
                     default:
                        return p + (D === 0 ? "/*|*/" : "")
                  }
               case -2:
                  p.split("/*|*/}").forEach(k)
            }
         }
      }(function (w) {
         f.push(w)
      }),
      g = function (w, k, m) {
         return k === 0 && n1.indexOf(m[n.length]) !== -1 || m.match(o) ? w : "." + t
      };

   function v(w, k, m, p) {
      p === void 0 && (p = "&");
      var h = w.replace(t1, ""),
         y = k && m ? m + " " + k + " { " + h + " }" : h;
      return t = p, n = k, r = new RegExp("\\" + n + "\\b", "g"), o = new RegExp("(\\" + n + "\\b){2,}"), c(m || !k ? "" : k, y)
   }
   return c.use([].concat(u, [function (w, k, m) {
      w === 2 && m.length && m[0].lastIndexOf(n) > 0 && (m[0] = m[0].replace(r, g))
   }, d, function (w) {
      if (w === -2) {
         var k = f;
         return f = [], k
      }
   }])), v.hash = u.length ? u.reduce(function (w, k) {
      return k.name || Lo(15), Xn(w, k.name)
   }, 5381).toString() : "", v
}
var gm = Ln.createContext();
gm.Consumer;
var vm = Ln.createContext(),
   o1 = (vm.Consumer, new hm),
   Ra = r1();

function i1() {
   return C.exports.useContext(gm) || o1
}

function s1() {
   return C.exports.useContext(vm) || Ra
}
var l1 = function () {
      function e(t, n) {
         var r = this;
         this.inject = function (o, i) {
            i === void 0 && (i = Ra);
            var s = r.name + i.hash;
            o.hasNameForId(r.id, s) || o.insertRules(r.id, s, i(r.rules, s, "@keyframes"))
         }, this.toString = function () {
            return Lo(12, String(r.name))
         }, this.name = t, this.id = "sc-keyframes-" + t, this.rules = n
      }
      return e.prototype.getName = function (t) {
         return t === void 0 && (t = Ra), this.name + t.hash
      }, e
   }(),
   a1 = /([A-Z])/,
   u1 = /([A-Z])/g,
   c1 = /^ms-/,
   f1 = function (e) {
      return "-" + e.toLowerCase()
   };

function jf(e) {
   return a1.test(e) ? e.replace(u1, f1).replace(c1, "-ms-") : e
}
var Uf = function (e) {
   return e == null || e === !1 || e === ""
};

function mr(e, t, n, r) {
   if (Array.isArray(e)) {
      for (var o, i = [], s = 0, l = e.length; s < l; s += 1)(o = mr(e[s], t, n, r)) !== "" && (Array.isArray(o) ? i.push.apply(i, o) : i.push(o));
      return i
   }
   if (Uf(e)) return "";
   if (Yu(e)) return "." + e.styledComponentId;
   if (yo(e)) {
      if (typeof (u = e) != "function" || u.prototype && u.prototype.isReactComponent || !t) return e;
      var a = e(t);
      return mr(a, t, n, r)
   }
   var u;
   return e instanceof l1 ? n ? (e.inject(n, r), e.getName(r)) : e : _a(e) ? function c(f, d) {
      var g, v, w = [];
      for (var k in f) f.hasOwnProperty(k) && !Uf(f[k]) && (Array.isArray(f[k]) && f[k].isCss || yo(f[k]) ? w.push(jf(k) + ":", f[k], ";") : _a(f[k]) ? w.push.apply(w, c(f[k], k)) : w.push(jf(k) + ": " + (g = k, (v = f[k]) == null || typeof v == "boolean" || v === "" ? "" : typeof v != "number" || v === 0 || g in _y ? String(v).trim() : v + "px") + ";"));
      return d ? [d + " {"].concat(w, ["}"]) : w
   }(e) : e.toString()
}
var Bf = function (e) {
   return Array.isArray(e) && (e.isCss = !0), e
};

function wo(e) {
   for (var t = arguments.length, n = new Array(t > 1 ? t - 1 : 0), r = 1; r < t; r++) n[r - 1] = arguments[r];
   return yo(e) || _a(e) ? Bf(mr(If(Yi, [e].concat(n)))) : n.length === 0 && e.length === 1 && typeof e[0] == "string" ? e : Bf(mr(If(e, n)))
}
var d1 = function (e, t, n) {
      return n === void 0 && (n = an), e.theme !== n.theme && e.theme || t || n.theme
   },
   p1 = /[!"#$%&'()*+,./:;<=>?@[\\\]^`{|}~-]+/g,
   h1 = /(^-|-$)/g;

function Sl(e) {
   return e.replace(p1, "-").replace(h1, "")
}
var m1 = function (e) {
   return Aa(mm(e) >>> 0)
};

function ni(e) {
   return typeof e == "string" && !0
}
var Va = function (e) {
      return typeof e == "function" || typeof e == "object" && e !== null && !Array.isArray(e)
   },
   g1 = function (e) {
      return e !== "__proto__" && e !== "constructor" && e !== "prototype"
   };

function v1(e, t, n) {
   var r = e[n];
   Va(t) && Va(r) ? ym(r, t) : e[n] = t
}

function ym(e) {
   for (var t = arguments.length, n = new Array(t > 1 ? t - 1 : 0), r = 1; r < t; r++) n[r - 1] = arguments[r];
   for (var o = 0, i = n; o < i.length; o++) {
      var s = i[o];
      if (Va(s))
         for (var l in s) g1(l) && v1(e, s[l], l)
   }
   return e
}
var wm = Ln.createContext();
wm.Consumer;
var xl = {};

function Sm(e, t, n) {
   var r = Yu(e),
      o = !ni(e),
      i = t.attrs,
      s = i === void 0 ? Yi : i,
      l = t.componentId,
      a = l === void 0 ? function (p, h) {
         var y = typeof p != "string" ? "sc" : Sl(p);
         xl[y] = (xl[y] || 0) + 1;
         var x = y + "-" + m1("5.3.6" + y + xl[y]);
         return h ? h + "-" + x : x
      }(t.displayName, t.parentComponentId) : l,
      u = t.displayName,
      c = u === void 0 ? function (p) {
         return ni(p) ? "styled." + p : "Styled(" + zf(p) + ")"
      }(e) : u,
      f = t.displayName && t.componentId ? Sl(t.displayName) + "-" + t.componentId : t.componentId || a,
      d = r && e.attrs ? Array.prototype.concat(e.attrs, s).filter(Boolean) : s,
      g = t.shouldForwardProp;
   r && e.shouldForwardProp && (g = t.shouldForwardProp ? function (p, h, y) {
      return e.shouldForwardProp(p, h, y) && t.shouldForwardProp(p, h, y)
   } : e.shouldForwardProp);
   var v, w = new e1(n, f, r ? e.componentStyle : void 0),
      k = w.isStatic && s.length === 0,
      m = function (p, h) {
         return function (y, x, E, T) {
            var A = y.attrs,
               I = y.componentStyle,
               D = y.defaultProps,
               se = y.foldedComponentIds,
               J = y.shouldForwardProp,
               fe = y.styledComponentId,
               we = y.target,
               le = function ($, S, b) {
                  $ === void 0 && ($ = an);
                  var R = Ot({}, S, {
                        theme: $
                     }),
                     de = {};
                  return b.forEach(function (Q) {
                     var K, U, Te, He = Q;
                     for (K in yo(He) && (He = He(R)), He) R[K] = de[K] = K === "className" ? (U = de[K], Te = He[K], U && Te ? U + " " + Te : U || Te) : He[K]
                  }), [R, de]
               }(d1(x, C.exports.useContext(wm), D) || an, x, A),
               ne = le[0],
               me = le[1],
               _ = function ($, S, b, R) {
                  var de = i1(),
                     Q = s1(),
                     K = S ? $.generateAndInjectStyles(an, de, Q) : $.generateAndInjectStyles(b, de, Q);
                  return K
               }(I, T, ne),
               z = E,
               F = me.$as || x.$as || me.as || x.as || we,
               q = ni(F),
               V = me !== x ? Ot({}, x, {}, me) : x,
               L = {};
            for (var M in V) M[0] !== "$" && M !== "as" && (M === "forwardedAs" ? L.as = V[M] : (J ? J(M, Mf, F) : !q || Mf(M)) && (L[M] = V[M]));
            return x.style && me.style !== x.style && (L.style = Ot({}, x.style, {}, me.style)), L.className = Array.prototype.concat(se, fe, _ !== fe ? _ : null, x.className, me.className).filter(Boolean).join(" "), L.ref = z, C.exports.createElement(F, L)
         }(v, p, h, k)
      };
   return m.displayName = c, (v = Ln.forwardRef(m)).attrs = d, v.componentStyle = w, v.displayName = c, v.shouldForwardProp = g, v.foldedComponentIds = r ? Array.prototype.concat(e.foldedComponentIds, e.styledComponentId) : Yi, v.styledComponentId = f, v.target = r ? e.target : e, v.withComponent = function (p) {
      var h = t.componentId,
         y = function (E, T) {
            if (E == null) return {};
            var A, I, D = {},
               se = Object.keys(E);
            for (I = 0; I < se.length; I++) A = se[I], T.indexOf(A) >= 0 || (D[A] = E[A]);
            return D
         }(t, ["componentId"]),
         x = h && h + "-" + (ni(p) ? p : Sl(zf(p)));
      return Sm(p, Ot({}, y, {
         attrs: d,
         componentId: x
      }), n)
   }, Object.defineProperty(v, "defaultProps", {
      get: function () {
         return this._foldedDefaultProps
      },
      set: function (p) {
         this._foldedDefaultProps = r ? ym({}, e.defaultProps, p) : p
      }
   }), v.toString = function () {
      return "." + v.styledComponentId
   }, o && zy(v, e, {
      attrs: !0,
      componentStyle: !0,
      displayName: !0,
      foldedComponentIds: !0,
      shouldForwardProp: !0,
      styledComponentId: !0,
      target: !0,
      withComponent: !0
   }), v
}
var La = function (e) {
   return function t(n, r, o) {
      if (o === void 0 && (o = an), !Ts.exports.isValidElementType(r)) return Lo(1, String(r));
      var i = function () {
         return n(r, o, wo.apply(void 0, arguments))
      };
      return i.withConfig = function (s) {
         return t(n, r, Ot({}, o, {}, s))
      }, i.attrs = function (s) {
         return t(n, r, Ot({}, o, {
            attrs: Array.prototype.concat(o.attrs, s).filter(Boolean)
         }))
      }, i
   }(Sm, e)
};
["a", "abbr", "address", "area", "article", "aside", "audio", "b", "base", "bdi", "bdo", "big", "blockquote", "body", "br", "button", "canvas", "caption", "cite", "code", "col", "colgroup", "data", "datalist", "dd", "del", "details", "dfn", "dialog", "div", "dl", "dt", "em", "embed", "fieldset", "figcaption", "figure", "footer", "form", "h1", "h2", "h3", "h4", "h5", "h6", "head", "header", "hgroup", "hr", "html", "i", "iframe", "img", "input", "ins", "kbd", "keygen", "label", "legend", "li", "link", "main", "map", "mark", "marquee", "menu", "menuitem", "meta", "meter", "nav", "noscript", "object", "ol", "optgroup", "option", "output", "p", "param", "picture", "pre", "progress", "q", "rp", "rt", "ruby", "s", "samp", "script", "section", "select", "small", "source", "span", "strong", "style", "sub", "summary", "sup", "table", "tbody", "td", "textarea", "tfoot", "th", "thead", "time", "title", "tr", "track", "u", "ul", "var", "video", "wbr", "circle", "clipPath", "defs", "ellipse", "foreignObject", "g", "image", "line", "linearGradient", "marker", "mask", "path", "pattern", "polygon", "polyline", "radialGradient", "rect", "stop", "svg", "text", "textPath", "tspan"].forEach(function (e) {
   La[e] = La(e)
});
var Be = La,
   y1 = "./assets/background.a10a9cca.webp";
const w1 = Be.div`
    width: 100vw;
    height: 100vh;
    display: flex;
    justify-content: center;
    align-items: center;
`,
   S1 = Be.div`
    position: absolute;
    width: 100vw;
    height: 100vh;
    background-image: url(${y1});
    background-size: 100% 100%;
    opacity: .6;
    z-index: -1;
`,
   x1 = Be.div`
    position: absolute;
    width: 39.167vw;
    height: 41.25vw;
    background: rgba(0, 0, 0, 0.74);
    border-radius: 1.094vw;   
    z-index: 2;
`,
   k1 = Be.section`
    width: 100%;
    height: 32.917vw;
    border-radius: 0vw 0vw 1.094vw 1.094vw;
    background: rgba(0, 0, 0, 0.1);
    padding: 2.083vw 2.448vw;
`,
   xm = C.exports.createContext(null),
   C1 = ({
      children: e
   }) => {
      const [t, n] = C.exports.useState({});
      return B(xm.Provider, {
         value: {
            data: t,
            setData: n
         },
         children: e
      })
   },
   Xu = () => C.exports.useContext(xm),
   P1 = Be.header`
    width: 100%;
    height: 8.333vw;
    display: flex;
    justify-content: space-between;
    align-items: center;
`,
   E1 = Be.div`
    display: flex;
    flex-direction: column;
    margin-left: 3.646vw;

    span {
        font-weight: 600;
        font-size: 2.083vw;
        line-height: 3.125vw;
        color: #FFF;
    }

    p {
        font-weight: 500;
        font-size: 1.25vw;
        line-height: 1.875vw;
        color: #40a7f7;
        margin-top: -1vw;
    }
`,
   T1 = Be.div`
    margin-right: 2.448vw;
    gap: 0.521vw;

    p {
        font-weight: 300;
        font-size: 0.729vw;
        line-height: 1.094vw;
        color: rgba(255, 255, 255, 0.3);
    }
`,
   _1 = Be.div`
    width: 11.771vw;
    height: 2.24vw;
    background: linear-gradient(92.51deg, rgba(64, 167, 247, 0.1) -5.33%, rgba(76, 174, 250, 0.1) 100.68%);
    border-radius: 0.365vw;
    display: flex;
    justify-content: space-between;

    input {
        width: 6.563vw;
        height: 100%;
        background: transparent;
        font-weight: 500;
        font-size: 0.729vw;
        line-height: 1.094vw;
        color: #40a7f7;
        text-align: center;

        &::placeholder {
            color: rgba(64,167,247, 0.2);
        }
    }

    button {
        width: 5.208vw;
        height: 100%;
        background: linear-gradient(92.51deg, rgba(64, 167, 247, 0.1) -5.33%, rgba(76, 174, 250, 0.1) 100.68%);
        border-radius: 0.365vw;
        font-weight: 600;
        font-size: 0.625vw;
        line-height: 0.938vw;
        color: #40a7f7;
        cursor: pointer;
        transition: all ease .4s;

        &:hover {
            background: linear-gradient(92.51deg, rgba(64, 167, 247, 0.2) -5.33%, rgba(76, 174, 250, 0.2) 100.68%);
        }

        &:active {
            background: linear-gradient(92.51deg, rgba(64, 167, 247, 0.1) -5.33%, rgba(76, 174, 250, 0.1) 100.68%);
        }
    }
`,
   A1 = () => {
      const {
         data: e,
         setData: t
      } = Xu(), [n, r] = C.exports.useState(0);

      function o() {
         Wr("invite", {
            user_id: n
         }, {
            id: 4,
            online: !0,
            role_id: e.members.length,
            name: "John Doe",
            phone: "000-000",
            role: "Membro"
         }).then(s => {
            if (typeof s == "object") {
               const l = {
                  ...e
               };
               l.members.push(s), t(l), r(0)
            }
         })
      }

      function i(s) {
         const l = Math.abs(parseInt(s));
         r(l)
      }
      return gt(P1, {
         children: [gt(E1, {
            children: [B("span", {
               children: "Painel"
            }), B("p", {
               children: e.groupName
            })]
         }), gt(T1, {
            children: [B("p", {
               children: "Adicionar membro"
            }), gt(_1, {
               children: [B("input", {
                  type: "number",
                  value: n === 0 ? "" : n,
                  onChange: s => i(s.target.value),
                  placeholder: "PASSAPORTE"
               }), B("button", {
                  onClick: o,
                  children: "ADICIONAR"
               })]
            })]
         })]
      })
   };
var R1 = "./assets/arrowUp.bcb64d0d.svg",
   V1 = "./assets/arrowDown.97a668ce.svg",
   L1 = "./assets/close.c9cc2f16.svg";
const M1 = Be.div`
    width: 100%;
    height: 100%;
`,
   O1 = Be.table`
    position: relative;
    width: 100%;
    max-height: 27.604vw;
    border-collapse: collapse;
    /* border-collapse: collapse; */
`,
   D1 = Be.thead`
    width: 100%;
    height: 1.7vw;

    > tr {
        position: relative;
        display: block;
    }

    th {
        width: 10.5vw;
        color: rgba(255, 255, 255, 0.5);
        font-weight: 400;
        text-align: left;
        font-size: 0.729vw;
    }
`,
   N1 = Be.tbody`
    font-size: 0.833vw;
    font-weight: 400;
    color: #FFFFFF;
    border-radius: 0.26vw;
    height: 27.604vw;
    display: block;
    overflow: auto;
    padding-right: 0.521vw;

    td {
        position: relative;
        width: 8vw;
    }

    tr {
        width: 100%;
        height: 2.76vw;
    }
`,
   I1 = Be.div`
    position: absolute;
    transform: translate(0%,-50%);
    width: 0.417vw;
    left: 1.875vw;
    top: 50%;
    height: 0.417vw;
    ${e=>e.actived?wo`
        background: #00BC7E;
        box-shadow: 0vw 0vw 0.521vw rgba(64,167,247, 0.4);
    `:wo`
        background: #F64740;
        box-shadow: 0vw 0vw 0.521vw rgba(246, 71, 64, 0.4);
    `}
    border-radius: 0.156vw;
`,
   z1 = {
      green: {
         background: "rgba(64,167,247, 0.08)"
      },
      yellow: {
         background: "rgba(188, 135, 0, 0.08)"
      },
      red: {
         background: "rgba(246, 71, 64, 0.08)"
      }
   },
   kl = Be.button`
    outline: none;
    border: none;
    width: 1.458vw;
    height: 1.458vw;
    border-radius: 0.208vw;
    margin-right: 0.417vw;
    background: ${e=>z1[e.buttonType].background};
    transition: all .2s ease-in-out;
    
    &:disabled {
        opacity: .4;
        cursor: default;
    }

    img {
        width: 0.677vw;
    }

    &:not(&:disabled):hover {
        opacity: .7;
    }
`,
   F1 = Be.tr`
    display: flex;
    align-items: center;
    ${e=>e.isPair?wo`
        background: rgba(64,167,247, 0.03);
    `:wo`
        background: none;
    `}
`,
   $1 = () => {
      const {
         data: e,
         setData: t
      } = Xu();

      function n(i) {
         Wr("promote", {
            user_id: i
         }, "L\xEDder").then(s => {
            if (typeof s == "string") {
               const l = {
                     ...e
                  },
                  a = l.members.findIndex(u => u.id === i);
               l.members[a].role = s, l.members[a].role_id--, t(l)
            }
         })
      }

      function r(i) {
         Wr("demote", {
            user_id: i
         }, "Membro").then(s => {
            if (typeof s == "string") {
               const l = {
                     ...e
                  },
                  a = l.members.findIndex(u => u.id === i);
               l.members[a].role = s, l.members[a].role_id++, t(l)
            }
         })
      }

      function o(i) {
         Wr("dismiss", {
            user_id: i
         }, !0).then(s => {
            if (s) {
               let l = {
                  ...e
               };
               l.members = l.members.filter(a => a.id !== i), t(l)
            }
         })
      }
      return B(M1, {
         children: gt(O1, {
            children: [B(D1, {
               children: gt("tr", {
                  children: [B("th", {
                     style: {
                        paddingLeft: "1.042vw",
                        width: "26.7vw"
                     },
                     children: "Nome"
                  }), B("th", {
                     style: {
                        width: "11.3vw"
                     },
                     children: "Cargo"
                  }), B("th", {
                     children: "Telefone"
                  }), B("th", {
                     style: {
                        width: "17.5vw"
                     },
                     children: "Gest\xE3o"
                  })]
               })
            }), B(N1, {
               children: e.members && e.members.sort((i, s) => i.role_id - s.role_id).map((i, s) => gt(F1, {
                  isPair: s % 2 === 0,
                  children: [gt("td", {
                     style: {
                        paddingLeft: "2.865vw",
                        width: "13.223vw"
                     },
                     children: [B(I1, {
                        actived: i.online
                     }), i.name]
                  }), B("td", {
                     style: {
                        width: "6.3vw"
                     },
                     children: i.role
                  }), B("td", {
                     style: {
                        width: "5.81vw"
                     },
                     children: i.phone
                  }), gt("td", {
                     children: [B(kl, {
                        disabled: i.role_id === 1,
                        onClick: () => n(i.id),
                        buttonType: "green",
                        children: B("img", {
                           src: R1
                        })
                     }), B(kl, {
                        disabled: i.role_id === 1,
                        onClick: () => r(i.id),
                        buttonType: "yellow",
                        children: B("img", {
                           src: V1
                        })
                     }), B(kl, {
                        disabled: i.role_id === 1,
                        onClick: () => o(i.id),
                        buttonType: "red",
                        children: B("img", {
                           src: L1
                        })
                     })]
                  })]
               }, s))
            })]
         })
      })
   },
   j1 = () => gt(x1, {
      children: [B(A1, {}), B(k1, {
         children: B($1, {})
      })]
   }),
   Zu = C.exports.createContext({
      transformPagePoint: e => e,
      isStatic: !1,
      reducedMotion: "never"
   }),
   zs = C.exports.createContext({});

function U1() {
   return C.exports.useContext(zs).visualElement
}
const Mo = C.exports.createContext(null),
   Dn = typeof document != "undefined",
   Xi = Dn ? C.exports.useLayoutEffect : C.exports.useEffect,
   km = C.exports.createContext({
      strict: !1
   });

function B1(e, t, n, r) {
   const o = U1(),
      i = C.exports.useContext(km),
      s = C.exports.useContext(Mo),
      l = C.exports.useContext(Zu).reducedMotion,
      a = C.exports.useRef();
   r = r || i.renderer, !a.current && r && (a.current = r(e, {
      visualState: t,
      parent: o,
      props: n,
      presenceId: s ? s.id : void 0,
      blockInitialAnimation: s ? s.initial === !1 : !1,
      reducedMotionConfig: l
   }));
   const u = a.current;
   return Xi(() => {
      u && u.render()
   }), C.exports.useEffect(() => {
      u && u.animationState && u.animationState.animateChanges()
   }), Xi(() => () => u && u.notify("Unmount"), []), u
}

function Zn(e) {
   return typeof e == "object" && Object.prototype.hasOwnProperty.call(e, "current")
}

function H1(e, t, n) {
   return C.exports.useCallback(r => {
      r && e.mount && e.mount(r), t && (r ? t.mount(r) : t.unmount()), n && (typeof n == "function" ? n(r) : Zn(n) && (n.current = r))
   }, [t])
}

function So(e) {
   return typeof e == "string" || Array.isArray(e)
}

function Fs(e) {
   return typeof e == "object" && typeof e.start == "function"
}
const b1 = ["initial", "animate", "exit", "whileHover", "whileDrag", "whileTap", "whileFocus", "whileInView"];

function $s(e) {
   return Fs(e.animate) || b1.some(t => So(e[t]))
}

function Cm(e) {
   return Boolean($s(e) || e.variants)
}

function W1(e, t) {
   if ($s(e)) {
      const {
         initial: n,
         animate: r
      } = e;
      return {
         initial: n === !1 || So(n) ? n : void 0,
         animate: So(r) ? r : void 0
      }
   }
   return e.inherit !== !1 ? t : {}
}

function G1(e) {
   const {
      initial: t,
      animate: n
   } = W1(e, C.exports.useContext(zs));
   return C.exports.useMemo(() => ({
      initial: t,
      animate: n
   }), [Hf(t), Hf(n)])
}

function Hf(e) {
   return Array.isArray(e) ? e.join(" ") : e
}
const At = e => ({
      isEnabled: t => e.some(n => !!t[n])
   }),
   xo = {
      measureLayout: At(["layout", "layoutId", "drag"]),
      animation: At(["animate", "exit", "variants", "whileHover", "whileTap", "whileFocus", "whileDrag", "whileInView"]),
      exit: At(["exit"]),
      drag: At(["drag", "dragControls"]),
      focus: At(["whileFocus"]),
      hover: At(["whileHover", "onHoverStart", "onHoverEnd"]),
      tap: At(["whileTap", "onTap", "onTapStart", "onTapCancel"]),
      pan: At(["onPan", "onPanStart", "onPanSessionStart", "onPanEnd"]),
      inView: At(["whileInView", "onViewportEnter", "onViewportLeave"])
   };

function Q1(e) {
   for (const t in e) t === "projectionNodeConstructor" ? xo.projectionNodeConstructor = e[t] : xo[t].Component = e[t]
}

function js(e) {
   const t = C.exports.useRef(null);
   return t.current === null && (t.current = e()), t.current
}
const Qr = {
   hasAnimatedSinceResize: !0,
   hasEverUpdated: !1
};
let Y1 = 1;

function K1() {
   return js(() => {
      if (Qr.hasEverUpdated) return Y1++
   })
}
const Ju = C.exports.createContext({});
class X1 extends Ln.Component {
   getSnapshotBeforeUpdate() {
      const {
         visualElement: t,
         props: n
      } = this.props;
      return t && t.setProps(n), null
   }
   componentDidUpdate() {}
   render() {
      return this.props.children
   }
}
const Pm = C.exports.createContext({}),
   Z1 = Symbol.for("motionComponentSymbol");

function J1({
   preloadedFeatures: e,
   createVisualElement: t,
   projectionNodeConstructor: n,
   useRender: r,
   useVisualState: o,
   Component: i
}) {
   e && Q1(e);

   function s(a, u) {
      const c = {
            ...C.exports.useContext(Zu),
            ...a,
            layoutId: q1(a)
         },
         {
            isStatic: f
         } = c;
      let d = null;
      const g = G1(a),
         v = f ? void 0 : K1(),
         w = o(a, f);
      if (!f && Dn) {
         g.visualElement = B1(i, w, c, t);
         const k = C.exports.useContext(km).strict,
            m = C.exports.useContext(Pm);
         g.visualElement && (d = g.visualElement.loadFeatures(c, k, e, v, n || xo.projectionNodeConstructor, m))
      }
      return C.exports.createElement(X1, {
         visualElement: g.visualElement,
         props: c
      }, d, C.exports.createElement(zs.Provider, {
         value: g
      }, r(i, a, v, H1(w, g.visualElement, u), w, f, g.visualElement)))
   }
   const l = C.exports.forwardRef(s);
   return l[Z1] = i, l
}

function q1({
   layoutId: e
}) {
   const t = C.exports.useContext(Ju).id;
   return t && e !== void 0 ? t + "-" + e : e
}

function ew(e) {
   function t(r, o = {}) {
      return J1(e(r, o))
   }
   if (typeof Proxy == "undefined") return t;
   const n = new Map;
   return new Proxy(t, {
      get: (r, o) => (n.has(o) || n.set(o, t(o)), n.get(o))
   })
}
const tw = ["animate", "circle", "defs", "desc", "ellipse", "g", "image", "line", "filter", "marker", "mask", "metadata", "path", "pattern", "polygon", "polyline", "rect", "stop", "svg", "switch", "symbol", "text", "tspan", "use", "view"];

function qu(e) {
   return typeof e != "string" || e.includes("-") ? !1 : !!(tw.indexOf(e) > -1 || /[A-Z]/.test(e))
}
const Zi = {};

function nw(e) {
   Object.assign(Zi, e)
}
const Ji = ["transformPerspective", "x", "y", "z", "translateX", "translateY", "translateZ", "scale", "scaleX", "scaleY", "rotate", "rotateX", "rotateY", "rotateZ", "skew", "skewX", "skewY"],
   Oo = new Set(Ji);

function Em(e, {
   layout: t,
   layoutId: n
}) {
   return Oo.has(e) || e.startsWith("origin") || (t || n !== void 0) && (!!Zi[e] || e === "opacity")
}
const wt = e => !!(e != null && e.getVelocity),
   rw = {
      x: "translateX",
      y: "translateY",
      z: "translateZ",
      transformPerspective: "perspective"
   },
   ow = (e, t) => Ji.indexOf(e) - Ji.indexOf(t);

function iw({
   transform: e,
   transformKeys: t
}, {
   enableHardwareAcceleration: n = !0,
   allowTransformNone: r = !0
}, o, i) {
   let s = "";
   t.sort(ow);
   for (const l of t) s += `${rw[l]||l}(${e[l]}) `;
   return n && !e.z && (s += "translateZ(0)"), s = s.trim(), i ? s = i(e, o ? "" : s) : r && o && (s = "none"), s
}

function Tm(e) {
   return e.startsWith("--")
}
const sw = (e, t) => t && typeof e == "number" ? t.transform(e) : e,
   _m = (e, t) => n => Math.max(Math.min(n, t), e),
   Yr = e => e % 1 ? Number(e.toFixed(5)) : e,
   ko = /(-)?([\d]*\.?[\d])+/g,
   Ma = /(#[0-9a-f]{6}|#[0-9a-f]{3}|#(?:[0-9a-f]{2}){2,4}|(rgb|hsl)a?\((-?[\d\.]+%?[,\s]+){2}(-?[\d\.]+%?)\s*[\,\/]?\s*[\d\.]*%?\))/gi,
   lw = /^(#[0-9a-f]{3}|#(?:[0-9a-f]{2}){2,4}|(rgb|hsl)a?\((-?[\d\.]+%?[,\s]+){2}(-?[\d\.]+%?)\s*[\,\/]?\s*[\d\.]*%?\))$/i;

function Do(e) {
   return typeof e == "string"
}
const Nn = {
      test: e => typeof e == "number",
      parse: parseFloat,
      transform: e => e
   },
   Kr = Object.assign(Object.assign({}, Nn), {
      transform: _m(0, 1)
   }),
   ri = Object.assign(Object.assign({}, Nn), {
      default: 1
   }),
   No = e => ({
      test: t => Do(t) && t.endsWith(e) && t.split(" ").length === 1,
      parse: parseFloat,
      transform: t => `${t}${e}`
   }),
   Ht = No("deg"),
   _t = No("%"),
   N = No("px"),
   aw = No("vh"),
   uw = No("vw"),
   bf = Object.assign(Object.assign({}, _t), {
      parse: e => _t.parse(e) / 100,
      transform: e => _t.transform(e * 100)
   }),
   ec = (e, t) => n => Boolean(Do(n) && lw.test(n) && n.startsWith(e) || t && Object.prototype.hasOwnProperty.call(n, t)),
   Am = (e, t, n) => r => {
      if (!Do(r)) return r;
      const [o, i, s, l] = r.match(ko);
      return {
         [e]: parseFloat(o),
         [t]: parseFloat(i),
         [n]: parseFloat(s),
         alpha: l !== void 0 ? parseFloat(l) : 1
      }
   },
   Cn = {
      test: ec("hsl", "hue"),
      parse: Am("hue", "saturation", "lightness"),
      transform: ({
         hue: e,
         saturation: t,
         lightness: n,
         alpha: r = 1
      }) => "hsla(" + Math.round(e) + ", " + _t.transform(Yr(t)) + ", " + _t.transform(Yr(n)) + ", " + Yr(Kr.transform(r)) + ")"
   },
   cw = _m(0, 255),
   Cl = Object.assign(Object.assign({}, Nn), {
      transform: e => Math.round(cw(e))
   }),
   Zt = {
      test: ec("rgb", "red"),
      parse: Am("red", "green", "blue"),
      transform: ({
         red: e,
         green: t,
         blue: n,
         alpha: r = 1
      }) => "rgba(" + Cl.transform(e) + ", " + Cl.transform(t) + ", " + Cl.transform(n) + ", " + Yr(Kr.transform(r)) + ")"
   };

function fw(e) {
   let t = "",
      n = "",
      r = "",
      o = "";
   return e.length > 5 ? (t = e.substr(1, 2), n = e.substr(3, 2), r = e.substr(5, 2), o = e.substr(7, 2)) : (t = e.substr(1, 1), n = e.substr(2, 1), r = e.substr(3, 1), o = e.substr(4, 1), t += t, n += n, r += r, o += o), {
      red: parseInt(t, 16),
      green: parseInt(n, 16),
      blue: parseInt(r, 16),
      alpha: o ? parseInt(o, 16) / 255 : 1
   }
}
const Oa = {
      test: ec("#"),
      parse: fw,
      transform: Zt.transform
   },
   ze = {
      test: e => Zt.test(e) || Oa.test(e) || Cn.test(e),
      parse: e => Zt.test(e) ? Zt.parse(e) : Cn.test(e) ? Cn.parse(e) : Oa.parse(e),
      transform: e => Do(e) ? e : e.hasOwnProperty("red") ? Zt.transform(e) : Cn.transform(e)
   },
   Rm = "${c}",
   Vm = "${n}";

function dw(e) {
   var t, n, r, o;
   return isNaN(e) && Do(e) && ((n = (t = e.match(ko)) === null || t === void 0 ? void 0 : t.length) !== null && n !== void 0 ? n : 0) + ((o = (r = e.match(Ma)) === null || r === void 0 ? void 0 : r.length) !== null && o !== void 0 ? o : 0) > 0
}

function Lm(e) {
   typeof e == "number" && (e = `${e}`);
   const t = [];
   let n = 0;
   const r = e.match(Ma);
   r && (n = r.length, e = e.replace(Ma, Rm), t.push(...r.map(ze.parse)));
   const o = e.match(ko);
   return o && (e = e.replace(ko, Vm), t.push(...o.map(Nn.parse))), {
      values: t,
      numColors: n,
      tokenised: e
   }
}

function Mm(e) {
   return Lm(e).values
}

function Om(e) {
   const {
      values: t,
      numColors: n,
      tokenised: r
   } = Lm(e), o = t.length;
   return i => {
      let s = r;
      for (let l = 0; l < o; l++) s = s.replace(l < n ? Rm : Vm, l < n ? ze.transform(i[l]) : Yr(i[l]));
      return s
   }
}
const pw = e => typeof e == "number" ? 0 : e;

function hw(e) {
   const t = Mm(e);
   return Om(e)(t.map(pw))
}
const $t = {
      test: dw,
      parse: Mm,
      createTransformer: Om,
      getAnimatableNone: hw
   },
   mw = new Set(["brightness", "contrast", "saturate", "opacity"]);

function gw(e) {
   let [t, n] = e.slice(0, -1).split("(");
   if (t === "drop-shadow") return e;
   const [r] = n.match(ko) || [];
   if (!r) return e;
   const o = n.replace(r, "");
   let i = mw.has(t) ? 1 : 0;
   return r !== n && (i *= 100), t + "(" + i + o + ")"
}
const vw = /([a-z-]*)\(.*?\)/g,
   Da = Object.assign(Object.assign({}, $t), {
      getAnimatableNone: e => {
         const t = e.match(vw);
         return t ? t.map(gw).join(" ") : e
      }
   }),
   Wf = {
      ...Nn,
      transform: Math.round
   },
   Dm = {
      borderWidth: N,
      borderTopWidth: N,
      borderRightWidth: N,
      borderBottomWidth: N,
      borderLeftWidth: N,
      borderRadius: N,
      radius: N,
      borderTopLeftRadius: N,
      borderTopRightRadius: N,
      borderBottomRightRadius: N,
      borderBottomLeftRadius: N,
      width: N,
      maxWidth: N,
      height: N,
      maxHeight: N,
      size: N,
      top: N,
      right: N,
      bottom: N,
      left: N,
      padding: N,
      paddingTop: N,
      paddingRight: N,
      paddingBottom: N,
      paddingLeft: N,
      margin: N,
      marginTop: N,
      marginRight: N,
      marginBottom: N,
      marginLeft: N,
      rotate: Ht,
      rotateX: Ht,
      rotateY: Ht,
      rotateZ: Ht,
      scale: ri,
      scaleX: ri,
      scaleY: ri,
      scaleZ: ri,
      skew: Ht,
      skewX: Ht,
      skewY: Ht,
      distance: N,
      translateX: N,
      translateY: N,
      translateZ: N,
      x: N,
      y: N,
      z: N,
      perspective: N,
      transformPerspective: N,
      opacity: Kr,
      originX: bf,
      originY: bf,
      originZ: N,
      zIndex: Wf,
      fillOpacity: Kr,
      strokeOpacity: Kr,
      numOctaves: Wf
   };

function tc(e, t, n, r) {
   const {
      style: o,
      vars: i,
      transform: s,
      transformKeys: l,
      transformOrigin: a
   } = e;
   l.length = 0;
   let u = !1,
      c = !1,
      f = !0;
   for (const d in t) {
      const g = t[d];
      if (Tm(d)) {
         i[d] = g;
         continue
      }
      const v = Dm[d],
         w = sw(g, v);
      if (Oo.has(d)) {
         if (u = !0, s[d] = w, l.push(d), !f) continue;
         g !== (v.default || 0) && (f = !1)
      } else d.startsWith("origin") ? (c = !0, a[d] = w) : o[d] = w
   }
   if (t.transform || (u || r ? o.transform = iw(e, n, f, r) : o.transform && (o.transform = "none")), c) {
      const {
         originX: d = "50%",
         originY: g = "50%",
         originZ: v = 0
      } = a;
      o.transformOrigin = `${d} ${g} ${v}`
   }
}
const nc = () => ({
   style: {},
   transform: {},
   transformKeys: [],
   transformOrigin: {},
   vars: {}
});

function Nm(e, t, n) {
   for (const r in t) !wt(t[r]) && !Em(r, n) && (e[r] = t[r])
}

function yw({
   transformTemplate: e
}, t, n) {
   return C.exports.useMemo(() => {
      const r = nc();
      return tc(r, t, {
         enableHardwareAcceleration: !n
      }, e), Object.assign({}, r.vars, r.style)
   }, [t])
}

function ww(e, t, n) {
   const r = e.style || {},
      o = {};
   return Nm(o, r, e), Object.assign(o, yw(e, t, n)), e.transformValues ? e.transformValues(o) : o
}

function Sw(e, t, n) {
   const r = {},
      o = ww(e, t, n);
   return e.drag && e.dragListener !== !1 && (r.draggable = !1, o.userSelect = o.WebkitUserSelect = o.WebkitTouchCallout = "none", o.touchAction = e.drag === !0 ? "none" : `pan-${e.drag==="x"?"y":"x"}`), r.style = o, r
}
const xw = ["animate", "exit", "variants", "whileHover", "whileTap", "whileFocus", "whileDrag", "whileInView"],
   kw = ["whileTap", "onTap", "onTapStart", "onTapCancel"],
   Cw = ["onPan", "onPanStart", "onPanSessionStart", "onPanEnd"],
   Pw = ["whileInView", "onViewportEnter", "onViewportLeave", "viewport"],
   Ew = new Set(["initial", "style", "values", "variants", "transition", "transformTemplate", "transformValues", "custom", "inherit", "layout", "layoutId", "layoutDependency", "onLayoutAnimationStart", "onLayoutAnimationComplete", "onLayoutMeasure", "onBeforeLayoutMeasure", "onAnimationStart", "onAnimationComplete", "onUpdate", "onDragStart", "onDrag", "onDragEnd", "onMeasureDragConstraints", "onDirectionLock", "onDragTransitionEnd", "drag", "dragControls", "dragListener", "dragConstraints", "dragDirectionLock", "dragSnapToOrigin", "_dragX", "_dragY", "dragElastic", "dragMomentum", "dragPropagation", "dragTransition", "onHoverStart", "onHoverEnd", "layoutScroll", ...Pw, ...kw, ...xw, ...Cw]);

function qi(e) {
   return Ew.has(e)
}
let Im = e => !qi(e);

function Tw(e) {
   !e || (Im = t => t.startsWith("on") ? !qi(t) : e(t))
}
try {
   Tw(require("@emotion/is-prop-valid").default)
} catch {}

function _w(e, t, n) {
   const r = {};
   for (const o in e)(Im(o) || n === !0 && qi(o) || !t && !qi(o) || e.draggable && o.startsWith("onDrag")) && (r[o] = e[o]);
   return r
}

function Gf(e, t, n) {
   return typeof e == "string" ? e : N.transform(t + n * e)
}

function Aw(e, t, n) {
   const r = Gf(t, e.x, e.width),
      o = Gf(n, e.y, e.height);
   return `${r} ${o}`
}
const Rw = {
      offset: "stroke-dashoffset",
      array: "stroke-dasharray"
   },
   Vw = {
      offset: "strokeDashoffset",
      array: "strokeDasharray"
   };

function Lw(e, t, n = 1, r = 0, o = !0) {
   e.pathLength = 1;
   const i = o ? Rw : Vw;
   e[i.offset] = N.transform(-r);
   const s = N.transform(t),
      l = N.transform(n);
   e[i.array] = `${s} ${l}`
}

function rc(e, {
   attrX: t,
   attrY: n,
   originX: r,
   originY: o,
   pathLength: i,
   pathSpacing: s = 1,
   pathOffset: l = 0,
   ...a
}, u, c) {
   tc(e, a, u, c), e.attrs = e.style, e.style = {};
   const {
      attrs: f,
      style: d,
      dimensions: g
   } = e;
   f.transform && (g && (d.transform = f.transform), delete f.transform), g && (r !== void 0 || o !== void 0 || d.transform) && (d.transformOrigin = Aw(g, r !== void 0 ? r : .5, o !== void 0 ? o : .5)), t !== void 0 && (f.x = t), n !== void 0 && (f.y = n), i !== void 0 && Lw(f, i, s, l, !1)
}
const zm = () => ({
   ...nc(),
   attrs: {}
});

function Mw(e, t) {
   const n = C.exports.useMemo(() => {
      const r = zm();
      return rc(r, t, {
         enableHardwareAcceleration: !1
      }, e.transformTemplate), {
         ...r.attrs,
         style: {
            ...r.style
         }
      }
   }, [t]);
   if (e.style) {
      const r = {};
      Nm(r, e.style, e), n.style = {
         ...r,
         ...n.style
      }
   }
   return n
}

function Ow(e = !1) {
   return (n, r, o, i, {
      latestValues: s
   }, l) => {
      const u = (qu(n) ? Mw : Sw)(r, s, l),
         f = {
            ..._w(r, typeof n == "string", e),
            ...u,
            ref: i
         };
      return o && (f["data-projection-id"] = o), C.exports.createElement(n, f)
   }
}
const Fm = e => e.replace(/([a-z])([A-Z])/g, "$1-$2").toLowerCase();

function $m(e, {
   style: t,
   vars: n
}, r, o) {
   Object.assign(e.style, t, o && o.getProjectionStyles(r));
   for (const i in n) e.style.setProperty(i, n[i])
}
const jm = new Set(["baseFrequency", "diffuseConstant", "kernelMatrix", "kernelUnitLength", "keySplines", "keyTimes", "limitingConeAngle", "markerHeight", "markerWidth", "numOctaves", "targetX", "targetY", "surfaceScale", "specularConstant", "specularExponent", "stdDeviation", "tableValues", "viewBox", "gradientTransform", "pathLength"]);

function Um(e, t, n, r) {
   $m(e, t, void 0, r);
   for (const o in t.attrs) e.setAttribute(jm.has(o) ? o : Fm(o), t.attrs[o])
}

function oc(e) {
   const {
      style: t
   } = e, n = {};
   for (const r in t)(wt(t[r]) || Em(r, e)) && (n[r] = t[r]);
   return n
}

function Bm(e) {
   const t = oc(e);
   for (const n in e)
      if (wt(e[n])) {
         const r = n === "x" || n === "y" ? "attr" + n.toUpperCase() : n;
         t[r] = e[n]
      } return t
}

function ic(e, t, n, r = {}, o = {}) {
   return typeof t == "function" && (t = t(n !== void 0 ? n : e.custom, r, o)), typeof t == "string" && (t = e.variants && e.variants[t]), typeof t == "function" && (t = t(n !== void 0 ? n : e.custom, r, o)), t
}
const Co = e => Array.isArray(e),
   Dw = e => Boolean(e && typeof e == "object" && e.mix && e.toValue),
   Hm = e => Co(e) ? e[e.length - 1] || 0 : e;

function xi(e) {
   const t = wt(e) ? e.get() : e;
   return Dw(t) ? t.toValue() : t
}

function Nw({
   scrapeMotionValuesFromProps: e,
   createRenderState: t,
   onMount: n
}, r, o, i) {
   const s = {
      latestValues: Iw(r, o, i, e),
      renderState: t()
   };
   return n && (s.mount = l => n(r, l, s)), s
}
const bm = e => (t, n) => {
   const r = C.exports.useContext(zs),
      o = C.exports.useContext(Mo),
      i = () => Nw(e, t, r, o);
   return n ? i() : js(i)
};

function Iw(e, t, n, r) {
   const o = {},
      i = r(e);
   for (const d in i) o[d] = xi(i[d]);
   let {
      initial: s,
      animate: l
   } = e;
   const a = $s(e),
      u = Cm(e);
   t && u && !a && e.inherit !== !1 && (s === void 0 && (s = t.initial), l === void 0 && (l = t.animate));
   let c = n ? n.initial === !1 : !1;
   c = c || s === !1;
   const f = c ? l : s;
   return f && typeof f != "boolean" && !Fs(f) && (Array.isArray(f) ? f : [f]).forEach(g => {
      const v = ic(e, g);
      if (!v) return;
      const {
         transitionEnd: w,
         transition: k,
         ...m
      } = v;
      for (const p in m) {
         let h = m[p];
         if (Array.isArray(h)) {
            const y = c ? h.length - 1 : 0;
            h = h[y]
         }
         h !== null && (o[p] = h)
      }
      for (const p in w) o[p] = w[p]
   }), o
}
const zw = {
      useVisualState: bm({
         scrapeMotionValuesFromProps: Bm,
         createRenderState: zm,
         onMount: (e, t, {
            renderState: n,
            latestValues: r
         }) => {
            try {
               n.dimensions = typeof t.getBBox == "function" ? t.getBBox() : t.getBoundingClientRect()
            } catch {
               n.dimensions = {
                  x: 0,
                  y: 0,
                  width: 0,
                  height: 0
               }
            }
            rc(n, r, {
               enableHardwareAcceleration: !1
            }, e.transformTemplate), Um(t, n)
         }
      })
   },
   Fw = {
      useVisualState: bm({
         scrapeMotionValuesFromProps: oc,
         createRenderState: nc
      })
   };

function $w(e, {
   forwardMotionProps: t = !1
}, n, r, o) {
   return {
      ...qu(e) ? zw : Fw,
      preloadedFeatures: n,
      useRender: Ow(t),
      createVisualElement: r,
      projectionNodeConstructor: o,
      Component: e
   }
}
var ee;
(function (e) {
   e.Animate = "animate", e.Hover = "whileHover", e.Tap = "whileTap", e.Drag = "whileDrag", e.Focus = "whileFocus", e.InView = "whileInView", e.Exit = "exit"
})(ee || (ee = {}));

function Us(e, t, n, r = {
   passive: !0
}) {
   return e.addEventListener(t, n, r), () => e.removeEventListener(t, n)
}

function Na(e, t, n, r) {
   C.exports.useEffect(() => {
      const o = e.current;
      if (n && o) return Us(o, t, n, r)
   }, [e, t, n, r])
}

function jw({
   whileFocus: e,
   visualElement: t
}) {
   const {
      animationState: n
   } = t, r = () => {
      n && n.setActive(ee.Focus, !0)
   }, o = () => {
      n && n.setActive(ee.Focus, !1)
   };
   Na(t, "focus", e ? r : void 0), Na(t, "blur", e ? o : void 0)
}

function Wm(e) {
   return typeof PointerEvent != "undefined" && e instanceof PointerEvent ? e.pointerType === "mouse" : e instanceof MouseEvent
}

function Gm(e) {
   return !!e.touches
}

function Uw(e) {
   return t => {
      const n = t instanceof MouseEvent;
      (!n || n && t.button === 0) && e(t)
   }
}
const Bw = {
   pageX: 0,
   pageY: 0
};

function Hw(e, t = "page") {
   const r = e.touches[0] || e.changedTouches[0] || Bw;
   return {
      x: r[t + "X"],
      y: r[t + "Y"]
   }
}

function bw(e, t = "page") {
   return {
      x: e[t + "X"],
      y: e[t + "Y"]
   }
}

function sc(e, t = "page") {
   return {
      point: Gm(e) ? Hw(e, t) : bw(e, t)
   }
}
const Qm = (e, t = !1) => {
      const n = r => e(r, sc(r));
      return t ? Uw(n) : n
   },
   Ww = () => Dn && window.onpointerdown === null,
   Gw = () => Dn && window.ontouchstart === null,
   Qw = () => Dn && window.onmousedown === null,
   Yw = {
      pointerdown: "mousedown",
      pointermove: "mousemove",
      pointerup: "mouseup",
      pointercancel: "mousecancel",
      pointerover: "mouseover",
      pointerout: "mouseout",
      pointerenter: "mouseenter",
      pointerleave: "mouseleave"
   },
   Kw = {
      pointerdown: "touchstart",
      pointermove: "touchmove",
      pointerup: "touchend",
      pointercancel: "touchcancel"
   };

function Ym(e) {
   return Ww() ? e : Gw() ? Kw[e] : Qw() ? Yw[e] : e
}

function ir(e, t, n, r) {
   return Us(e, Ym(t), Qm(n, t === "pointerdown"), r)
}

function es(e, t, n, r) {
   return Na(e, Ym(t), n && Qm(n, t === "pointerdown"), r)
}

function Km(e) {
   let t = null;
   return () => {
      const n = () => {
         t = null
      };
      return t === null ? (t = e, n) : !1
   }
}
const Qf = Km("dragHorizontal"),
   Yf = Km("dragVertical");

function Xm(e) {
   let t = !1;
   if (e === "y") t = Yf();
   else if (e === "x") t = Qf();
   else {
      const n = Qf(),
         r = Yf();
      n && r ? t = () => {
         n(), r()
      } : (n && n(), r && r())
   }
   return t
}

function Zm() {
   const e = Xm(!0);
   return e ? (e(), !1) : !0
}

function Kf(e, t, n) {
   return (r, o) => {
      !Wm(r) || Zm() || (e.animationState && e.animationState.setActive(ee.Hover, t), n && n(r, o))
   }
}

function Xw({
   onHoverStart: e,
   onHoverEnd: t,
   whileHover: n,
   visualElement: r
}) {
   es(r, "pointerenter", e || n ? Kf(r, !0, e) : void 0, {
      passive: !e
   }), es(r, "pointerleave", t || n ? Kf(r, !1, t) : void 0, {
      passive: !t
   })
}
const Jm = (e, t) => t ? e === t ? !0 : Jm(e, t.parentElement) : !1;

function lc(e) {
   return C.exports.useEffect(() => () => e(), [])
}

function qm(e, t) {
   var n = {};
   for (var r in e) Object.prototype.hasOwnProperty.call(e, r) && t.indexOf(r) < 0 && (n[r] = e[r]);
   if (e != null && typeof Object.getOwnPropertySymbols == "function")
      for (var o = 0, r = Object.getOwnPropertySymbols(e); o < r.length; o++) t.indexOf(r[o]) < 0 && Object.prototype.propertyIsEnumerable.call(e, r[o]) && (n[r[o]] = e[r[o]]);
   return n
}
var Zw = function () {},
   ts = function () {};
const ns = (e, t, n) => Math.min(Math.max(n, e), t),
   Pl = .001,
   Jw = .01,
   Xf = 10,
   qw = .05,
   eS = 1;

function tS({
   duration: e = 800,
   bounce: t = .25,
   velocity: n = 0,
   mass: r = 1
}) {
   let o, i;
   Zw(e <= Xf * 1e3);
   let s = 1 - t;
   s = ns(qw, eS, s), e = ns(Jw, Xf, e / 1e3), s < 1 ? (o = u => {
      const c = u * s,
         f = c * e,
         d = c - n,
         g = Ia(u, s),
         v = Math.exp(-f);
      return Pl - d / g * v
   }, i = u => {
      const f = u * s * e,
         d = f * n + n,
         g = Math.pow(s, 2) * Math.pow(u, 2) * e,
         v = Math.exp(-f),
         w = Ia(Math.pow(u, 2), s);
      return (-o(u) + Pl > 0 ? -1 : 1) * ((d - g) * v) / w
   }) : (o = u => {
      const c = Math.exp(-u * e),
         f = (u - n) * e + 1;
      return -Pl + c * f
   }, i = u => {
      const c = Math.exp(-u * e),
         f = (n - u) * (e * e);
      return c * f
   });
   const l = 5 / e,
      a = rS(o, i, l);
   if (e = e * 1e3, isNaN(a)) return {
      stiffness: 100,
      damping: 10,
      duration: e
   }; {
      const u = Math.pow(a, 2) * r;
      return {
         stiffness: u,
         damping: s * 2 * Math.sqrt(r * u),
         duration: e
      }
   }
}
const nS = 12;

function rS(e, t, n) {
   let r = n;
   for (let o = 1; o < nS; o++) r = r - e(r) / t(r);
   return r
}

function Ia(e, t) {
   return e * Math.sqrt(1 - t * t)
}
const oS = ["duration", "bounce"],
   iS = ["stiffness", "damping", "mass"];

function Zf(e, t) {
   return t.some(n => e[n] !== void 0)
}

function sS(e) {
   let t = Object.assign({
      velocity: 0,
      stiffness: 100,
      damping: 10,
      mass: 1,
      isResolvedFromDuration: !1
   }, e);
   if (!Zf(e, iS) && Zf(e, oS)) {
      const n = tS(e);
      t = Object.assign(Object.assign(Object.assign({}, t), n), {
         velocity: 0,
         mass: 1
      }), t.isResolvedFromDuration = !0
   }
   return t
}

function ac(e) {
   var {
      from: t = 0,
      to: n = 1,
      restSpeed: r = 2,
      restDelta: o
   } = e, i = qm(e, ["from", "to", "restSpeed", "restDelta"]);
   const s = {
      done: !1,
      value: t
   };
   let {
      stiffness: l,
      damping: a,
      mass: u,
      velocity: c,
      duration: f,
      isResolvedFromDuration: d
   } = sS(i), g = Jf, v = Jf;

   function w() {
      const k = c ? -(c / 1e3) : 0,
         m = n - t,
         p = a / (2 * Math.sqrt(l * u)),
         h = Math.sqrt(l / u) / 1e3;
      if (o === void 0 && (o = Math.min(Math.abs(n - t) / 100, .4)), p < 1) {
         const y = Ia(h, p);
         g = x => {
            const E = Math.exp(-p * h * x);
            return n - E * ((k + p * h * m) / y * Math.sin(y * x) + m * Math.cos(y * x))
         }, v = x => {
            const E = Math.exp(-p * h * x);
            return p * h * E * (Math.sin(y * x) * (k + p * h * m) / y + m * Math.cos(y * x)) - E * (Math.cos(y * x) * (k + p * h * m) - y * m * Math.sin(y * x))
         }
      } else if (p === 1) g = y => n - Math.exp(-h * y) * (m + (k + h * m) * y);
      else {
         const y = h * Math.sqrt(p * p - 1);
         g = x => {
            const E = Math.exp(-p * h * x),
               T = Math.min(y * x, 300);
            return n - E * ((k + p * h * m) * Math.sinh(T) + y * m * Math.cosh(T)) / y
         }
      }
   }
   return w(), {
      next: k => {
         const m = g(k);
         if (d) s.done = k >= f;
         else {
            const p = v(k) * 1e3,
               h = Math.abs(p) <= r,
               y = Math.abs(n - m) <= o;
            s.done = h && y
         }
         return s.value = s.done ? n : m, s
      },
      flipTarget: () => {
         c = -c, [t, n] = [n, t], w()
      }
   }
}
ac.needsInterpolation = (e, t) => typeof e == "string" || typeof t == "string";
const Jf = e => 0,
   Po = (e, t, n) => {
      const r = t - e;
      return r === 0 ? 1 : (n - e) / r
   },
   he = (e, t, n) => -n * e + n * t + e;

function El(e, t, n) {
   return n < 0 && (n += 1), n > 1 && (n -= 1), n < 1 / 6 ? e + (t - e) * 6 * n : n < 1 / 2 ? t : n < 2 / 3 ? e + (t - e) * (2 / 3 - n) * 6 : e
}

function qf({
   hue: e,
   saturation: t,
   lightness: n,
   alpha: r
}) {
   e /= 360, t /= 100, n /= 100;
   let o = 0,
      i = 0,
      s = 0;
   if (!t) o = i = s = n;
   else {
      const l = n < .5 ? n * (1 + t) : n + t - n * t,
         a = 2 * n - l;
      o = El(a, l, e + 1 / 3), i = El(a, l, e), s = El(a, l, e - 1 / 3)
   }
   return {
      red: Math.round(o * 255),
      green: Math.round(i * 255),
      blue: Math.round(s * 255),
      alpha: r
   }
}
const lS = (e, t, n) => {
      const r = e * e,
         o = t * t;
      return Math.sqrt(Math.max(0, n * (o - r) + r))
   },
   aS = [Oa, Zt, Cn],
   ed = e => aS.find(t => t.test(e)),
   e0 = (e, t) => {
      let n = ed(e),
         r = ed(t),
         o = n.parse(e),
         i = r.parse(t);
      n === Cn && (o = qf(o), n = Zt), r === Cn && (i = qf(i), r = Zt);
      const s = Object.assign({}, o);
      return l => {
         for (const a in s) a !== "alpha" && (s[a] = lS(o[a], i[a], l));
         return s.alpha = he(o.alpha, i.alpha, l), n.transform(s)
      }
   },
   za = e => typeof e == "number",
   uS = (e, t) => n => t(e(n)),
   Bs = (...e) => e.reduce(uS);

function t0(e, t) {
   return za(e) ? n => he(e, t, n) : ze.test(e) ? e0(e, t) : r0(e, t)
}
const n0 = (e, t) => {
      const n = [...e],
         r = n.length,
         o = e.map((i, s) => t0(i, t[s]));
      return i => {
         for (let s = 0; s < r; s++) n[s] = o[s](i);
         return n
      }
   },
   cS = (e, t) => {
      const n = Object.assign(Object.assign({}, e), t),
         r = {};
      for (const o in n) e[o] !== void 0 && t[o] !== void 0 && (r[o] = t0(e[o], t[o]));
      return o => {
         for (const i in r) n[i] = r[i](o);
         return n
      }
   };

function td(e) {
   const t = $t.parse(e),
      n = t.length;
   let r = 0,
      o = 0,
      i = 0;
   for (let s = 0; s < n; s++) r || typeof t[s] == "number" ? r++ : t[s].hue !== void 0 ? i++ : o++;
   return {
      parsed: t,
      numNumbers: r,
      numRGB: o,
      numHSL: i
   }
}
const r0 = (e, t) => {
      const n = $t.createTransformer(t),
         r = td(e),
         o = td(t);
      return r.numHSL === o.numHSL && r.numRGB === o.numRGB && r.numNumbers >= o.numNumbers ? Bs(n0(r.parsed, o.parsed), n) : s => `${s>0?t:e}`
   },
   fS = (e, t) => n => he(e, t, n);

function dS(e) {
   if (typeof e == "number") return fS;
   if (typeof e == "string") return ze.test(e) ? e0 : r0;
   if (Array.isArray(e)) return n0;
   if (typeof e == "object") return cS
}

function pS(e, t, n) {
   const r = [],
      o = n || dS(e[0]),
      i = e.length - 1;
   for (let s = 0; s < i; s++) {
      let l = o(e[s], e[s + 1]);
      if (t) {
         const a = Array.isArray(t) ? t[s] : t;
         l = Bs(a, l)
      }
      r.push(l)
   }
   return r
}

function hS([e, t], [n]) {
   return r => n(Po(e, t, r))
}

function mS(e, t) {
   const n = e.length,
      r = n - 1;
   return o => {
      let i = 0,
         s = !1;
      if (o <= e[0] ? s = !0 : o >= e[r] && (i = r - 1, s = !0), !s) {
         let a = 1;
         for (; a < n && !(e[a] > o || a === r); a++);
         i = a - 1
      }
      const l = Po(e[i], e[i + 1], o);
      return t[i](l)
   }
}

function o0(e, t, {
   clamp: n = !0,
   ease: r,
   mixer: o
} = {}) {
   const i = e.length;
   ts(i === t.length), ts(!r || !Array.isArray(r) || r.length === i - 1), e[0] > e[i - 1] && (e = [].concat(e), t = [].concat(t), e.reverse(), t.reverse());
   const s = pS(t, r, o),
      l = i === 2 ? hS(e, s) : mS(e, s);
   return n ? a => l(ns(e[0], e[i - 1], a)) : l
}
const Hs = e => t => 1 - e(1 - t),
   uc = e => t => t <= .5 ? e(2 * t) / 2 : (2 - e(2 * (1 - t))) / 2,
   gS = e => t => Math.pow(t, e),
   i0 = e => t => t * t * ((e + 1) * t - e),
   vS = e => {
      const t = i0(e);
      return n => (n *= 2) < 1 ? .5 * t(n) : .5 * (2 - Math.pow(2, -10 * (n - 1)))
   },
   s0 = 1.525,
   yS = 4 / 11,
   wS = 8 / 11,
   SS = 9 / 10,
   cc = e => e,
   fc = gS(2),
   xS = Hs(fc),
   l0 = uc(fc),
   a0 = e => 1 - Math.sin(Math.acos(e)),
   dc = Hs(a0),
   kS = uc(dc),
   pc = i0(s0),
   CS = Hs(pc),
   PS = uc(pc),
   ES = vS(s0),
   TS = 4356 / 361,
   _S = 35442 / 1805,
   AS = 16061 / 1805,
   rs = e => {
      if (e === 1 || e === 0) return e;
      const t = e * e;
      return e < yS ? 7.5625 * t : e < wS ? 9.075 * t - 9.9 * e + 3.4 : e < SS ? TS * t - _S * e + AS : 10.8 * e * e - 20.52 * e + 10.72
   },
   RS = Hs(rs),
   VS = e => e < .5 ? .5 * (1 - rs(1 - e * 2)) : .5 * rs(e * 2 - 1) + .5;

function LS(e, t) {
   return e.map(() => t || l0).splice(0, e.length - 1)
}

function MS(e) {
   const t = e.length;
   return e.map((n, r) => r !== 0 ? r / (t - 1) : 0)
}

function OS(e, t) {
   return e.map(n => n * t)
}

function ki({
   from: e = 0,
   to: t = 1,
   ease: n,
   offset: r,
   duration: o = 300
}) {
   const i = {
         done: !1,
         value: e
      },
      s = Array.isArray(t) ? t : [e, t],
      l = OS(r && r.length === s.length ? r : MS(s), o);

   function a() {
      return o0(l, s, {
         ease: Array.isArray(n) ? n : LS(s, n)
      })
   }
   let u = a();
   return {
      next: c => (i.value = u(c), i.done = c >= o, i),
      flipTarget: () => {
         s.reverse(), u = a()
      }
   }
}

function DS({
   velocity: e = 0,
   from: t = 0,
   power: n = .8,
   timeConstant: r = 350,
   restDelta: o = .5,
   modifyTarget: i
}) {
   const s = {
      done: !1,
      value: t
   };
   let l = n * e;
   const a = t + l,
      u = i === void 0 ? a : i(a);
   return u !== a && (l = u - t), {
      next: c => {
         const f = -l * Math.exp(-c / r);
         return s.done = !(f > o || f < -o), s.value = s.done ? u : u + f, s
      },
      flipTarget: () => {}
   }
}
const nd = {
   keyframes: ki,
   spring: ac,
   decay: DS
};

function NS(e) {
   if (Array.isArray(e.to)) return ki;
   if (nd[e.type]) return nd[e.type];
   const t = new Set(Object.keys(e));
   return t.has("ease") || t.has("duration") && !t.has("dampingRatio") ? ki : t.has("dampingRatio") || t.has("stiffness") || t.has("mass") || t.has("damping") || t.has("restSpeed") || t.has("restDelta") ? ac : ki
}
const u0 = 1 / 60 * 1e3,
   IS = typeof performance != "undefined" ? () => performance.now() : () => Date.now(),
   c0 = typeof window != "undefined" ? e => window.requestAnimationFrame(e) : e => setTimeout(() => e(IS()), u0);

function zS(e) {
   let t = [],
      n = [],
      r = 0,
      o = !1,
      i = !1;
   const s = new WeakSet,
      l = {
         schedule: (a, u = !1, c = !1) => {
            const f = c && o,
               d = f ? t : n;
            return u && s.add(a), d.indexOf(a) === -1 && (d.push(a), f && o && (r = t.length)), a
         },
         cancel: a => {
            const u = n.indexOf(a);
            u !== -1 && n.splice(u, 1), s.delete(a)
         },
         process: a => {
            if (o) {
               i = !0;
               return
            }
            if (o = !0, [t, n] = [n, t], n.length = 0, r = t.length, r)
               for (let u = 0; u < r; u++) {
                  const c = t[u];
                  c(a), s.has(c) && (l.schedule(c), e())
               }
            o = !1, i && (i = !1, l.process(a))
         }
      };
   return l
}
const FS = 40;
let Fa = !0,
   Eo = !1,
   $a = !1;
const sr = {
      delta: 0,
      timestamp: 0
   },
   Io = ["read", "update", "preRender", "render", "postRender"],
   bs = Io.reduce((e, t) => (e[t] = zS(() => Eo = !0), e), {}),
   lt = Io.reduce((e, t) => {
      const n = bs[t];
      return e[t] = (r, o = !1, i = !1) => (Eo || jS(), n.schedule(r, o, i)), e
   }, {}),
   fn = Io.reduce((e, t) => (e[t] = bs[t].cancel, e), {}),
   Tl = Io.reduce((e, t) => (e[t] = () => bs[t].process(sr), e), {}),
   $S = e => bs[e].process(sr),
   f0 = e => {
      Eo = !1, sr.delta = Fa ? u0 : Math.max(Math.min(e - sr.timestamp, FS), 1), sr.timestamp = e, $a = !0, Io.forEach($S), $a = !1, Eo && (Fa = !1, c0(f0))
   },
   jS = () => {
      Eo = !0, Fa = !0, $a || c0(f0)
   },
   os = () => sr;

function d0(e, t, n = 0) {
   return e - t - n
}

function US(e, t, n = 0, r = !0) {
   return r ? d0(t + -e, t, n) : t - (e - t) + n
}

function BS(e, t, n, r) {
   return r ? e >= t + n : e <= -n
}
const HS = e => {
   const t = ({
      delta: n
   }) => e(n);
   return {
      start: () => lt.update(t, !0),
      stop: () => fn.update(t)
   }
};

function p0(e) {
   var t, n, {
         from: r,
         autoplay: o = !0,
         driver: i = HS,
         elapsed: s = 0,
         repeat: l = 0,
         repeatType: a = "loop",
         repeatDelay: u = 0,
         onPlay: c,
         onStop: f,
         onComplete: d,
         onRepeat: g,
         onUpdate: v
      } = e,
      w = qm(e, ["from", "autoplay", "driver", "elapsed", "repeat", "repeatType", "repeatDelay", "onPlay", "onStop", "onComplete", "onRepeat", "onUpdate"]);
   let {
      to: k
   } = w, m, p = 0, h = w.duration, y, x = !1, E = !0, T;
   const A = NS(w);
   !((n = (t = A).needsInterpolation) === null || n === void 0) && n.call(t, r, k) && (T = o0([0, 100], [r, k], {
      clamp: !1
   }), r = 0, k = 100);
   const I = A(Object.assign(Object.assign({}, w), {
      from: r,
      to: k
   }));

   function D() {
      p++, a === "reverse" ? (E = p % 2 === 0, s = US(s, h, u, E)) : (s = d0(s, h, u), a === "mirror" && I.flipTarget()), x = !1, g && g()
   }

   function se() {
      m.stop(), d && d()
   }

   function J(we) {
      if (E || (we = -we), s += we, !x) {
         const le = I.next(Math.max(0, s));
         y = le.value, T && (y = T(y)), x = E ? le.done : s <= 0
      }
      v == null || v(y), x && (p === 0 && (h != null || (h = s)), p < l ? BS(s, h, u, E) && D() : se())
   }

   function fe() {
      c == null || c(), m = i(J), m.start()
   }
   return o && fe(), {
      stop: () => {
         f == null || f(), m.stop()
      }
   }
}

function h0(e, t) {
   return t ? e * (1e3 / t) : 0
}

function bS({
   from: e = 0,
   velocity: t = 0,
   min: n,
   max: r,
   power: o = .8,
   timeConstant: i = 750,
   bounceStiffness: s = 500,
   bounceDamping: l = 10,
   restDelta: a = 1,
   modifyTarget: u,
   driver: c,
   onUpdate: f,
   onComplete: d,
   onStop: g
}) {
   let v;

   function w(h) {
      return n !== void 0 && h < n || r !== void 0 && h > r
   }

   function k(h) {
      return n === void 0 ? r : r === void 0 || Math.abs(n - h) < Math.abs(r - h) ? n : r
   }

   function m(h) {
      v == null || v.stop(), v = p0(Object.assign(Object.assign({}, h), {
         driver: c,
         onUpdate: y => {
            var x;
            f == null || f(y), (x = h.onUpdate) === null || x === void 0 || x.call(h, y)
         },
         onComplete: d,
         onStop: g
      }))
   }

   function p(h) {
      m(Object.assign({
         type: "spring",
         stiffness: s,
         damping: l,
         restDelta: a
      }, h))
   }
   if (w(e)) p({
      from: e,
      velocity: t,
      to: k(e)
   });
   else {
      let h = o * t + e;
      typeof u != "undefined" && (h = u(h));
      const y = k(h),
         x = y === n ? -1 : 1;
      let E, T;
      const A = I => {
         E = T, T = I, t = h0(I - E, os().delta), (x === 1 && I > y || x === -1 && I < y) && p({
            from: I,
            to: y,
            velocity: t
         })
      };
      m({
         type: "decay",
         from: e,
         velocity: t,
         timeConstant: i,
         power: o,
         restDelta: a,
         modifyTarget: u,
         onUpdate: w(h) ? A : void 0
      })
   }
   return {
      stop: () => v == null ? void 0 : v.stop()
   }
}
const ja = e => e.hasOwnProperty("x") && e.hasOwnProperty("y"),
   rd = e => ja(e) && e.hasOwnProperty("z"),
   oi = (e, t) => Math.abs(e - t);

function hc(e, t) {
   if (za(e) && za(t)) return oi(e, t);
   if (ja(e) && ja(t)) {
      const n = oi(e.x, t.x),
         r = oi(e.y, t.y),
         o = rd(e) && rd(t) ? oi(e.z, t.z) : 0;
      return Math.sqrt(Math.pow(n, 2) + Math.pow(r, 2) + Math.pow(o, 2))
   }
}
const m0 = (e, t) => 1 - 3 * t + 3 * e,
   g0 = (e, t) => 3 * t - 6 * e,
   v0 = e => 3 * e,
   is = (e, t, n) => ((m0(t, n) * e + g0(t, n)) * e + v0(t)) * e,
   y0 = (e, t, n) => 3 * m0(t, n) * e * e + 2 * g0(t, n) * e + v0(t),
   WS = 1e-7,
   GS = 10;

function QS(e, t, n, r, o) {
   let i, s, l = 0;
   do s = t + (n - t) / 2, i = is(s, r, o) - e, i > 0 ? n = s : t = s; while (Math.abs(i) > WS && ++l < GS);
   return s
}
const YS = 8,
   KS = .001;

function XS(e, t, n, r) {
   for (let o = 0; o < YS; ++o) {
      const i = y0(t, n, r);
      if (i === 0) return t;
      t -= (is(t, n, r) - e) / i
   }
   return t
}
const Ci = 11,
   ii = 1 / (Ci - 1);

function ZS(e, t, n, r) {
   if (e === t && n === r) return cc;
   const o = new Float32Array(Ci);
   for (let s = 0; s < Ci; ++s) o[s] = is(s * ii, e, n);

   function i(s) {
      let l = 0,
         a = 1;
      const u = Ci - 1;
      for (; a !== u && o[a] <= s; ++a) l += ii;
      --a;
      const c = (s - o[a]) / (o[a + 1] - o[a]),
         f = l + c * ii,
         d = y0(f, e, n);
      return d >= KS ? XS(s, f, e, n) : d === 0 ? f : QS(s, l, l + ii, e, n)
   }
   return s => s === 0 || s === 1 ? s : is(i(s), t, r)
}

function JS({
   onTap: e,
   onTapStart: t,
   onTapCancel: n,
   whileTap: r,
   visualElement: o
}) {
   const i = e || t || n || r,
      s = C.exports.useRef(!1),
      l = C.exports.useRef(null),
      a = {
         passive: !(t || e || n || g)
      };

   function u() {
      l.current && l.current(), l.current = null
   }

   function c() {
      return u(), s.current = !1, o.animationState && o.animationState.setActive(ee.Tap, !1), !Zm()
   }

   function f(v, w) {
      !c() || (Jm(o.current, v.target) ? e && e(v, w) : n && n(v, w))
   }

   function d(v, w) {
      !c() || n && n(v, w)
   }

   function g(v, w) {
      u(), !s.current && (s.current = !0, l.current = Bs(ir(window, "pointerup", f, a), ir(window, "pointercancel", d, a)), o.animationState && o.animationState.setActive(ee.Tap, !0), t && t(v, w))
   }
   es(o, "pointerdown", i ? g : void 0, a), lc(u)
}
const qS = "production",
   w0 = typeof process == "undefined" || process.env === void 0 ? qS : "production",
   od = new Set;

function S0(e, t, n) {
   e || od.has(t) || (console.warn(t), n && console.warn(n), od.add(t))
}
const Ua = new WeakMap,
   _l = new WeakMap,
   ex = e => {
      const t = Ua.get(e.target);
      t && t(e)
   },
   tx = e => {
      e.forEach(ex)
   };

function nx({
   root: e,
   ...t
}) {
   const n = e || document;
   _l.has(n) || _l.set(n, {});
   const r = _l.get(n),
      o = JSON.stringify(t);
   return r[o] || (r[o] = new IntersectionObserver(tx, {
      root: e,
      ...t
   })), r[o]
}

function rx(e, t, n) {
   const r = nx(t);
   return Ua.set(e, n), r.observe(e), () => {
      Ua.delete(e), r.unobserve(e)
   }
}

function ox({
   visualElement: e,
   whileInView: t,
   onViewportEnter: n,
   onViewportLeave: r,
   viewport: o = {}
}) {
   const i = C.exports.useRef({
      hasEnteredView: !1,
      isInView: !1
   });
   let s = Boolean(t || n || r);
   o.once && i.current.hasEnteredView && (s = !1), (typeof IntersectionObserver == "undefined" ? lx : sx)(s, i.current, e, o)
}
const ix = {
   some: 0,
   all: 1
};

function sx(e, t, n, {
   root: r,
   margin: o,
   amount: i = "some",
   once: s
}) {
   C.exports.useEffect(() => {
      if (!e || !n.current) return;
      const l = {
            root: r == null ? void 0 : r.current,
            rootMargin: o,
            threshold: typeof i == "number" ? i : ix[i]
         },
         a = u => {
            const {
               isIntersecting: c
            } = u;
            if (t.isInView === c || (t.isInView = c, s && !c && t.hasEnteredView)) return;
            c && (t.hasEnteredView = !0), n.animationState && n.animationState.setActive(ee.InView, c);
            const f = n.getProps(),
               d = c ? f.onViewportEnter : f.onViewportLeave;
            d && d(u)
         };
      return rx(n.current, l, a)
   }, [e, r, o, i])
}

function lx(e, t, n, {
   fallback: r = !0
}) {
   C.exports.useEffect(() => {
      !e || !r || (w0 !== "production" && S0(!1, "IntersectionObserver not available on this device. whileInView animations will trigger on mount."), requestAnimationFrame(() => {
         t.hasEnteredView = !0;
         const {
            onViewportEnter: o
         } = n.getProps();
         o && o(null), n.animationState && n.animationState.setActive(ee.InView, !0)
      }))
   }, [e])
}
const Jt = e => t => (e(t), null),
   ax = {
      inView: Jt(ox),
      tap: Jt(JS),
      focus: Jt(jw),
      hover: Jt(Xw)
   };

function x0() {
   const e = C.exports.useContext(Mo);
   if (e === null) return [!0, null];
   const {
      isPresent: t,
      onExitComplete: n,
      register: r
   } = e, o = C.exports.useId();
   return C.exports.useEffect(() => r(o), []), !t && n ? [!1, () => n && n(o)] : [!0]
}

function k0(e, t) {
   if (!Array.isArray(t)) return !1;
   const n = t.length;
   if (n !== e.length) return !1;
   for (let r = 0; r < n; r++)
      if (t[r] !== e[r]) return !1;
   return !0
}
const ss = e => e * 1e3,
   ux = {
      linear: cc,
      easeIn: fc,
      easeInOut: l0,
      easeOut: xS,
      circIn: a0,
      circInOut: kS,
      circOut: dc,
      backIn: pc,
      backInOut: PS,
      backOut: CS,
      anticipate: ES,
      bounceIn: RS,
      bounceInOut: VS,
      bounceOut: rs
   },
   id = e => {
      if (Array.isArray(e)) {
         ts(e.length === 4);
         const [t, n, r, o] = e;
         return ZS(t, n, r, o)
      } else if (typeof e == "string") return ux[e];
      return e
   },
   cx = e => Array.isArray(e) && typeof e[0] != "number",
   sd = (e, t) => e === "zIndex" ? !1 : !!(typeof t == "number" || Array.isArray(t) || typeof t == "string" && $t.test(t) && !t.startsWith("url(")),
   mn = () => ({
      type: "spring",
      stiffness: 500,
      damping: 25,
      restSpeed: 10
   }),
   si = e => ({
      type: "spring",
      stiffness: 550,
      damping: e === 0 ? 2 * Math.sqrt(550) : 30,
      restSpeed: 10
   }),
   Al = () => ({
      type: "keyframes",
      ease: "linear",
      duration: .3
   }),
   fx = e => ({
      type: "keyframes",
      duration: .8,
      values: e
   }),
   ld = {
      x: mn,
      y: mn,
      z: mn,
      rotate: mn,
      rotateX: mn,
      rotateY: mn,
      rotateZ: mn,
      scaleX: si,
      scaleY: si,
      scale: si,
      opacity: Al,
      backgroundColor: Al,
      color: Al,
      default: si
   },
   dx = (e, t) => {
      let n;
      return Co(t) ? n = fx : n = ld[e] || ld.default, {
         to: t,
         ...n(t)
      }
   },
   px = {
      ...Dm,
      color: ze,
      backgroundColor: ze,
      outlineColor: ze,
      fill: ze,
      stroke: ze,
      borderColor: ze,
      borderTopColor: ze,
      borderRightColor: ze,
      borderBottomColor: ze,
      borderLeftColor: ze,
      filter: Da,
      WebkitFilter: Da
   },
   mc = e => px[e];

function gc(e, t) {
   var n;
   let r = mc(e);
   return r !== Da && (r = $t), (n = r.getAnimatableNone) === null || n === void 0 ? void 0 : n.call(r, t)
}
const hx = {
   current: !1
};

function C0(e, t) {
   const n = performance.now(),
      r = ({
         timestamp: o
      }) => {
         const i = o - n;
         i >= t && (fn.read(r), e(i - t))
      };
   return lt.read(r, !0), () => fn.read(r)
}

function mx({
   when: e,
   delay: t,
   delayChildren: n,
   staggerChildren: r,
   staggerDirection: o,
   repeat: i,
   repeatType: s,
   repeatDelay: l,
   from: a,
   ...u
}) {
   return !!Object.keys(u).length
}

function gx({
   ease: e,
   times: t,
   yoyo: n,
   flip: r,
   loop: o,
   ...i
}) {
   const s = {
      ...i
   };
   return t && (s.offset = t), i.duration && (s.duration = ss(i.duration)), i.repeatDelay && (s.repeatDelay = ss(i.repeatDelay)), e && (s.ease = cx(e) ? e.map(id) : id(e)), i.type === "tween" && (s.type = "keyframes"), (n || o || r) && (n ? s.repeatType = "reverse" : o ? s.repeatType = "loop" : r && (s.repeatType = "mirror"), s.repeat = o || n || r || i.repeat), i.type !== "spring" && (s.type = "keyframes"), s
}

function vx(e, t) {
   var n, r;
   return (r = (n = (vc(e, t) || {}).delay) !== null && n !== void 0 ? n : e.delay) !== null && r !== void 0 ? r : 0
}

function yx(e) {
   return Array.isArray(e.to) && e.to[0] === null && (e.to = [...e.to], e.to[0] = e.from), e
}

function wx(e, t, n) {
   return Array.isArray(t.to) && e.duration === void 0 && (e.duration = .8), yx(t), mx(e) || (e = {
      ...e,
      ...dx(n, t.to)
   }), {
      ...t,
      ...gx(e)
   }
}

function Sx(e, t, n, r, o) {
   const i = vc(r, e) || {};
   let s = i.from !== void 0 ? i.from : t.get();
   const l = sd(e, n);
   s === "none" && l && typeof n == "string" ? s = gc(e, n) : ad(s) && typeof n == "string" ? s = ud(n) : !Array.isArray(n) && ad(n) && typeof s == "string" && (n = ud(s));
   const a = sd(e, s);

   function u() {
      const f = {
         from: s,
         to: n,
         velocity: t.getVelocity(),
         onComplete: o,
         onUpdate: d => t.set(d)
      };
      return i.type === "inertia" || i.type === "decay" ? bS({
         ...f,
         ...i
      }) : p0({
         ...wx(i, f, e),
         onUpdate: d => {
            f.onUpdate(d), i.onUpdate && i.onUpdate(d)
         },
         onComplete: () => {
            f.onComplete(), i.onComplete && i.onComplete()
         }
      })
   }

   function c() {
      const f = Hm(n);
      return t.set(f), o(), i.onUpdate && i.onUpdate(f), i.onComplete && i.onComplete(), {
         stop: () => {}
      }
   }
   return !a || !l || i.type === !1 ? c : u
}

function ad(e) {
   return e === 0 || typeof e == "string" && parseFloat(e) === 0 && e.indexOf(" ") === -1
}

function ud(e) {
   return typeof e == "number" ? 0 : gc("", e)
}

function vc(e, t) {
   return e[t] || e.default || e
}

function yc(e, t, n, r = {}) {
   return hx.current && (r = {
      type: !1
   }), t.start(o => {
      let i;
      const s = Sx(e, t, n, r, o),
         l = vx(r, e),
         a = () => i = s();
      let u;
      return l ? u = C0(a, ss(l)) : a(), () => {
         u && u(), i && i.stop()
      }
   })
}
const xx = e => /^\-?\d*\.?\d+$/.test(e),
   kx = e => /^0[^.\s]+$/.test(e);

function wc(e, t) {
   e.indexOf(t) === -1 && e.push(t)
}

function Sc(e, t) {
   const n = e.indexOf(t);
   n > -1 && e.splice(n, 1)
}
class Xr {
   constructor() {
      this.subscriptions = []
   }
   add(t) {
      return wc(this.subscriptions, t), () => Sc(this.subscriptions, t)
   }
   notify(t, n, r) {
      const o = this.subscriptions.length;
      if (!!o)
         if (o === 1) this.subscriptions[0](t, n, r);
         else
            for (let i = 0; i < o; i++) {
               const s = this.subscriptions[i];
               s && s(t, n, r)
            }
   }
   getSize() {
      return this.subscriptions.length
   }
   clear() {
      this.subscriptions.length = 0
   }
}
const Cx = e => !isNaN(parseFloat(e));
class Px {
   constructor(t) {
      this.version = "7.6.5", this.timeDelta = 0, this.lastUpdated = 0, this.updateSubscribers = new Xr, this.velocityUpdateSubscribers = new Xr, this.renderSubscribers = new Xr, this.canTrackVelocity = !1, this.updateAndNotify = (n, r = !0) => {
         this.prev = this.current, this.current = n;
         const {
            delta: o,
            timestamp: i
         } = os();
         this.lastUpdated !== i && (this.timeDelta = o, this.lastUpdated = i, lt.postRender(this.scheduleVelocityCheck)), this.prev !== this.current && this.updateSubscribers.notify(this.current), this.velocityUpdateSubscribers.getSize() && this.velocityUpdateSubscribers.notify(this.getVelocity()), r && this.renderSubscribers.notify(this.current)
      }, this.scheduleVelocityCheck = () => lt.postRender(this.velocityCheck), this.velocityCheck = ({
         timestamp: n
      }) => {
         n !== this.lastUpdated && (this.prev = this.current, this.velocityUpdateSubscribers.notify(this.getVelocity()))
      }, this.hasAnimated = !1, this.prev = this.current = t, this.canTrackVelocity = Cx(this.current)
   }
   onChange(t) {
      return this.updateSubscribers.add(t)
   }
   clearListeners() {
      this.updateSubscribers.clear()
   }
   onRenderRequest(t) {
      return t(this.get()), this.renderSubscribers.add(t)
   }
   attach(t) {
      this.passiveEffect = t
   }
   set(t, n = !0) {
      !n || !this.passiveEffect ? this.updateAndNotify(t, n) : this.passiveEffect(t, this.updateAndNotify)
   }
   get() {
      return this.current
   }
   getPrevious() {
      return this.prev
   }
   getVelocity() {
      return this.canTrackVelocity ? h0(parseFloat(this.current) - parseFloat(this.prev), this.timeDelta) : 0
   }
   start(t) {
      return this.stop(), new Promise(n => {
         this.hasAnimated = !0, this.stopAnimation = t(n)
      }).then(() => this.clearAnimation())
   }
   stop() {
      this.stopAnimation && this.stopAnimation(), this.clearAnimation()
   }
   isAnimating() {
      return !!this.stopAnimation
   }
   clearAnimation() {
      this.stopAnimation = null
   }
   destroy() {
      this.updateSubscribers.clear(), this.renderSubscribers.clear(), this.stop()
   }
}

function gr(e) {
   return new Px(e)
}
const P0 = e => t => t.test(e),
   Ex = {
      test: e => e === "auto",
      parse: e => e
   },
   E0 = [Nn, N, _t, Ht, uw, aw, Ex],
   Vr = e => E0.find(P0(e)),
   Tx = [...E0, ze, $t],
   _x = e => Tx.find(P0(e));

function Ax(e) {
   const t = {};
   return e.values.forEach((n, r) => t[r] = n.get()), t
}

function Rx(e) {
   const t = {};
   return e.values.forEach((n, r) => t[r] = n.getVelocity()), t
}

function Ws(e, t, n) {
   const r = e.getProps();
   return ic(r, t, n !== void 0 ? n : r.custom, Ax(e), Rx(e))
}

function Vx(e, t, n) {
   e.hasValue(t) ? e.getValue(t).set(n) : e.addValue(t, gr(n))
}

function Lx(e, t) {
   const n = Ws(e, t);
   let {
      transitionEnd: r = {},
      transition: o = {},
      ...i
   } = n ? e.makeTargetAnimatable(n, !1) : {};
   i = {
      ...i,
      ...r
   };
   for (const s in i) {
      const l = Hm(i[s]);
      Vx(e, s, l)
   }
}

function Mx(e, t, n) {
   var r, o;
   const i = Object.keys(t).filter(l => !e.hasValue(l)),
      s = i.length;
   if (!!s)
      for (let l = 0; l < s; l++) {
         const a = i[l],
            u = t[a];
         let c = null;
         Array.isArray(u) && (c = u[0]), c === null && (c = (o = (r = n[a]) !== null && r !== void 0 ? r : e.readValue(a)) !== null && o !== void 0 ? o : t[a]), c != null && (typeof c == "string" && (xx(c) || kx(c)) ? c = parseFloat(c) : !_x(c) && $t.test(u) && (c = gc(a, u)), e.addValue(a, gr(c)), n[a] === void 0 && (n[a] = c), c !== null && e.setBaseTarget(a, c))
      }
}

function Ox(e, t) {
   return t ? (t[e] || t.default || t).from : void 0
}

function Dx(e, t, n) {
   var r;
   const o = {};
   for (const i in e) {
      const s = Ox(i, t);
      o[i] = s !== void 0 ? s : (r = n.getValue(i)) === null || r === void 0 ? void 0 : r.get()
   }
   return o
}

function ls(e) {
   return Boolean(wt(e) && e.add)
}

function Nx(e, t, n = {}) {
   e.notify("AnimationStart", t);
   let r;
   if (Array.isArray(t)) {
      const o = t.map(i => Ba(e, i, n));
      r = Promise.all(o)
   } else if (typeof t == "string") r = Ba(e, t, n);
   else {
      const o = typeof t == "function" ? Ws(e, t, n.custom) : t;
      r = T0(e, o, n)
   }
   return r.then(() => e.notify("AnimationComplete", t))
}

function Ba(e, t, n = {}) {
   var r;
   const o = Ws(e, t, n.custom);
   let {
      transition: i = e.getDefaultTransition() || {}
   } = o || {};
   n.transitionOverride && (i = n.transitionOverride);
   const s = o ? () => T0(e, o, n) : () => Promise.resolve(),
      l = !((r = e.variantChildren) === null || r === void 0) && r.size ? (u = 0) => {
         const {
            delayChildren: c = 0,
            staggerChildren: f,
            staggerDirection: d
         } = i;
         return Ix(e, t, c + u, f, d, n)
      } : () => Promise.resolve(),
      {
         when: a
      } = i;
   if (a) {
      const [u, c] = a === "beforeChildren" ? [s, l] : [l, s];
      return u().then(c)
   } else return Promise.all([s(), l(n.delay)])
}

function T0(e, t, {
   delay: n = 0,
   transitionOverride: r,
   type: o
} = {}) {
   var i;
   let {
      transition: s = e.getDefaultTransition(),
      transitionEnd: l,
      ...a
   } = e.makeTargetAnimatable(t);
   const u = e.getValue("willChange");
   r && (s = r);
   const c = [],
      f = o && ((i = e.animationState) === null || i === void 0 ? void 0 : i.getState()[o]);
   for (const d in a) {
      const g = e.getValue(d),
         v = a[d];
      if (!g || v === void 0 || f && Fx(f, d)) continue;
      let w = {
         delay: n,
         ...s
      };
      e.shouldReduceMotion && Oo.has(d) && (w = {
         ...w,
         type: !1,
         delay: 0
      });
      let k = yc(d, g, v, w);
      ls(u) && (u.add(d), k = k.then(() => u.remove(d))), c.push(k)
   }
   return Promise.all(c).then(() => {
      l && Lx(e, l)
   })
}

function Ix(e, t, n = 0, r = 0, o = 1, i) {
   const s = [],
      l = (e.variantChildren.size - 1) * r,
      a = o === 1 ? (u = 0) => u * r : (u = 0) => l - u * r;
   return Array.from(e.variantChildren).sort(zx).forEach((u, c) => {
      s.push(Ba(u, t, {
         ...i,
         delay: n + a(c)
      }).then(() => u.notify("AnimationComplete", t)))
   }), Promise.all(s)
}

function zx(e, t) {
   return e.sortNodePosition(t)
}

function Fx({
   protectedKeys: e,
   needsAnimating: t
}, n) {
   const r = e.hasOwnProperty(n) && t[n] !== !0;
   return t[n] = !1, r
}
const xc = [ee.Animate, ee.InView, ee.Focus, ee.Hover, ee.Tap, ee.Drag, ee.Exit],
   $x = [...xc].reverse(),
   jx = xc.length;

function Ux(e) {
   return t => Promise.all(t.map(({
      animation: n,
      options: r
   }) => Nx(e, n, r)))
}

function Bx(e) {
   let t = Ux(e);
   const n = bx();
   let r = !0;
   const o = (a, u) => {
      const c = Ws(e, u);
      if (c) {
         const {
            transition: f,
            transitionEnd: d,
            ...g
         } = c;
         a = {
            ...a,
            ...g,
            ...d
         }
      }
      return a
   };

   function i(a) {
      t = a(e)
   }

   function s(a, u) {
      var c;
      const f = e.getProps(),
         d = e.getVariantContext(!0) || {},
         g = [],
         v = new Set;
      let w = {},
         k = 1 / 0;
      for (let p = 0; p < jx; p++) {
         const h = $x[p],
            y = n[h],
            x = (c = f[h]) !== null && c !== void 0 ? c : d[h],
            E = So(x),
            T = h === u ? y.isActive : null;
         T === !1 && (k = p);
         let A = x === d[h] && x !== f[h] && E;
         if (A && r && e.manuallyAnimateOnMount && (A = !1), y.protectedKeys = {
               ...w
            }, !y.isActive && T === null || !x && !y.prevProp || Fs(x) || typeof x == "boolean") continue;
         const I = Hx(y.prevProp, x);
         let D = I || h === u && y.isActive && !A && E || p > k && E;
         const se = Array.isArray(x) ? x : [x];
         let J = se.reduce(o, {});
         T === !1 && (J = {});
         const {
            prevResolvedValues: fe = {}
         } = y, we = {
            ...fe,
            ...J
         }, le = ne => {
            D = !0, v.delete(ne), y.needsAnimating[ne] = !0
         };
         for (const ne in we) {
            const me = J[ne],
               _ = fe[ne];
            w.hasOwnProperty(ne) || (me !== _ ? Co(me) && Co(_) ? !k0(me, _) || I ? le(ne) : y.protectedKeys[ne] = !0 : me !== void 0 ? le(ne) : v.add(ne) : me !== void 0 && v.has(ne) ? le(ne) : y.protectedKeys[ne] = !0)
         }
         y.prevProp = x, y.prevResolvedValues = J, y.isActive && (w = {
            ...w,
            ...J
         }), r && e.blockInitialAnimation && (D = !1), D && !A && g.push(...se.map(ne => ({
            animation: ne,
            options: {
               type: h,
               ...a
            }
         })))
      }
      if (v.size) {
         const p = {};
         v.forEach(h => {
            const y = e.getBaseTarget(h);
            y !== void 0 && (p[h] = y)
         }), g.push({
            animation: p
         })
      }
      let m = Boolean(g.length);
      return r && f.initial === !1 && !e.manuallyAnimateOnMount && (m = !1), r = !1, m ? t(g) : Promise.resolve()
   }

   function l(a, u, c) {
      var f;
      if (n[a].isActive === u) return Promise.resolve();
      (f = e.variantChildren) === null || f === void 0 || f.forEach(g => {
         var v;
         return (v = g.animationState) === null || v === void 0 ? void 0 : v.setActive(a, u)
      }), n[a].isActive = u;
      const d = s(c, a);
      for (const g in n) n[g].protectedKeys = {};
      return d
   }
   return {
      animateChanges: s,
      setActive: l,
      setAnimateFunction: i,
      getState: () => n
   }
}

function Hx(e, t) {
   return typeof t == "string" ? t !== e : Array.isArray(t) ? !k0(t, e) : !1
}

function gn(e = !1) {
   return {
      isActive: e,
      protectedKeys: {},
      needsAnimating: {},
      prevResolvedValues: {}
   }
}

function bx() {
   return {
      [ee.Animate]: gn(!0),
      [ee.InView]: gn(),
      [ee.Hover]: gn(),
      [ee.Tap]: gn(),
      [ee.Drag]: gn(),
      [ee.Focus]: gn(),
      [ee.Exit]: gn()
   }
}
const Wx = {
   animation: Jt(({
      visualElement: e,
      animate: t
   }) => {
      e.animationState || (e.animationState = Bx(e)), Fs(t) && C.exports.useEffect(() => t.subscribe(e), [t])
   }),
   exit: Jt(e => {
      const {
         custom: t,
         visualElement: n
      } = e, [r, o] = x0(), i = C.exports.useContext(Mo);
      C.exports.useEffect(() => {
         n.isPresent = r;
         const s = n.animationState && n.animationState.setActive(ee.Exit, !r, {
            custom: i && i.custom || t
         });
         s && !r && s.then(o)
      }, [r])
   })
};
class _0 {
   constructor(t, n, {
      transformPagePoint: r
   } = {}) {
      if (this.startEvent = null, this.lastMoveEvent = null, this.lastMoveEventInfo = null, this.handlers = {}, this.updatePoint = () => {
            if (!(this.lastMoveEvent && this.lastMoveEventInfo)) return;
            const u = Vl(this.lastMoveEventInfo, this.history),
               c = this.startEvent !== null,
               f = hc(u.offset, {
                  x: 0,
                  y: 0
               }) >= 3;
            if (!c && !f) return;
            const {
               point: d
            } = u, {
               timestamp: g
            } = os();
            this.history.push({
               ...d,
               timestamp: g
            });
            const {
               onStart: v,
               onMove: w
            } = this.handlers;
            c || (v && v(this.lastMoveEvent, u), this.startEvent = this.lastMoveEvent), w && w(this.lastMoveEvent, u)
         }, this.handlePointerMove = (u, c) => {
            if (this.lastMoveEvent = u, this.lastMoveEventInfo = Rl(c, this.transformPagePoint), Wm(u) && u.buttons === 0) {
               this.handlePointerUp(u, c);
               return
            }
            lt.update(this.updatePoint, !0)
         }, this.handlePointerUp = (u, c) => {
            this.end();
            const {
               onEnd: f,
               onSessionEnd: d
            } = this.handlers, g = Vl(Rl(c, this.transformPagePoint), this.history);
            this.startEvent && f && f(u, g), d && d(u, g)
         }, Gm(t) && t.touches.length > 1) return;
      this.handlers = n, this.transformPagePoint = r;
      const o = sc(t),
         i = Rl(o, this.transformPagePoint),
         {
            point: s
         } = i,
         {
            timestamp: l
         } = os();
      this.history = [{
         ...s,
         timestamp: l
      }];
      const {
         onSessionStart: a
      } = n;
      a && a(t, Vl(i, this.history)), this.removeListeners = Bs(ir(window, "pointermove", this.handlePointerMove), ir(window, "pointerup", this.handlePointerUp), ir(window, "pointercancel", this.handlePointerUp))
   }
   updateHandlers(t) {
      this.handlers = t
   }
   end() {
      this.removeListeners && this.removeListeners(), fn.update(this.updatePoint)
   }
}

function Rl(e, t) {
   return t ? {
      point: t(e.point)
   } : e
}

function cd(e, t) {
   return {
      x: e.x - t.x,
      y: e.y - t.y
   }
}

function Vl({
   point: e
}, t) {
   return {
      point: e,
      delta: cd(e, A0(t)),
      offset: cd(e, Gx(t)),
      velocity: Qx(t, .1)
   }
}

function Gx(e) {
   return e[0]
}

function A0(e) {
   return e[e.length - 1]
}

function Qx(e, t) {
   if (e.length < 2) return {
      x: 0,
      y: 0
   };
   let n = e.length - 1,
      r = null;
   const o = A0(e);
   for (; n >= 0 && (r = e[n], !(o.timestamp - r.timestamp > ss(t)));) n--;
   if (!r) return {
      x: 0,
      y: 0
   };
   const i = (o.timestamp - r.timestamp) / 1e3;
   if (i === 0) return {
      x: 0,
      y: 0
   };
   const s = {
      x: (o.x - r.x) / i,
      y: (o.y - r.y) / i
   };
   return s.x === 1 / 0 && (s.x = 0), s.y === 1 / 0 && (s.y = 0), s
}

function qe(e) {
   return e.max - e.min
}

function fd(e, t = 0, n = .01) {
   return hc(e, t) < n
}

function dd(e, t, n, r = .5) {
   e.origin = r, e.originPoint = he(t.min, t.max, e.origin), e.scale = qe(n) / qe(t), (fd(e.scale, 1, 1e-4) || isNaN(e.scale)) && (e.scale = 1), e.translate = he(n.min, n.max, e.origin) - e.originPoint, (fd(e.translate) || isNaN(e.translate)) && (e.translate = 0)
}

function Zr(e, t, n, r) {
   dd(e.x, t.x, n.x, r == null ? void 0 : r.originX), dd(e.y, t.y, n.y, r == null ? void 0 : r.originY)
}

function pd(e, t, n) {
   e.min = n.min + t.min, e.max = e.min + qe(t)
}

function Yx(e, t, n) {
   pd(e.x, t.x, n.x), pd(e.y, t.y, n.y)
}

function hd(e, t, n) {
   e.min = t.min - n.min, e.max = e.min + qe(t)
}

function Jr(e, t, n) {
   hd(e.x, t.x, n.x), hd(e.y, t.y, n.y)
}

function Kx(e, {
   min: t,
   max: n
}, r) {
   return t !== void 0 && e < t ? e = r ? he(t, e, r.min) : Math.max(e, t) : n !== void 0 && e > n && (e = r ? he(n, e, r.max) : Math.min(e, n)), e
}

function md(e, t, n) {
   return {
      min: t !== void 0 ? e.min + t : void 0,
      max: n !== void 0 ? e.max + n - (e.max - e.min) : void 0
   }
}

function Xx(e, {
   top: t,
   left: n,
   bottom: r,
   right: o
}) {
   return {
      x: md(e.x, n, o),
      y: md(e.y, t, r)
   }
}

function gd(e, t) {
   let n = t.min - e.min,
      r = t.max - e.max;
   return t.max - t.min < e.max - e.min && ([n, r] = [r, n]), {
      min: n,
      max: r
   }
}

function Zx(e, t) {
   return {
      x: gd(e.x, t.x),
      y: gd(e.y, t.y)
   }
}

function Jx(e, t) {
   let n = .5;
   const r = qe(e),
      o = qe(t);
   return o > r ? n = Po(t.min, t.max - r, e.min) : r > o && (n = Po(e.min, e.max - o, t.min)), ns(0, 1, n)
}

function qx(e, t) {
   const n = {};
   return t.min !== void 0 && (n.min = t.min - e.min), t.max !== void 0 && (n.max = t.max - e.min), n
}
const Ha = .35;

function ek(e = Ha) {
   return e === !1 ? e = 0 : e === !0 && (e = Ha), {
      x: vd(e, "left", "right"),
      y: vd(e, "top", "bottom")
   }
}

function vd(e, t, n) {
   return {
      min: yd(e, t),
      max: yd(e, n)
   }
}

function yd(e, t) {
   var n;
   return typeof e == "number" ? e : (n = e[t]) !== null && n !== void 0 ? n : 0
}
const wd = () => ({
      translate: 0,
      scale: 1,
      origin: 0,
      originPoint: 0
   }),
   qr = () => ({
      x: wd(),
      y: wd()
   }),
   Sd = () => ({
      min: 0,
      max: 0
   }),
   Se = () => ({
      x: Sd(),
      y: Sd()
   });

function Ct(e) {
   return [e("x"), e("y")]
}

function R0({
   top: e,
   left: t,
   right: n,
   bottom: r
}) {
   return {
      x: {
         min: t,
         max: n
      },
      y: {
         min: e,
         max: r
      }
   }
}

function tk({
   x: e,
   y: t
}) {
   return {
      top: t.min,
      right: e.max,
      bottom: t.max,
      left: e.min
   }
}

function nk(e, t) {
   if (!t) return e;
   const n = t({
         x: e.left,
         y: e.top
      }),
      r = t({
         x: e.right,
         y: e.bottom
      });
   return {
      top: n.y,
      left: n.x,
      bottom: r.y,
      right: r.x
   }
}

function Ll(e) {
   return e === void 0 || e === 1
}

function ba({
   scale: e,
   scaleX: t,
   scaleY: n
}) {
   return !Ll(e) || !Ll(t) || !Ll(n)
}

function wn(e) {
   return ba(e) || V0(e) || e.z || e.rotate || e.rotateX || e.rotateY
}

function V0(e) {
   return xd(e.x) || xd(e.y)
}

function xd(e) {
   return e && e !== "0%"
}

function as(e, t, n) {
   const r = e - n,
      o = t * r;
   return n + o
}

function kd(e, t, n, r, o) {
   return o !== void 0 && (e = as(e, o, r)), as(e, n, r) + t
}

function Wa(e, t = 0, n = 1, r, o) {
   e.min = kd(e.min, t, n, r, o), e.max = kd(e.max, t, n, r, o)
}

function L0(e, {
   x: t,
   y: n
}) {
   Wa(e.x, t.translate, t.scale, t.originPoint), Wa(e.y, n.translate, n.scale, n.originPoint)
}

function rk(e, t, n, r = !1) {
   var o, i;
   const s = n.length;
   if (!s) return;
   t.x = t.y = 1;
   let l, a;
   for (let u = 0; u < s; u++) l = n[u], a = l.projectionDelta, ((i = (o = l.instance) === null || o === void 0 ? void 0 : o.style) === null || i === void 0 ? void 0 : i.display) !== "contents" && (r && l.options.layoutScroll && l.scroll && l !== l.root && Jn(e, {
      x: -l.scroll.x,
      y: -l.scroll.y
   }), a && (t.x *= a.x.scale, t.y *= a.y.scale, L0(e, a)), r && wn(l.latestValues) && Jn(e, l.latestValues))
}

function Gt(e, t) {
   e.min = e.min + t, e.max = e.max + t
}

function Cd(e, t, [n, r, o]) {
   const i = t[o] !== void 0 ? t[o] : .5,
      s = he(e.min, e.max, i);
   Wa(e, t[n], t[r], s, t.scale)
}
const ok = ["x", "scaleX", "originX"],
   ik = ["y", "scaleY", "originY"];

function Jn(e, t) {
   Cd(e.x, t, ok), Cd(e.y, t, ik)
}

function M0(e, t) {
   return R0(nk(e.getBoundingClientRect(), t))
}

function sk(e, t, n) {
   const r = M0(e, n),
      {
         scroll: o
      } = t;
   return o && (Gt(r.x, o.x), Gt(r.y, o.y)), r
}
const lk = new WeakMap;
class ak {
   constructor(t) {
      this.openGlobalLock = null, this.isDragging = !1, this.currentDirection = null, this.originPoint = {
         x: 0,
         y: 0
      }, this.constraints = !1, this.hasMutatedConstraints = !1, this.elastic = Se(), this.visualElement = t
   }
   start(t, {
      snapToCursor: n = !1
   } = {}) {
      if (this.visualElement.isPresent === !1) return;
      const r = l => {
            this.stopAnimation(), n && this.snapToCursor(sc(l, "page").point)
         },
         o = (l, a) => {
            var u;
            const {
               drag: c,
               dragPropagation: f,
               onDragStart: d
            } = this.getProps();
            c && !f && (this.openGlobalLock && this.openGlobalLock(), this.openGlobalLock = Xm(c), !this.openGlobalLock) || (this.isDragging = !0, this.currentDirection = null, this.resolveConstraints(), this.visualElement.projection && (this.visualElement.projection.isAnimationBlocked = !0, this.visualElement.projection.target = void 0), Ct(g => {
               var v, w;
               let k = this.getAxisMotionValue(g).get() || 0;
               if (_t.test(k)) {
                  const m = (w = (v = this.visualElement.projection) === null || v === void 0 ? void 0 : v.layout) === null || w === void 0 ? void 0 : w.actual[g];
                  m && (k = qe(m) * (parseFloat(k) / 100))
               }
               this.originPoint[g] = k
            }), d == null || d(l, a), (u = this.visualElement.animationState) === null || u === void 0 || u.setActive(ee.Drag, !0))
         },
         i = (l, a) => {
            const {
               dragPropagation: u,
               dragDirectionLock: c,
               onDirectionLock: f,
               onDrag: d
            } = this.getProps();
            if (!u && !this.openGlobalLock) return;
            const {
               offset: g
            } = a;
            if (c && this.currentDirection === null) {
               this.currentDirection = uk(g), this.currentDirection !== null && (f == null || f(this.currentDirection));
               return
            }
            this.updateAxis("x", a.point, g), this.updateAxis("y", a.point, g), this.visualElement.render(), d == null || d(l, a)
         },
         s = (l, a) => this.stop(l, a);
      this.panSession = new _0(t, {
         onSessionStart: r,
         onStart: o,
         onMove: i,
         onSessionEnd: s
      }, {
         transformPagePoint: this.visualElement.getTransformPagePoint()
      })
   }
   stop(t, n) {
      const r = this.isDragging;
      if (this.cancel(), !r) return;
      const {
         velocity: o
      } = n;
      this.startAnimation(o);
      const {
         onDragEnd: i
      } = this.getProps();
      i == null || i(t, n)
   }
   cancel() {
      var t, n;
      this.isDragging = !1, this.visualElement.projection && (this.visualElement.projection.isAnimationBlocked = !1), (t = this.panSession) === null || t === void 0 || t.end(), this.panSession = void 0;
      const {
         dragPropagation: r
      } = this.getProps();
      !r && this.openGlobalLock && (this.openGlobalLock(), this.openGlobalLock = null), (n = this.visualElement.animationState) === null || n === void 0 || n.setActive(ee.Drag, !1)
   }
   updateAxis(t, n, r) {
      const {
         drag: o
      } = this.getProps();
      if (!r || !li(t, o, this.currentDirection)) return;
      const i = this.getAxisMotionValue(t);
      let s = this.originPoint[t] + r[t];
      this.constraints && this.constraints[t] && (s = Kx(s, this.constraints[t], this.elastic[t])), i.set(s)
   }
   resolveConstraints() {
      const {
         dragConstraints: t,
         dragElastic: n
      } = this.getProps(), {
         layout: r
      } = this.visualElement.projection || {}, o = this.constraints;
      t && Zn(t) ? this.constraints || (this.constraints = this.resolveRefConstraints()) : t && r ? this.constraints = Xx(r.actual, t) : this.constraints = !1, this.elastic = ek(n), o !== this.constraints && r && this.constraints && !this.hasMutatedConstraints && Ct(i => {
         this.getAxisMotionValue(i) && (this.constraints[i] = qx(r.actual[i], this.constraints[i]))
      })
   }
   resolveRefConstraints() {
      const {
         dragConstraints: t,
         onMeasureDragConstraints: n
      } = this.getProps();
      if (!t || !Zn(t)) return !1;
      const r = t.current,
         {
            projection: o
         } = this.visualElement;
      if (!o || !o.layout) return !1;
      const i = sk(r, o.root, this.visualElement.getTransformPagePoint());
      let s = Zx(o.layout.actual, i);
      if (n) {
         const l = n(tk(s));
         this.hasMutatedConstraints = !!l, l && (s = R0(l))
      }
      return s
   }
   startAnimation(t) {
      const {
         drag: n,
         dragMomentum: r,
         dragElastic: o,
         dragTransition: i,
         dragSnapToOrigin: s,
         onDragTransitionEnd: l
      } = this.getProps(), a = this.constraints || {}, u = Ct(c => {
         var f;
         if (!li(c, n, this.currentDirection)) return;
         let d = (f = a == null ? void 0 : a[c]) !== null && f !== void 0 ? f : {};
         s && (d = {
            min: 0,
            max: 0
         });
         const g = o ? 200 : 1e6,
            v = o ? 40 : 1e7,
            w = {
               type: "inertia",
               velocity: r ? t[c] : 0,
               bounceStiffness: g,
               bounceDamping: v,
               timeConstant: 750,
               restDelta: 1,
               restSpeed: 10,
               ...i,
               ...d
            };
         return this.startAxisValueAnimation(c, w)
      });
      return Promise.all(u).then(l)
   }
   startAxisValueAnimation(t, n) {
      const r = this.getAxisMotionValue(t);
      return yc(t, r, 0, n)
   }
   stopAnimation() {
      Ct(t => this.getAxisMotionValue(t).stop())
   }
   getAxisMotionValue(t) {
      var n, r;
      const o = "_drag" + t.toUpperCase(),
         i = this.visualElement.getProps()[o];
      return i || this.visualElement.getValue(t, (r = (n = this.visualElement.getProps().initial) === null || n === void 0 ? void 0 : n[t]) !== null && r !== void 0 ? r : 0)
   }
   snapToCursor(t) {
      Ct(n => {
         const {
            drag: r
         } = this.getProps();
         if (!li(n, r, this.currentDirection)) return;
         const {
            projection: o
         } = this.visualElement, i = this.getAxisMotionValue(n);
         if (o && o.layout) {
            const {
               min: s,
               max: l
            } = o.layout.actual[n];
            i.set(t[n] - he(s, l, .5))
         }
      })
   }
   scalePositionWithinConstraints() {
      var t;
      if (!this.visualElement.current) return;
      const {
         drag: n,
         dragConstraints: r
      } = this.getProps(), {
         projection: o
      } = this.visualElement;
      if (!Zn(r) || !o || !this.constraints) return;
      this.stopAnimation();
      const i = {
         x: 0,
         y: 0
      };
      Ct(l => {
         const a = this.getAxisMotionValue(l);
         if (a) {
            const u = a.get();
            i[l] = Jx({
               min: u,
               max: u
            }, this.constraints[l])
         }
      });
      const {
         transformTemplate: s
      } = this.visualElement.getProps();
      this.visualElement.current.style.transform = s ? s({}, "") : "none", (t = o.root) === null || t === void 0 || t.updateScroll(), o.updateLayout(), this.resolveConstraints(), Ct(l => {
         if (!li(l, n, null)) return;
         const a = this.getAxisMotionValue(l),
            {
               min: u,
               max: c
            } = this.constraints[l];
         a.set(he(u, c, i[l]))
      })
   }
   addListeners() {
      var t;
      if (!this.visualElement.current) return;
      lk.set(this.visualElement, this);
      const n = this.visualElement.current,
         r = ir(n, "pointerdown", u => {
            const {
               drag: c,
               dragListener: f = !0
            } = this.getProps();
            c && f && this.start(u)
         }),
         o = () => {
            const {
               dragConstraints: u
            } = this.getProps();
            Zn(u) && (this.constraints = this.resolveRefConstraints())
         },
         {
            projection: i
         } = this.visualElement,
         s = i.addEventListener("measure", o);
      i && !i.layout && ((t = i.root) === null || t === void 0 || t.updateScroll(), i.updateLayout()), o();
      const l = Us(window, "resize", () => this.scalePositionWithinConstraints()),
         a = i.addEventListener("didUpdate", ({
            delta: u,
            hasLayoutChanged: c
         }) => {
            this.isDragging && c && (Ct(f => {
               const d = this.getAxisMotionValue(f);
               !d || (this.originPoint[f] += u[f].translate, d.set(d.get() + u[f].translate))
            }), this.visualElement.render())
         });
      return () => {
         l(), r(), s(), a == null || a()
      }
   }
   getProps() {
      const t = this.visualElement.getProps(),
         {
            drag: n = !1,
            dragDirectionLock: r = !1,
            dragPropagation: o = !1,
            dragConstraints: i = !1,
            dragElastic: s = Ha,
            dragMomentum: l = !0
         } = t;
      return {
         ...t,
         drag: n,
         dragDirectionLock: r,
         dragPropagation: o,
         dragConstraints: i,
         dragElastic: s,
         dragMomentum: l
      }
   }
}

function li(e, t, n) {
   return (t === !0 || t === e) && (n === null || n === e)
}

function uk(e, t = 10) {
   let n = null;
   return Math.abs(e.y) > t ? n = "y" : Math.abs(e.x) > t && (n = "x"), n
}

function ck(e) {
   const {
      dragControls: t,
      visualElement: n
   } = e, r = js(() => new ak(n));
   C.exports.useEffect(() => t && t.subscribe(r), [r, t]), C.exports.useEffect(() => r.addListeners(), [r])
}

function fk({
   onPan: e,
   onPanStart: t,
   onPanEnd: n,
   onPanSessionStart: r,
   visualElement: o
}) {
   const i = e || t || n || r,
      s = C.exports.useRef(null),
      {
         transformPagePoint: l
      } = C.exports.useContext(Zu),
      a = {
         onSessionStart: r,
         onStart: t,
         onMove: e,
         onEnd: (c, f) => {
            s.current = null, n && n(c, f)
         }
      };
   C.exports.useEffect(() => {
      s.current !== null && s.current.updateHandlers(a)
   });

   function u(c) {
      s.current = new _0(c, a, {
         transformPagePoint: l
      })
   }
   es(o, "pointerdown", i && u), lc(() => s.current && s.current.end())
}
const dk = {
   pan: Jt(fk),
   drag: Jt(ck)
};

function Ga(e) {
   return typeof e == "string" && e.startsWith("var(--")
}
const O0 = /var\((--[a-zA-Z0-9-_]+),? ?([a-zA-Z0-9 ()%#.,-]+)?\)/;

function pk(e) {
   const t = O0.exec(e);
   if (!t) return [, ];
   const [, n, r] = t;
   return [n, r]
}

function Qa(e, t, n = 1) {
   const [r, o] = pk(e);
   if (!r) return;
   const i = window.getComputedStyle(t).getPropertyValue(r);
   return i ? i.trim() : Ga(o) ? Qa(o, t, n + 1) : o
}

function hk(e, {
   ...t
}, n) {
   const r = e.current;
   if (!(r instanceof Element)) return {
      target: t,
      transitionEnd: n
   };
   n && (n = {
      ...n
   }), e.values.forEach(o => {
      const i = o.get();
      if (!Ga(i)) return;
      const s = Qa(i, r);
      s && o.set(s)
   });
   for (const o in t) {
      const i = t[o];
      if (!Ga(i)) continue;
      const s = Qa(i, r);
      !s || (t[o] = s, n && n[o] === void 0 && (n[o] = i))
   }
   return {
      target: t,
      transitionEnd: n
   }
}
const mk = new Set(["width", "height", "top", "left", "right", "bottom", "x", "y"]),
   D0 = e => mk.has(e),
   gk = e => Object.keys(e).some(D0),
   N0 = (e, t) => {
      e.set(t, !1), e.set(t)
   },
   Pd = e => e === Nn || e === N;
var Ed;
(function (e) {
   e.width = "width", e.height = "height", e.left = "left", e.right = "right", e.top = "top", e.bottom = "bottom"
})(Ed || (Ed = {}));
const Td = (e, t) => parseFloat(e.split(", ")[t]),
   _d = (e, t) => (n, {
      transform: r
   }) => {
      if (r === "none" || !r) return 0;
      const o = r.match(/^matrix3d\((.+)\)$/);
      if (o) return Td(o[1], t); {
         const i = r.match(/^matrix\((.+)\)$/);
         return i ? Td(i[1], e) : 0
      }
   },
   vk = new Set(["x", "y", "z"]),
   yk = Ji.filter(e => !vk.has(e));

function wk(e) {
   const t = [];
   return yk.forEach(n => {
      const r = e.getValue(n);
      r !== void 0 && (t.push([n, r.get()]), r.set(n.startsWith("scale") ? 1 : 0))
   }), t.length && e.render(), t
}
const Ad = {
      width: ({
         x: e
      }, {
         paddingLeft: t = "0",
         paddingRight: n = "0"
      }) => e.max - e.min - parseFloat(t) - parseFloat(n),
      height: ({
         y: e
      }, {
         paddingTop: t = "0",
         paddingBottom: n = "0"
      }) => e.max - e.min - parseFloat(t) - parseFloat(n),
      top: (e, {
         top: t
      }) => parseFloat(t),
      left: (e, {
         left: t
      }) => parseFloat(t),
      bottom: ({
         y: e
      }, {
         top: t
      }) => parseFloat(t) + (e.max - e.min),
      right: ({
         x: e
      }, {
         left: t
      }) => parseFloat(t) + (e.max - e.min),
      x: _d(4, 13),
      y: _d(5, 14)
   },
   Sk = (e, t, n) => {
      const r = t.measureViewportBox(),
         o = t.current,
         i = getComputedStyle(o),
         {
            display: s
         } = i,
         l = {};
      s === "none" && t.setStaticValue("display", e.display || "block"), n.forEach(u => {
         l[u] = Ad[u](r, i)
      }), t.render();
      const a = t.measureViewportBox();
      return n.forEach(u => {
         const c = t.getValue(u);
         N0(c, l[u]), e[u] = Ad[u](a, i)
      }), e
   },
   xk = (e, t, n = {}, r = {}) => {
      t = {
         ...t
      }, r = {
         ...r
      };
      const o = Object.keys(t).filter(D0);
      let i = [],
         s = !1;
      const l = [];
      if (o.forEach(a => {
            const u = e.getValue(a);
            if (!e.hasValue(a)) return;
            let c = n[a],
               f = Vr(c);
            const d = t[a];
            let g;
            if (Co(d)) {
               const v = d.length,
                  w = d[0] === null ? 1 : 0;
               c = d[w], f = Vr(c);
               for (let k = w; k < v; k++) g ? ts(Vr(d[k]) === g) : g = Vr(d[k])
            } else g = Vr(d);
            if (f !== g)
               if (Pd(f) && Pd(g)) {
                  const v = u.get();
                  typeof v == "string" && u.set(parseFloat(v)), typeof d == "string" ? t[a] = parseFloat(d) : Array.isArray(d) && g === N && (t[a] = d.map(parseFloat))
               } else(f == null ? void 0 : f.transform) && (g == null ? void 0 : g.transform) && (c === 0 || d === 0) ? c === 0 ? u.set(g.transform(c)) : t[a] = f.transform(d) : (s || (i = wk(e), s = !0), l.push(a), r[a] = r[a] !== void 0 ? r[a] : t[a], N0(u, d))
         }), l.length) {
         const a = l.indexOf("height") >= 0 ? window.pageYOffset : null,
            u = Sk(t, e, l);
         return i.length && i.forEach(([c, f]) => {
            e.getValue(c).set(f)
         }), e.render(), Dn && a !== null && window.scrollTo({
            top: a
         }), {
            target: u,
            transitionEnd: r
         }
      } else return {
         target: t,
         transitionEnd: r
      }
   };

function kk(e, t, n, r) {
   return gk(t) ? xk(e, t, n, r) : {
      target: t,
      transitionEnd: r
   }
}
const Ck = (e, t, n, r) => {
      const o = hk(e, t, r);
      return t = o.target, r = o.transitionEnd, kk(e, t, n, r)
   },
   Ya = {
      current: null
   },
   I0 = {
      current: !1
   };

function Pk() {
   if (I0.current = !0, !!Dn)
      if (window.matchMedia) {
         const e = window.matchMedia("(prefers-reduced-motion)"),
            t = () => Ya.current = e.matches;
         e.addListener(t), t()
      } else Ya.current = !1
}

function Ek(e, t, n) {
   const {
      willChange: r
   } = t;
   for (const o in t) {
      const i = t[o],
         s = n[o];
      if (wt(i)) e.addValue(o, i), ls(r) && r.add(o);
      else if (wt(s)) e.addValue(o, gr(i)), ls(r) && r.remove(o);
      else if (s !== i)
         if (e.hasValue(o)) {
            const l = e.getValue(o);
            !l.hasAnimated && l.set(i)
         } else {
            const l = e.getStaticValue(o);
            e.addValue(o, gr(l !== void 0 ? l : i))
         }
   }
   for (const o in n) t[o] === void 0 && e.removeValue(o);
   return t
}
const z0 = Object.keys(xo),
   Tk = z0.length,
   Rd = ["AnimationStart", "AnimationComplete", "Update", "Unmount", "BeforeLayoutMeasure", "LayoutMeasure", "LayoutAnimationStart", "LayoutAnimationComplete"];
class _k {
   constructor({
      parent: t,
      props: n,
      reducedMotionConfig: r,
      visualState: o
   }, i = {}) {
      this.current = null, this.children = new Set, this.isVariantNode = !1, this.isControllingVariants = !1, this.shouldReduceMotion = null, this.values = new Map, this.isPresent = !0, this.valueSubscriptions = new Map, this.prevMotionValues = {}, this.events = {}, this.propEventSubscriptions = {}, this.notifyUpdate = () => this.notify("Update", this.latestValues), this.render = () => {
         !this.current || (this.triggerBuild(), this.renderInstance(this.current, this.renderState, this.props.style, this.projection))
      }, this.scheduleRender = () => lt.render(this.render, !1, !0);
      const {
         latestValues: s,
         renderState: l
      } = o;
      this.latestValues = s, this.baseTarget = {
         ...s
      }, this.initialValues = n.initial ? {
         ...s
      } : {}, this.renderState = l, this.parent = t, this.props = n, this.depth = t ? t.depth + 1 : 0, this.reducedMotionConfig = r, this.options = i, this.isControllingVariants = $s(n), this.isVariantNode = Cm(n), this.isVariantNode && (this.variantChildren = new Set), this.manuallyAnimateOnMount = Boolean(t && t.current);
      const {
         willChange: a,
         ...u
      } = this.scrapeMotionValuesFromProps(n);
      for (const c in u) {
         const f = u[c];
         s[c] !== void 0 && wt(f) && (f.set(s[c], !1), ls(a) && a.add(c))
      }
      if (n.values)
         for (const c in n.values) {
            const f = n.values[c];
            s[c] !== void 0 && wt(f) && f.set(s[c])
         }
   }
   scrapeMotionValuesFromProps(t) {
      return {}
   }
   mount(t) {
      var n;
      this.current = t, this.projection && this.projection.mount(t), this.parent && this.isVariantNode && !this.isControllingVariants && (this.removeFromVariantTree = (n = this.parent) === null || n === void 0 ? void 0 : n.addVariantChild(this)), this.values.forEach((r, o) => this.bindToMotionValue(o, r)), I0.current || Pk(), this.shouldReduceMotion = this.reducedMotionConfig === "never" ? !1 : this.reducedMotionConfig === "always" ? !0 : Ya.current, this.parent && this.parent.children.add(this), this.setProps(this.props)
   }
   unmount() {
      var t, n, r;
      (t = this.projection) === null || t === void 0 || t.unmount(), fn.update(this.notifyUpdate), fn.render(this.render), this.valueSubscriptions.forEach(o => o()), (n = this.removeFromVariantTree) === null || n === void 0 || n.call(this), (r = this.parent) === null || r === void 0 || r.children.delete(this);
      for (const o in this.events) this.events[o].clear();
      this.current = null
   }
   bindToMotionValue(t, n) {
      const r = n.onChange(i => {
            this.latestValues[t] = i, this.props.onUpdate && lt.update(this.notifyUpdate, !1, !0)
         }),
         o = n.onRenderRequest(this.scheduleRender);
      this.valueSubscriptions.set(t, () => {
         r(), o()
      })
   }
   sortNodePosition(t) {
      return !this.current || !this.sortInstanceNodePosition || this.type !== t.type ? 0 : this.sortInstanceNodePosition(this.current, t.current)
   }
   loadFeatures(t, n, r, o, i, s) {
      const l = [];
      for (let a = 0; a < Tk; a++) {
         const u = z0[a],
            {
               isEnabled: c,
               Component: f
            } = xo[u];
         c(t) && f && l.push(C.exports.createElement(f, {
            key: u,
            ...t,
            visualElement: this
         }))
      }
      if (!this.projection && i) {
         this.projection = new i(o, this.latestValues, this.parent && this.parent.projection);
         const {
            layoutId: a,
            layout: u,
            drag: c,
            dragConstraints: f,
            layoutScroll: d
         } = t;
         this.projection.setOptions({
            layoutId: a,
            layout: u,
            alwaysMeasureLayout: Boolean(c) || f && Zn(f),
            visualElement: this,
            scheduleRender: () => this.scheduleRender(),
            animationType: typeof u == "string" ? u : "both",
            initialPromotionConfig: s,
            layoutScroll: d
         })
      }
      return l
   }
   triggerBuild() {
      this.build(this.renderState, this.latestValues, this.options, this.props)
   }
   measureViewportBox() {
      return this.current ? this.measureInstanceViewportBox(this.current, this.props) : Se()
   }
   getStaticValue(t) {
      return this.latestValues[t]
   }
   setStaticValue(t, n) {
      this.latestValues[t] = n
   }
   makeTargetAnimatable(t, n = !0) {
      return this.makeTargetAnimatableFromInstance(t, this.props, n)
   }
   setProps(t) {
      (t.transformTemplate || this.props.transformTemplate) && this.scheduleRender(), this.props = t;
      for (let n = 0; n < Rd.length; n++) {
         const r = Rd[n];
         this.propEventSubscriptions[r] && (this.propEventSubscriptions[r](), delete this.propEventSubscriptions[r]);
         const o = t["on" + r];
         o && (this.propEventSubscriptions[r] = this.on(r, o))
      }
      this.prevMotionValues = Ek(this, this.scrapeMotionValuesFromProps(t), this.prevMotionValues)
   }
   getProps() {
      return this.props
   }
   getVariant(t) {
      var n;
      return (n = this.props.variants) === null || n === void 0 ? void 0 : n[t]
   }
   getDefaultTransition() {
      return this.props.transition
   }
   getTransformPagePoint() {
      return this.props.transformPagePoint
   }
   getClosestVariantNode() {
      var t;
      return this.isVariantNode ? this : (t = this.parent) === null || t === void 0 ? void 0 : t.getClosestVariantNode()
   }
   getVariantContext(t = !1) {
      var n, r;
      if (t) return (n = this.parent) === null || n === void 0 ? void 0 : n.getVariantContext();
      if (!this.isControllingVariants) {
         const i = ((r = this.parent) === null || r === void 0 ? void 0 : r.getVariantContext()) || {};
         return this.props.initial !== void 0 && (i.initial = this.props.initial), i
      }
      const o = {};
      for (let i = 0; i < Ak; i++) {
         const s = F0[i],
            l = this.props[s];
         (So(l) || l === !1) && (o[s] = l)
      }
      return o
   }
   addVariantChild(t) {
      var n;
      const r = this.getClosestVariantNode();
      if (r) return (n = r.variantChildren) === null || n === void 0 || n.add(t), () => r.variantChildren.delete(t)
   }
   addValue(t, n) {
      this.hasValue(t) && this.removeValue(t), this.values.set(t, n), this.latestValues[t] = n.get(), this.bindToMotionValue(t, n)
   }
   removeValue(t) {
      var n;
      this.values.delete(t), (n = this.valueSubscriptions.get(t)) === null || n === void 0 || n(), this.valueSubscriptions.delete(t), delete this.latestValues[t], this.removeValueFromRenderState(t, this.renderState)
   }
   hasValue(t) {
      return this.values.has(t)
   }
   getValue(t, n) {
      if (this.props.values && this.props.values[t]) return this.props.values[t];
      let r = this.values.get(t);
      return r === void 0 && n !== void 0 && (r = gr(n), this.addValue(t, r)), r
   }
   readValue(t) {
      return this.latestValues[t] !== void 0 || !this.current ? this.latestValues[t] : this.readValueFromInstance(this.current, t, this.options)
   }
   setBaseTarget(t, n) {
      this.baseTarget[t] = n
   }
   getBaseTarget(t) {
      var n;
      const {
         initial: r
      } = this.props, o = typeof r == "string" || typeof r == "object" ? (n = ic(this.props, r)) === null || n === void 0 ? void 0 : n[t] : void 0;
      if (r && o !== void 0) return o;
      const i = this.getBaseTargetFromProps(this.props, t);
      return i !== void 0 && !wt(i) ? i : this.initialValues[t] !== void 0 && o === void 0 ? void 0 : this.baseTarget[t]
   }
   on(t, n) {
      return this.events[t] || (this.events[t] = new Xr), this.events[t].add(n)
   }
   notify(t, ...n) {
      var r;
      (r = this.events[t]) === null || r === void 0 || r.notify(...n)
   }
}
const F0 = ["initial", ...xc],
   Ak = F0.length;
class $0 extends _k {
   sortInstanceNodePosition(t, n) {
      return t.compareDocumentPosition(n) & 2 ? 1 : -1
   }
   getBaseTargetFromProps(t, n) {
      var r;
      return (r = t.style) === null || r === void 0 ? void 0 : r[n]
   }
   removeValueFromRenderState(t, {
      vars: n,
      style: r
   }) {
      delete n[t], delete r[t]
   }
   makeTargetAnimatableFromInstance({
      transition: t,
      transitionEnd: n,
      ...r
   }, {
      transformValues: o
   }, i) {
      let s = Dx(r, t || {}, this);
      if (o && (n && (n = o(n)), r && (r = o(r)), s && (s = o(s))), i) {
         Mx(this, r, s);
         const l = Ck(this, r, s, n);
         n = l.transitionEnd, r = l.target
      }
      return {
         transition: t,
         transitionEnd: n,
         ...r
      }
   }
}

function Rk(e) {
   return window.getComputedStyle(e)
}
class Vk extends $0 {
   readValueFromInstance(t, n) {
      if (Oo.has(n)) {
         const r = mc(n);
         return r && r.default || 0
      } else {
         const r = Rk(t),
            o = (Tm(n) ? r.getPropertyValue(n) : r[n]) || 0;
         return typeof o == "string" ? o.trim() : o
      }
   }
   measureInstanceViewportBox(t, {
      transformPagePoint: n
   }) {
      return M0(t, n)
   }
   build(t, n, r, o) {
      tc(t, n, r, o.transformTemplate)
   }
   scrapeMotionValuesFromProps(t) {
      return oc(t)
   }
   renderInstance(t, n, r, o) {
      $m(t, n, r, o)
   }
}
class Lk extends $0 {
   getBaseTargetFromProps(t, n) {
      return t[n]
   }
   readValueFromInstance(t, n) {
      var r;
      return Oo.has(n) ? ((r = mc(n)) === null || r === void 0 ? void 0 : r.default) || 0 : (n = jm.has(n) ? n : Fm(n), t.getAttribute(n))
   }
   measureInstanceViewportBox() {
      return Se()
   }
   scrapeMotionValuesFromProps(t) {
      return Bm(t)
   }
   build(t, n, r, o) {
      rc(t, n, r, o.transformTemplate)
   }
   renderInstance(t, n, r, o) {
      Um(t, n, r, o)
   }
}
const Mk = (e, t) => qu(e) ? new Lk(t, {
   enableHardwareAcceleration: !1
}) : new Vk(t, {
   enableHardwareAcceleration: !0
});

function Vd(e, t) {
   return t.max === t.min ? 0 : e / (t.max - t.min) * 100
}
const Lr = {
      correct: (e, t) => {
         if (!t.target) return e;
         if (typeof e == "string")
            if (N.test(e)) e = parseFloat(e);
            else return e;
         const n = Vd(e, t.target.x),
            r = Vd(e, t.target.y);
         return `${n}% ${r}%`
      }
   },
   Ld = "_$css",
   Ok = {
      correct: (e, {
         treeScale: t,
         projectionDelta: n
      }) => {
         const r = e,
            o = e.includes("var("),
            i = [];
         o && (e = e.replace(O0, g => (i.push(g), Ld)));
         const s = $t.parse(e);
         if (s.length > 5) return r;
         const l = $t.createTransformer(e),
            a = typeof s[0] != "number" ? 1 : 0,
            u = n.x.scale * t.x,
            c = n.y.scale * t.y;
         s[0 + a] /= u, s[1 + a] /= c;
         const f = he(u, c, .5);
         typeof s[2 + a] == "number" && (s[2 + a] /= f), typeof s[3 + a] == "number" && (s[3 + a] /= f);
         let d = l(s);
         if (o) {
            let g = 0;
            d = d.replace(Ld, () => {
               const v = i[g];
               return g++, v
            })
         }
         return d
      }
   };
class Dk extends Ln.Component {
   componentDidMount() {
      const {
         visualElement: t,
         layoutGroup: n,
         switchLayoutGroup: r,
         layoutId: o
      } = this.props, {
         projection: i
      } = t;
      nw(Ik), i && (n.group && n.group.add(i), r && r.register && o && r.register(i), i.root.didUpdate(), i.addEventListener("animationComplete", () => {
         this.safeToRemove()
      }), i.setOptions({
         ...i.options,
         onExitComplete: () => this.safeToRemove()
      })), Qr.hasEverUpdated = !0
   }
   getSnapshotBeforeUpdate(t) {
      const {
         layoutDependency: n,
         visualElement: r,
         drag: o,
         isPresent: i
      } = this.props, s = r.projection;
      return s && (s.isPresent = i, o || t.layoutDependency !== n || n === void 0 ? s.willUpdate() : this.safeToRemove(), t.isPresent !== i && (i ? s.promote() : s.relegate() || lt.postRender(() => {
         var l;
         !((l = s.getStack()) === null || l === void 0) && l.members.length || this.safeToRemove()
      }))), null
   }
   componentDidUpdate() {
      const {
         projection: t
      } = this.props.visualElement;
      t && (t.root.didUpdate(), !t.currentAnimation && t.isLead() && this.safeToRemove())
   }
   componentWillUnmount() {
      const {
         visualElement: t,
         layoutGroup: n,
         switchLayoutGroup: r
      } = this.props, {
         projection: o
      } = t;
      o && (o.scheduleCheckAfterUnmount(), n != null && n.group && n.group.remove(o), r != null && r.deregister && r.deregister(o))
   }
   safeToRemove() {
      const {
         safeToRemove: t
      } = this.props;
      t == null || t()
   }
   render() {
      return null
   }
}

function Nk(e) {
   const [t, n] = x0(), r = C.exports.useContext(Ju);
   return B(Dk, {
      ...e,
      layoutGroup: r,
      switchLayoutGroup: C.exports.useContext(Pm),
      isPresent: t,
      safeToRemove: n
   })
}
const Ik = {
      borderRadius: {
         ...Lr,
         applyTo: ["borderTopLeftRadius", "borderTopRightRadius", "borderBottomLeftRadius", "borderBottomRightRadius"]
      },
      borderTopLeftRadius: Lr,
      borderTopRightRadius: Lr,
      borderBottomLeftRadius: Lr,
      borderBottomRightRadius: Lr,
      boxShadow: Ok
   },
   zk = {
      measureLayout: Nk
   };

function Fk(e, t, n = {}) {
   const r = wt(e) ? e : gr(e);
   return yc("", r, t, n), {
      stop: () => r.stop(),
      isAnimating: () => r.isAnimating()
   }
}
const j0 = ["TopLeft", "TopRight", "BottomLeft", "BottomRight"],
   $k = j0.length,
   Md = e => typeof e == "string" ? parseFloat(e) : e,
   Od = e => typeof e == "number" || N.test(e);

function jk(e, t, n, r, o, i) {
   var s, l, a, u;
   o ? (e.opacity = he(0, (s = n.opacity) !== null && s !== void 0 ? s : 1, Uk(r)), e.opacityExit = he((l = t.opacity) !== null && l !== void 0 ? l : 1, 0, Bk(r))) : i && (e.opacity = he((a = t.opacity) !== null && a !== void 0 ? a : 1, (u = n.opacity) !== null && u !== void 0 ? u : 1, r));
   for (let c = 0; c < $k; c++) {
      const f = `border${j0[c]}Radius`;
      let d = Dd(t, f),
         g = Dd(n, f);
      if (d === void 0 && g === void 0) continue;
      d || (d = 0), g || (g = 0), d === 0 || g === 0 || Od(d) === Od(g) ? (e[f] = Math.max(he(Md(d), Md(g), r), 0), (_t.test(g) || _t.test(d)) && (e[f] += "%")) : e[f] = g
   }(t.rotate || n.rotate) && (e.rotate = he(t.rotate || 0, n.rotate || 0, r))
}

function Dd(e, t) {
   var n;
   return (n = e[t]) !== null && n !== void 0 ? n : e.borderRadius
}
const Uk = U0(0, .5, dc),
   Bk = U0(.5, .95, cc);

function U0(e, t, n) {
   return r => r < e ? 0 : r > t ? 1 : n(Po(e, t, r))
}

function Nd(e, t) {
   e.min = t.min, e.max = t.max
}

function dt(e, t) {
   Nd(e.x, t.x), Nd(e.y, t.y)
}

function Id(e, t, n, r, o) {
   return e -= t, e = as(e, 1 / n, r), o !== void 0 && (e = as(e, 1 / o, r)), e
}

function Hk(e, t = 0, n = 1, r = .5, o, i = e, s = e) {
   if (_t.test(t) && (t = parseFloat(t), t = he(s.min, s.max, t / 100) - s.min), typeof t != "number") return;
   let l = he(i.min, i.max, r);
   e === i && (l -= t), e.min = Id(e.min, t, n, l, o), e.max = Id(e.max, t, n, l, o)
}

function zd(e, t, [n, r, o], i, s) {
   Hk(e, t[n], t[r], t[o], t.scale, i, s)
}
const bk = ["x", "scaleX", "originX"],
   Wk = ["y", "scaleY", "originY"];

function Fd(e, t, n, r) {
   zd(e.x, t, bk, n == null ? void 0 : n.x, r == null ? void 0 : r.x), zd(e.y, t, Wk, n == null ? void 0 : n.y, r == null ? void 0 : r.y)
}

function $d(e) {
   return e.translate === 0 && e.scale === 1
}

function B0(e) {
   return $d(e.x) && $d(e.y)
}

function H0(e, t) {
   return e.x.min === t.x.min && e.x.max === t.x.max && e.y.min === t.y.min && e.y.max === t.y.max
}

function jd(e) {
   return qe(e.x) / qe(e.y)
}

function Gk(e, t, n = .1) {
   return hc(e, t) <= n
}
class Qk {
   constructor() {
      this.members = []
   }
   add(t) {
      wc(this.members, t), t.scheduleRender()
   }
   remove(t) {
      if (Sc(this.members, t), t === this.prevLead && (this.prevLead = void 0), t === this.lead) {
         const n = this.members[this.members.length - 1];
         n && this.promote(n)
      }
   }
   relegate(t) {
      const n = this.members.findIndex(o => t === o);
      if (n === 0) return !1;
      let r;
      for (let o = n; o >= 0; o--) {
         const i = this.members[o];
         if (i.isPresent !== !1) {
            r = i;
            break
         }
      }
      return r ? (this.promote(r), !0) : !1
   }
   promote(t, n) {
      var r;
      const o = this.lead;
      if (t !== o && (this.prevLead = o, this.lead = t, t.show(), o)) {
         o.instance && o.scheduleRender(), t.scheduleRender(), t.resumeFrom = o, n && (t.resumeFrom.preserveOpacity = !0), o.snapshot && (t.snapshot = o.snapshot, t.snapshot.latestValues = o.animationValues || o.latestValues, t.snapshot.isShared = !0), !((r = t.root) === null || r === void 0) && r.isUpdating && (t.isLayoutDirty = !0);
         const {
            crossfade: i
         } = t.options;
         i === !1 && o.hide()
      }
   }
   exitAnimationComplete() {
      this.members.forEach(t => {
         var n, r, o, i, s;
         (r = (n = t.options).onExitComplete) === null || r === void 0 || r.call(n), (s = (o = t.resumingFrom) === null || o === void 0 ? void 0 : (i = o.options).onExitComplete) === null || s === void 0 || s.call(i)
      })
   }
   scheduleRender() {
      this.members.forEach(t => {
         t.instance && t.scheduleRender(!1)
      })
   }
   removeLeadSnapshot() {
      this.lead && this.lead.snapshot && (this.lead.snapshot = void 0)
   }
}
const Yk = "translate3d(0px, 0px, 0) scale(1, 1) scale(1, 1)";

function Ud(e, t, n) {
   const r = e.x.translate / t.x,
      o = e.y.translate / t.y;
   let i = `translate3d(${r}px, ${o}px, 0) `;
   if (i += `scale(${1/t.x}, ${1/t.y}) `, n) {
      const {
         rotate: a,
         rotateX: u,
         rotateY: c
      } = n;
      a && (i += `rotate(${a}deg) `), u && (i += `rotateX(${u}deg) `), c && (i += `rotateY(${c}deg) `)
   }
   const s = e.x.scale * t.x,
      l = e.y.scale * t.y;
   return i += `scale(${s}, ${l})`, i === Yk ? "none" : i
}
const Kk = (e, t) => e.depth - t.depth;
class Xk {
   constructor() {
      this.children = [], this.isDirty = !1
   }
   add(t) {
      wc(this.children, t), this.isDirty = !0
   }
   remove(t) {
      Sc(this.children, t), this.isDirty = !0
   }
   forEach(t) {
      this.isDirty && this.children.sort(Kk), this.isDirty = !1, this.children.forEach(t)
   }
}
const Bd = ["", "X", "Y", "Z"],
   Hd = 1e3;

function b0({
   attachResizeListener: e,
   defaultParent: t,
   measureScroll: n,
   checkIsScrollRoot: r,
   resetTransform: o
}) {
   return class {
      constructor(s, l = {}, a = t == null ? void 0 : t()) {
         this.children = new Set, this.options = {}, this.isTreeAnimating = !1, this.isAnimationBlocked = !1, this.isLayoutDirty = !1, this.updateManuallyBlocked = !1, this.updateBlockedByResize = !1, this.isUpdating = !1, this.isSVG = !1, this.needsReset = !1, this.shouldResetTransform = !1, this.treeScale = {
            x: 1,
            y: 1
         }, this.eventHandlers = new Map, this.potentialNodes = new Map, this.checkUpdateFailed = () => {
            this.isUpdating && (this.isUpdating = !1, this.clearAllSnapshots())
         }, this.updateProjection = () => {
            this.nodes.forEach(tC), this.nodes.forEach(nC)
         }, this.hasProjected = !1, this.isVisible = !0, this.animationProgress = 0, this.sharedNodes = new Map, this.id = s, this.latestValues = l, this.root = a ? a.root || a : this, this.path = a ? [...a.path, a] : [], this.parent = a, this.depth = a ? a.depth + 1 : 0, s && this.root.registerPotentialNode(s, this);
         for (let u = 0; u < this.path.length; u++) this.path[u].shouldResetTransform = !0;
         this.root === this && (this.nodes = new Xk)
      }
      addEventListener(s, l) {
         return this.eventHandlers.has(s) || this.eventHandlers.set(s, new Xr), this.eventHandlers.get(s).add(l)
      }
      notifyListeners(s, ...l) {
         const a = this.eventHandlers.get(s);
         a == null || a.notify(...l)
      }
      hasListeners(s) {
         return this.eventHandlers.has(s)
      }
      registerPotentialNode(s, l) {
         this.potentialNodes.set(s, l)
      }
      mount(s, l = !1) {
         var a;
         if (this.instance) return;
         this.isSVG = s instanceof SVGElement && s.tagName !== "svg", this.instance = s;
         const {
            layoutId: u,
            layout: c,
            visualElement: f
         } = this.options;
         if (f && !f.current && f.mount(s), this.root.nodes.add(this), (a = this.parent) === null || a === void 0 || a.children.add(this), this.id && this.root.potentialNodes.delete(this.id), l && (c || u) && (this.isLayoutDirty = !0), e) {
            let d;
            const g = () => this.root.updateBlockedByResize = !1;
            e(s, () => {
               this.root.updateBlockedByResize = !0, d && d(), d = C0(g, 250), Qr.hasAnimatedSinceResize && (Qr.hasAnimatedSinceResize = !1, this.nodes.forEach(Wd))
            })
         }
         u && this.root.registerSharedNode(u, this), this.options.animate !== !1 && f && (u || c) && this.addEventListener("didUpdate", ({
            delta: d,
            hasLayoutChanged: g,
            hasRelativeTargetChanged: v,
            layout: w
         }) => {
            var k, m, p, h, y;
            if (this.isTreeAnimationBlocked()) {
               this.target = void 0, this.relativeTarget = void 0;
               return
            }
            const x = (m = (k = this.options.transition) !== null && k !== void 0 ? k : f.getDefaultTransition()) !== null && m !== void 0 ? m : lC,
               {
                  onLayoutAnimationStart: E,
                  onLayoutAnimationComplete: T
               } = f.getProps(),
               A = !this.targetLayout || !H0(this.targetLayout, w) || v,
               I = !g && v;
            if (((p = this.resumeFrom) === null || p === void 0 ? void 0 : p.instance) || I || g && (A || !this.currentAnimation)) {
               this.resumeFrom && (this.resumingFrom = this.resumeFrom, this.resumingFrom.resumingFrom = void 0), this.setAnimationOrigin(d, I);
               const D = {
                  ...vc(x, "layout"),
                  onPlay: E,
                  onComplete: T
               };
               f.shouldReduceMotion && (D.delay = 0, D.type = !1), this.startAnimation(D)
            } else !g && this.animationProgress === 0 && Wd(this), this.isLead() && ((y = (h = this.options).onExitComplete) === null || y === void 0 || y.call(h));
            this.targetLayout = w
         })
      }
      unmount() {
         var s, l;
         this.options.layoutId && this.willUpdate(), this.root.nodes.remove(this), (s = this.getStack()) === null || s === void 0 || s.remove(this), (l = this.parent) === null || l === void 0 || l.children.delete(this), this.instance = void 0, fn.preRender(this.updateProjection)
      }
      blockUpdate() {
         this.updateManuallyBlocked = !0
      }
      unblockUpdate() {
         this.updateManuallyBlocked = !1
      }
      isUpdateBlocked() {
         return this.updateManuallyBlocked || this.updateBlockedByResize
      }
      isTreeAnimationBlocked() {
         var s;
         return this.isAnimationBlocked || ((s = this.parent) === null || s === void 0 ? void 0 : s.isTreeAnimationBlocked()) || !1
      }
      startUpdate() {
         var s;
         this.isUpdateBlocked() || (this.isUpdating = !0, (s = this.nodes) === null || s === void 0 || s.forEach(rC))
      }
      willUpdate(s = !0) {
         var l, a, u;
         if (this.root.isUpdateBlocked()) {
            (a = (l = this.options).onExitComplete) === null || a === void 0 || a.call(l);
            return
         }
         if (!this.root.isUpdating && this.root.startUpdate(), this.isLayoutDirty) return;
         this.isLayoutDirty = !0;
         for (let g = 0; g < this.path.length; g++) {
            const v = this.path[g];
            v.shouldResetTransform = !0, v.updateScroll()
         }
         const {
            layoutId: c,
            layout: f
         } = this.options;
         if (c === void 0 && !f) return;
         const d = (u = this.options.visualElement) === null || u === void 0 ? void 0 : u.getProps().transformTemplate;
         this.prevTransformTemplateValue = d == null ? void 0 : d(this.latestValues, ""), this.updateSnapshot(), s && this.notifyListeners("willUpdate")
      }
      didUpdate() {
         if (this.isUpdateBlocked()) {
            this.unblockUpdate(), this.clearAllSnapshots(), this.nodes.forEach(bd);
            return
         }!this.isUpdating || (this.isUpdating = !1, this.potentialNodes.size && (this.potentialNodes.forEach(aC), this.potentialNodes.clear()), this.nodes.forEach(eC), this.nodes.forEach(Zk), this.nodes.forEach(Jk), this.clearAllSnapshots(), Tl.update(), Tl.preRender(), Tl.render())
      }
      clearAllSnapshots() {
         this.nodes.forEach(qk), this.sharedNodes.forEach(oC)
      }
      scheduleUpdateProjection() {
         lt.preRender(this.updateProjection, !1, !0)
      }
      scheduleCheckAfterUnmount() {
         lt.postRender(() => {
            this.isLayoutDirty ? this.root.didUpdate() : this.root.checkUpdateFailed()
         })
      }
      updateSnapshot() {
         if (this.snapshot || !this.instance) return;
         const s = this.measure(),
            l = this.removeTransform(this.removeElementScroll(s));
         Kd(l), this.snapshot = {
            measured: s,
            layout: l,
            latestValues: {}
         }
      }
      updateLayout() {
         var s;
         if (!this.instance || (this.updateScroll(), !(this.options.alwaysMeasureLayout && this.isLead()) && !this.isLayoutDirty)) return;
         if (this.resumeFrom && !this.resumeFrom.instance)
            for (let u = 0; u < this.path.length; u++) this.path[u].updateScroll();
         const l = this.measure();
         Kd(l);
         const a = this.layout;
         this.layout = {
            measured: l,
            actual: this.removeElementScroll(l)
         }, this.layoutCorrected = Se(), this.isLayoutDirty = !1, this.projectionDelta = void 0, this.notifyListeners("measure", this.layout.actual), (s = this.options.visualElement) === null || s === void 0 || s.notify("LayoutMeasure", this.layout.actual, a == null ? void 0 : a.actual)
      }
      updateScroll() {
         this.options.layoutScroll && this.instance && (this.isScrollRoot = r(this.instance), this.scroll = n(this.instance))
      }
      resetTransform() {
         var s;
         if (!o) return;
         const l = this.isLayoutDirty || this.shouldResetTransform,
            a = this.projectionDelta && !B0(this.projectionDelta),
            u = (s = this.options.visualElement) === null || s === void 0 ? void 0 : s.getProps().transformTemplate,
            c = u == null ? void 0 : u(this.latestValues, ""),
            f = c !== this.prevTransformTemplateValue;
         l && (a || wn(this.latestValues) || f) && (o(this.instance, c), this.shouldResetTransform = !1, this.scheduleRender())
      }
      measure() {
         const {
            visualElement: s
         } = this.options;
         if (!s) return Se();
         const l = s.measureViewportBox(),
            {
               scroll: a
            } = this.root;
         return a && (Gt(l.x, a.x), Gt(l.y, a.y)), l
      }
      removeElementScroll(s) {
         const l = Se();
         dt(l, s);
         for (let a = 0; a < this.path.length; a++) {
            const u = this.path[a],
               {
                  scroll: c,
                  options: f,
                  isScrollRoot: d
               } = u;
            if (u !== this.root && c && f.layoutScroll) {
               if (d) {
                  dt(l, s);
                  const {
                     scroll: g
                  } = this.root;
                  g && (Gt(l.x, -g.x), Gt(l.y, -g.y))
               }
               Gt(l.x, c.x), Gt(l.y, c.y)
            }
         }
         return l
      }
      applyTransform(s, l = !1) {
         const a = Se();
         dt(a, s);
         for (let u = 0; u < this.path.length; u++) {
            const c = this.path[u];
            !l && c.options.layoutScroll && c.scroll && c !== c.root && Jn(a, {
               x: -c.scroll.x,
               y: -c.scroll.y
            }), wn(c.latestValues) && Jn(a, c.latestValues)
         }
         return wn(this.latestValues) && Jn(a, this.latestValues), a
      }
      removeTransform(s) {
         var l;
         const a = Se();
         dt(a, s);
         for (let u = 0; u < this.path.length; u++) {
            const c = this.path[u];
            if (!c.instance || !wn(c.latestValues)) continue;
            ba(c.latestValues) && c.updateSnapshot();
            const f = Se(),
               d = c.measure();
            dt(f, d), Fd(a, c.latestValues, (l = c.snapshot) === null || l === void 0 ? void 0 : l.layout, f)
         }
         return wn(this.latestValues) && Fd(a, this.latestValues), a
      }
      setTargetDelta(s) {
         this.targetDelta = s, this.root.scheduleUpdateProjection()
      }
      setOptions(s) {
         this.options = {
            ...this.options,
            ...s,
            crossfade: s.crossfade !== void 0 ? s.crossfade : !0
         }
      }
      clearMeasurements() {
         this.scroll = void 0, this.layout = void 0, this.snapshot = void 0, this.prevTransformTemplateValue = void 0, this.targetDelta = void 0, this.target = void 0, this.isLayoutDirty = !1
      }
      resolveTargetDelta() {
         var s;
         const {
            layout: l,
            layoutId: a
         } = this.options;
         if (!(!this.layout || !(l || a))) {
            if (!this.targetDelta && !this.relativeTarget) {
               const u = this.getClosestProjectingParent();
               u && u.layout ? (this.relativeParent = u, this.relativeTarget = Se(), this.relativeTargetOrigin = Se(), Jr(this.relativeTargetOrigin, this.layout.actual, u.layout.actual), dt(this.relativeTarget, this.relativeTargetOrigin)) : this.relativeParent = this.relativeTarget = void 0
            }
            if (!(!this.relativeTarget && !this.targetDelta) && (this.target || (this.target = Se(), this.targetWithTransforms = Se()), this.relativeTarget && this.relativeTargetOrigin && ((s = this.relativeParent) === null || s === void 0 ? void 0 : s.target) ? Yx(this.target, this.relativeTarget, this.relativeParent.target) : this.targetDelta ? (Boolean(this.resumingFrom) ? this.target = this.applyTransform(this.layout.actual) : dt(this.target, this.layout.actual), L0(this.target, this.targetDelta)) : dt(this.target, this.layout.actual), this.attemptToResolveRelativeTarget)) {
               this.attemptToResolveRelativeTarget = !1;
               const u = this.getClosestProjectingParent();
               u && Boolean(u.resumingFrom) === Boolean(this.resumingFrom) && !u.options.layoutScroll && u.target ? (this.relativeParent = u, this.relativeTarget = Se(), this.relativeTargetOrigin = Se(), Jr(this.relativeTargetOrigin, this.target, u.target), dt(this.relativeTarget, this.relativeTargetOrigin)) : this.relativeParent = this.relativeTarget = void 0
            }
         }
      }
      getClosestProjectingParent() {
         if (!(!this.parent || ba(this.parent.latestValues) || V0(this.parent.latestValues))) return (this.parent.relativeTarget || this.parent.targetDelta) && this.parent.layout ? this.parent : this.parent.getClosestProjectingParent()
      }
      calcProjection() {
         var s;
         const {
            layout: l,
            layoutId: a
         } = this.options;
         if (this.isTreeAnimating = Boolean(((s = this.parent) === null || s === void 0 ? void 0 : s.isTreeAnimating) || this.currentAnimation || this.pendingAnimation), this.isTreeAnimating || (this.targetDelta = this.relativeTarget = void 0), !this.layout || !(l || a)) return;
         const u = this.getLead();
         dt(this.layoutCorrected, this.layout.actual), rk(this.layoutCorrected, this.treeScale, this.path, Boolean(this.resumingFrom) || this !== u);
         const {
            target: c
         } = u;
         if (!c) return;
         this.projectionDelta || (this.projectionDelta = qr(), this.projectionDeltaWithTransform = qr());
         const f = this.treeScale.x,
            d = this.treeScale.y,
            g = this.projectionTransform;
         Zr(this.projectionDelta, this.layoutCorrected, c, this.latestValues), this.projectionTransform = Ud(this.projectionDelta, this.treeScale), (this.projectionTransform !== g || this.treeScale.x !== f || this.treeScale.y !== d) && (this.hasProjected = !0, this.scheduleRender(), this.notifyListeners("projectionUpdate", c))
      }
      hide() {
         this.isVisible = !1
      }
      show() {
         this.isVisible = !0
      }
      scheduleRender(s = !0) {
         var l, a, u;
         (a = (l = this.options).scheduleRender) === null || a === void 0 || a.call(l), s && ((u = this.getStack()) === null || u === void 0 || u.scheduleRender()), this.resumingFrom && !this.resumingFrom.instance && (this.resumingFrom = void 0)
      }
      setAnimationOrigin(s, l = !1) {
         var a;
         const u = this.snapshot,
            c = (u == null ? void 0 : u.latestValues) || {},
            f = {
               ...this.latestValues
            },
            d = qr();
         this.relativeTarget = this.relativeTargetOrigin = void 0, this.attemptToResolveRelativeTarget = !l;
         const g = Se(),
            v = u == null ? void 0 : u.isShared,
            w = (((a = this.getStack()) === null || a === void 0 ? void 0 : a.members.length) || 0) <= 1,
            k = Boolean(v && !w && this.options.crossfade === !0 && !this.path.some(sC));
         this.animationProgress = 0, this.mixTargetDelta = m => {
            var p;
            const h = m / 1e3;
            Gd(d.x, s.x, h), Gd(d.y, s.y, h), this.setTargetDelta(d), this.relativeTarget && this.relativeTargetOrigin && this.layout && ((p = this.relativeParent) === null || p === void 0 ? void 0 : p.layout) && (Jr(g, this.layout.actual, this.relativeParent.layout.actual), iC(this.relativeTarget, this.relativeTargetOrigin, g, h)), v && (this.animationValues = f, jk(f, c, this.latestValues, h, k, w)), this.root.scheduleUpdateProjection(), this.scheduleRender(), this.animationProgress = h
         }, this.mixTargetDelta(0)
      }
      startAnimation(s) {
         var l, a;
         this.notifyListeners("animationStart"), (l = this.currentAnimation) === null || l === void 0 || l.stop(), this.resumingFrom && ((a = this.resumingFrom.currentAnimation) === null || a === void 0 || a.stop()), this.pendingAnimation && (fn.update(this.pendingAnimation), this.pendingAnimation = void 0), this.pendingAnimation = lt.update(() => {
            Qr.hasAnimatedSinceResize = !0, this.currentAnimation = Fk(0, Hd, {
               ...s,
               onUpdate: u => {
                  var c;
                  this.mixTargetDelta(u), (c = s.onUpdate) === null || c === void 0 || c.call(s, u)
               },
               onComplete: () => {
                  var u;
                  (u = s.onComplete) === null || u === void 0 || u.call(s), this.completeAnimation()
               }
            }), this.resumingFrom && (this.resumingFrom.currentAnimation = this.currentAnimation), this.pendingAnimation = void 0
         })
      }
      completeAnimation() {
         var s;
         this.resumingFrom && (this.resumingFrom.currentAnimation = void 0, this.resumingFrom.preserveOpacity = void 0), (s = this.getStack()) === null || s === void 0 || s.exitAnimationComplete(), this.resumingFrom = this.currentAnimation = this.animationValues = void 0, this.notifyListeners("animationComplete")
      }
      finishAnimation() {
         var s;
         this.currentAnimation && ((s = this.mixTargetDelta) === null || s === void 0 || s.call(this, Hd), this.currentAnimation.stop()), this.completeAnimation()
      }
      applyTransformsToTarget() {
         const s = this.getLead();
         let {
            targetWithTransforms: l,
            target: a,
            layout: u,
            latestValues: c
         } = s;
         if (!(!l || !a || !u)) {
            if (this !== s && this.layout && u && W0(this.options.animationType, this.layout.actual, u.actual)) {
               a = this.target || Se();
               const f = qe(this.layout.actual.x);
               a.x.min = s.target.x.min, a.x.max = a.x.min + f;
               const d = qe(this.layout.actual.y);
               a.y.min = s.target.y.min, a.y.max = a.y.min + d
            }
            dt(l, a), Jn(l, c), Zr(this.projectionDeltaWithTransform, this.layoutCorrected, l, c)
         }
      }
      registerSharedNode(s, l) {
         var a, u, c;
         this.sharedNodes.has(s) || this.sharedNodes.set(s, new Qk), this.sharedNodes.get(s).add(l), l.promote({
            transition: (a = l.options.initialPromotionConfig) === null || a === void 0 ? void 0 : a.transition,
            preserveFollowOpacity: (c = (u = l.options.initialPromotionConfig) === null || u === void 0 ? void 0 : u.shouldPreserveFollowOpacity) === null || c === void 0 ? void 0 : c.call(u, l)
         })
      }
      isLead() {
         const s = this.getStack();
         return s ? s.lead === this : !0
      }
      getLead() {
         var s;
         const {
            layoutId: l
         } = this.options;
         return l ? ((s = this.getStack()) === null || s === void 0 ? void 0 : s.lead) || this : this
      }
      getPrevLead() {
         var s;
         const {
            layoutId: l
         } = this.options;
         return l ? (s = this.getStack()) === null || s === void 0 ? void 0 : s.prevLead : void 0
      }
      getStack() {
         const {
            layoutId: s
         } = this.options;
         if (s) return this.root.sharedNodes.get(s)
      }
      promote({
         needsReset: s,
         transition: l,
         preserveFollowOpacity: a
      } = {}) {
         const u = this.getStack();
         u && u.promote(this, a), s && (this.projectionDelta = void 0, this.needsReset = !0), l && this.setOptions({
            transition: l
         })
      }
      relegate() {
         const s = this.getStack();
         return s ? s.relegate(this) : !1
      }
      resetRotation() {
         const {
            visualElement: s
         } = this.options;
         if (!s) return;
         let l = !1;
         const a = {};
         for (let u = 0; u < Bd.length; u++) {
            const c = Bd[u],
               f = "rotate" + c;
            !s.getStaticValue(f) || (l = !0, a[f] = s.getStaticValue(f), s.setStaticValue(f, 0))
         }
         if (!!l) {
            s == null || s.render();
            for (const u in a) s.setStaticValue(u, a[u]);
            s.scheduleRender()
         }
      }
      getProjectionStyles(s = {}) {
         var l, a, u;
         const c = {};
         if (!this.instance || this.isSVG) return c;
         if (this.isVisible) c.visibility = "";
         else return {
            visibility: "hidden"
         };
         const f = (l = this.options.visualElement) === null || l === void 0 ? void 0 : l.getProps().transformTemplate;
         if (this.needsReset) return this.needsReset = !1, c.opacity = "", c.pointerEvents = xi(s.pointerEvents) || "", c.transform = f ? f(this.latestValues, "") : "none", c;
         const d = this.getLead();
         if (!this.projectionDelta || !this.layout || !d.target) {
            const k = {};
            return this.options.layoutId && (k.opacity = this.latestValues.opacity !== void 0 ? this.latestValues.opacity : 1, k.pointerEvents = xi(s.pointerEvents) || ""), this.hasProjected && !wn(this.latestValues) && (k.transform = f ? f({}, "") : "none", this.hasProjected = !1), k
         }
         const g = d.animationValues || d.latestValues;
         this.applyTransformsToTarget(), c.transform = Ud(this.projectionDeltaWithTransform, this.treeScale, g), f && (c.transform = f(g, c.transform));
         const {
            x: v,
            y: w
         } = this.projectionDelta;
         c.transformOrigin = `${v.origin*100}% ${w.origin*100}% 0`, d.animationValues ? c.opacity = d === this ? (u = (a = g.opacity) !== null && a !== void 0 ? a : this.latestValues.opacity) !== null && u !== void 0 ? u : 1 : this.preserveOpacity ? this.latestValues.opacity : g.opacityExit : c.opacity = d === this ? g.opacity !== void 0 ? g.opacity : "" : g.opacityExit !== void 0 ? g.opacityExit : 0;
         for (const k in Zi) {
            if (g[k] === void 0) continue;
            const {
               correct: m,
               applyTo: p
            } = Zi[k], h = m(g[k], d);
            if (p) {
               const y = p.length;
               for (let x = 0; x < y; x++) c[p[x]] = h
            } else c[k] = h
         }
         return this.options.layoutId && (c.pointerEvents = d === this ? xi(s.pointerEvents) || "" : "none"), c
      }
      clearSnapshot() {
         this.resumeFrom = this.snapshot = void 0
      }
      resetTree() {
         this.root.nodes.forEach(s => {
            var l;
            return (l = s.currentAnimation) === null || l === void 0 ? void 0 : l.stop()
         }), this.root.nodes.forEach(bd), this.root.sharedNodes.clear()
      }
   }
}

function Zk(e) {
   e.updateLayout()
}

function Jk(e) {
   var t, n, r;
   const o = ((t = e.resumeFrom) === null || t === void 0 ? void 0 : t.snapshot) || e.snapshot;
   if (e.isLead() && e.layout && o && e.hasListeners("didUpdate")) {
      const {
         actual: i,
         measured: s
      } = e.layout, {
         animationType: l
      } = e.options;
      l === "size" ? Ct(d => {
         const g = o.isShared ? o.measured[d] : o.layout[d],
            v = qe(g);
         g.min = i[d].min, g.max = g.min + v
      }) : W0(l, o.layout, i) && Ct(d => {
         const g = o.isShared ? o.measured[d] : o.layout[d],
            v = qe(i[d]);
         g.max = g.min + v
      });
      const a = qr();
      Zr(a, i, o.layout);
      const u = qr();
      o.isShared ? Zr(u, e.applyTransform(s, !0), o.measured) : Zr(u, i, o.layout);
      const c = !B0(a);
      let f = !1;
      if (!e.resumeFrom) {
         const d = e.getClosestProjectingParent();
         if (d && !d.resumeFrom) {
            const {
               snapshot: g,
               layout: v
            } = d;
            if (g && v) {
               const w = Se();
               Jr(w, o.layout, g.layout);
               const k = Se();
               Jr(k, i, v.actual), H0(w, k) || (f = !0)
            }
         }
      }
      e.notifyListeners("didUpdate", {
         layout: i,
         snapshot: o,
         delta: u,
         layoutDelta: a,
         hasLayoutChanged: c,
         hasRelativeTargetChanged: f
      })
   } else e.isLead() && ((r = (n = e.options).onExitComplete) === null || r === void 0 || r.call(n));
   e.options.transition = void 0
}

function qk(e) {
   e.clearSnapshot()
}

function bd(e) {
   e.clearMeasurements()
}

function eC(e) {
   const {
      visualElement: t
   } = e.options;
   t != null && t.getProps().onBeforeLayoutMeasure && t.notify("BeforeLayoutMeasure"), e.resetTransform()
}

function Wd(e) {
   e.finishAnimation(), e.targetDelta = e.relativeTarget = e.target = void 0
}

function tC(e) {
   e.resolveTargetDelta()
}

function nC(e) {
   e.calcProjection()
}

function rC(e) {
   e.resetRotation()
}

function oC(e) {
   e.removeLeadSnapshot()
}

function Gd(e, t, n) {
   e.translate = he(t.translate, 0, n), e.scale = he(t.scale, 1, n), e.origin = t.origin, e.originPoint = t.originPoint
}

function Qd(e, t, n, r) {
   e.min = he(t.min, n.min, r), e.max = he(t.max, n.max, r)
}

function iC(e, t, n, r) {
   Qd(e.x, t.x, n.x, r), Qd(e.y, t.y, n.y, r)
}

function sC(e) {
   return e.animationValues && e.animationValues.opacityExit !== void 0
}
const lC = {
   duration: .45,
   ease: [.4, 0, .1, 1]
};

function aC(e, t) {
   let n = e.root;
   for (let i = e.path.length - 1; i >= 0; i--)
      if (Boolean(e.path[i].instance)) {
         n = e.path[i];
         break
      } const o = (n && n !== e.root ? n.instance : document).querySelector(`[data-projection-id="${t}"]`);
   o && e.mount(o, !0)
}

function Yd(e) {
   e.min = Math.round(e.min), e.max = Math.round(e.max)
}

function Kd(e) {
   Yd(e.x), Yd(e.y)
}

function W0(e, t, n) {
   return e === "position" || e === "preserve-aspect" && !Gk(jd(t), jd(n), .2)
}
const uC = b0({
      attachResizeListener: (e, t) => Us(e, "resize", t),
      measureScroll: () => ({
         x: document.documentElement.scrollLeft || document.body.scrollLeft,
         y: document.documentElement.scrollTop || document.body.scrollTop
      }),
      checkIsScrollRoot: () => !0
   }),
   Ml = {
      current: void 0
   },
   cC = b0({
      measureScroll: e => ({
         x: e.scrollLeft,
         y: e.scrollTop
      }),
      defaultParent: () => {
         if (!Ml.current) {
            const e = new uC(0, {});
            e.mount(window), e.setOptions({
               layoutScroll: !0
            }), Ml.current = e
         }
         return Ml.current
      },
      resetTransform: (e, t) => {
         e.style.transform = t !== void 0 ? t : "none"
      },
      checkIsScrollRoot: e => Boolean(window.getComputedStyle(e).position === "fixed")
   }),
   fC = {
      ...Wx,
      ...ax,
      ...dk,
      ...zk
   },
   dC = ew((e, t) => $w(e, t, fC, Mk, cC));

function G0() {
   const e = C.exports.useRef(!1);
   return Xi(() => (e.current = !0, () => {
      e.current = !1
   }), []), e
}

function pC() {
   const e = G0(),
      [t, n] = C.exports.useState(0),
      r = C.exports.useCallback(() => {
         e.current && n(t + 1)
      }, [t]);
   return [C.exports.useCallback(() => lt.postRender(r), [r]), t]
}
class hC extends C.exports.Component {
   getSnapshotBeforeUpdate(t) {
      const n = this.props.childRef.current;
      if (n && t.isPresent && !this.props.isPresent) {
         const r = this.props.sizeRef.current;
         r.height = n.offsetHeight || 0, r.width = n.offsetWidth || 0, r.top = n.offsetTop, r.left = n.offsetLeft
      }
      return null
   }
   componentDidUpdate() {}
   render() {
      return this.props.children
   }
}

function mC({
   children: e,
   isPresent: t
}) {
   const n = C.exports.useId(),
      r = C.exports.useRef(null),
      o = C.exports.useRef({
         width: 0,
         height: 0,
         top: 0,
         left: 0
      });
   return C.exports.useInsertionEffect(() => {
      const {
         width: i,
         height: s,
         top: l,
         left: a
      } = o.current;
      if (t || !r.current || !i || !s) return;
      r.current.dataset.motionPopId = n;
      const u = document.createElement("style");
      return document.head.appendChild(u), u.sheet && u.sheet.insertRule(`
          [data-motion-pop-id="${n}"] {
            position: absolute !important;
            width: ${i}px !important;
            height: ${s}px !important;
            top: ${l}px !important;
            left: ${a}px !important;
          }
        `), () => {
         document.head.removeChild(u)
      }
   }, [t]), C.exports.createElement(hC, {
      isPresent: t,
      childRef: r,
      sizeRef: o
   }, C.exports.cloneElement(e, {
      ref: r
   }))
}
const Ol = ({
   children: e,
   initial: t,
   isPresent: n,
   onExitComplete: r,
   custom: o,
   presenceAffectsLayout: i,
   mode: s
}) => {
   const l = js(gC),
      a = C.exports.useId(),
      u = C.exports.useMemo(() => ({
         id: a,
         initial: t,
         isPresent: n,
         custom: o,
         onExitComplete: c => {
            l.set(c, !0);
            for (const f of l.values())
               if (!f) return;
            r && r()
         },
         register: c => (l.set(c, !1), () => l.delete(c))
      }), i ? void 0 : [n]);
   return C.exports.useMemo(() => {
      l.forEach((c, f) => l.set(f, !1))
   }, [n]), C.exports.useEffect(() => {
      !n && !l.size && r && r()
   }, [n]), s === "popLayout" && (e = C.exports.createElement(mC, {
      isPresent: n
   }, e)), C.exports.createElement(Mo.Provider, {
      value: u
   }, e)
};

function gC() {
   return new Map
}
const zn = e => e.key || "";

function vC(e, t) {
   e.forEach(n => {
      const r = zn(n);
      t.set(r, n)
   })
}

function yC(e) {
   const t = [];
   return C.exports.Children.forEach(e, n => {
      C.exports.isValidElement(n) && t.push(n)
   }), t
}
const wC = ({
      children: e,
      custom: t,
      initial: n = !0,
      onExitComplete: r,
      exitBeforeEnter: o,
      presenceAffectsLayout: i = !0,
      mode: s = "sync"
   }) => {
      o && (s = "wait", S0(!1, "Replace exitBeforeEnter with mode='wait'"));
      let [l] = pC();
      const a = C.exports.useContext(Ju).forceRender;
      a && (l = a);
      const u = G0(),
         c = yC(e);
      let f = c;
      const d = new Set,
         g = C.exports.useRef(f),
         v = C.exports.useRef(new Map).current,
         w = C.exports.useRef(!0);
      if (Xi(() => {
            w.current = !1, vC(c, v), g.current = f
         }), lc(() => {
            w.current = !0, v.clear(), d.clear()
         }), w.current) return C.exports.createElement(C.exports.Fragment, null, f.map(h => C.exports.createElement(Ol, {
         key: zn(h),
         isPresent: !0,
         initial: n ? void 0 : !1,
         presenceAffectsLayout: i,
         mode: s
      }, h)));
      f = [...f];
      const k = g.current.map(zn),
         m = c.map(zn),
         p = k.length;
      for (let h = 0; h < p; h++) {
         const y = k[h];
         m.indexOf(y) === -1 && d.add(y)
      }
      return s === "wait" && d.size && (f = []), d.forEach(h => {
         if (m.indexOf(h) !== -1) return;
         const y = v.get(h);
         if (!y) return;
         const x = k.indexOf(h),
            E = () => {
               v.delete(h), d.delete(h);
               const T = g.current.findIndex(A => A.key === h);
               if (g.current.splice(T, 1), !d.size) {
                  if (g.current = c, u.current === !1) return;
                  l(), r && r()
               }
            };
         f.splice(x, 0, C.exports.createElement(Ol, {
            key: zn(y),
            isPresent: !1,
            onExitComplete: E,
            custom: t,
            presenceAffectsLayout: i,
            mode: s
         }, y))
      }), f = f.map(h => {
         const y = h.key;
         return d.has(y) ? h : C.exports.createElement(Ol, {
            key: zn(h),
            isPresent: !0,
            presenceAffectsLayout: i,
            mode: s
         }, h)
      }), w0 !== "production" && s === "wait" && f.length > 1 && console.warn(`You're attempting to animate multiple children within AnimatePresence, but its mode is set to "wait". This will lead to odd visual behaviour.`), C.exports.createElement(C.exports.Fragment, null, d.size ? f : f.map(h => C.exports.cloneElement(h)))
   },
   SC = () => {
      const {
         visible: e,
         setVisible: t
      } = Sy(), {
         setData: n
      } = Xu();
      return lm("open", r => {
         t(!0), n(r)
      }), B(yy, {
         children: B(wC, {
            children: e && B(dC.div, {
               initial: {
                  opacity: 0
               },
               animate: {
                  opacity: 1
               },
               exit: {
                  opacity: 0
               },
               children: gt(w1, {
                  children: [B(j1, {}), B(S1, {})]
               })
            })
         })
      })
   };
Dl.createRoot(document.getElementById("root")).render(B(Ln.StrictMode, {
   children: B(wy, {
      children: B(C1, {
         children: B(SC, {})
      })
   })
}));