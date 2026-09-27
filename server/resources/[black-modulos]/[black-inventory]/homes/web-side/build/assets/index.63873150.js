function Gh(e, t) {
  return (
    t.forEach(function (n) {
      n &&
        typeof n != "string" &&
        !Array.isArray(n) &&
        Object.keys(n).forEach(function (r) {
          if (r !== "default" && !(r in e)) {
            var o = Object.getOwnPropertyDescriptor(n, r);
            Object.defineProperty(
              e,
              r,
              o.get
                ? o
                : {
                    enumerable: !0,
                    get: function () {
                      return n[r];
                    },
                  }
            );
          }
        });
    }),
    Object.freeze(
      Object.defineProperty(e, Symbol.toStringTag, { value: "Module" })
    )
  );
}
const Kh = function () {
  const t = document.createElement("link").relList;
  if (t && t.supports && t.supports("modulepreload")) return;
  for (const o of document.querySelectorAll('link[rel="modulepreload"]')) r(o);
  new MutationObserver((o) => {
    for (const i of o)
      if (i.type === "childList")
        for (const l of i.addedNodes)
          l.tagName === "LINK" && l.rel === "modulepreload" && r(l);
  }).observe(document, { childList: !0, subtree: !0 });
  function n(o) {
    const i = {};
    return (
      o.integrity && (i.integrity = o.integrity),
      o.referrerpolicy && (i.referrerPolicy = o.referrerpolicy),
      o.crossorigin === "use-credentials"
        ? (i.credentials = "include")
        : o.crossorigin === "anonymous"
        ? (i.credentials = "omit")
        : (i.credentials = "same-origin"),
      i
    );
  }
  function r(o) {
    if (o.ep) return;
    o.ep = !0;
    const i = n(o);
    fetch(o.href, i);
  }
};
Kh();
var Nl = {},
  Ur = { exports: {} },
  $e = {},
  g = { exports: {} },
  L = {};
/**
 * @license React
 * react.production.min.js
 *
 * Copyright (c) Facebook, Inc. and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */ var Wr = Symbol.for("react.element"),
  Yh = Symbol.for("react.portal"),
  Xh = Symbol.for("react.fragment"),
  Zh = Symbol.for("react.strict_mode"),
  qh = Symbol.for("react.profiler"),
  Jh = Symbol.for("react.provider"),
  eg = Symbol.for("react.context"),
  tg = Symbol.for("react.forward_ref"),
  ng = Symbol.for("react.suspense"),
  rg = Symbol.for("react.memo"),
  og = Symbol.for("react.lazy"),
  ha = Symbol.iterator;
function ig(e) {
  return e === null || typeof e != "object"
    ? null
    : ((e = (ha && e[ha]) || e["@@iterator"]),
      typeof e == "function" ? e : null);
}
var Pd = {
    isMounted: function () {
      return !1;
    },
    enqueueForceUpdate: function () {},
    enqueueReplaceState: function () {},
    enqueueSetState: function () {},
  },
  Id = Object.assign,
  Dd = {};
function Wn(e, t, n) {
  (this.props = e),
    (this.context = t),
    (this.refs = Dd),
    (this.updater = n || Pd);
}
Wn.prototype.isReactComponent = {};
Wn.prototype.setState = function (e, t) {
  if (typeof e != "object" && typeof e != "function" && e != null)
    throw Error(
      "setState(...): takes an object of state variables to update or a function which returns an object of state variables."
    );
  this.updater.enqueueSetState(this, e, t, "setState");
};
Wn.prototype.forceUpdate = function (e) {
  this.updater.enqueueForceUpdate(this, e, "forceUpdate");
};
function $d() {}
$d.prototype = Wn.prototype;
function eu(e, t, n) {
  (this.props = e),
    (this.context = t),
    (this.refs = Dd),
    (this.updater = n || Pd);
}
var tu = (eu.prototype = new $d());
tu.constructor = eu;
Id(tu, Wn.prototype);
tu.isPureReactComponent = !0;
var ga = Array.isArray,
  Rd = Object.prototype.hasOwnProperty,
  nu = { current: null },
  _d = { key: !0, ref: !0, __self: !0, __source: !0 };
function Nd(e, t, n) {
  var r,
    o = {},
    i = null,
    l = null;
  if (t != null)
    for (r in (t.ref !== void 0 && (l = t.ref),
    t.key !== void 0 && (i = "" + t.key),
    t))
      Rd.call(t, r) && !_d.hasOwnProperty(r) && (o[r] = t[r]);
  var s = arguments.length - 2;
  if (s === 1) o.children = n;
  else if (1 < s) {
    for (var u = Array(s), a = 0; a < s; a++) u[a] = arguments[a + 2];
    o.children = u;
  }
  if (e && e.defaultProps)
    for (r in ((s = e.defaultProps), s)) o[r] === void 0 && (o[r] = s[r]);
  return {
    $$typeof: Wr,
    type: e,
    key: i,
    ref: l,
    props: o,
    _owner: nu.current,
  };
}
function lg(e, t) {
  return {
    $$typeof: Wr,
    type: e.type,
    key: t,
    ref: e.ref,
    props: e.props,
    _owner: e._owner,
  };
}
function ru(e) {
  return typeof e == "object" && e !== null && e.$$typeof === Wr;
}
function sg(e) {
  var t = { "=": "=0", ":": "=2" };
  return (
    "$" +
    e.replace(/[=:]/g, function (n) {
      return t[n];
    })
  );
}
var ma = /\/+/g;
function Hi(e, t) {
  return typeof e == "object" && e !== null && e.key != null
    ? sg("" + e.key)
    : t.toString(36);
}
function To(e, t, n, r, o) {
  var i = typeof e;
  (i === "undefined" || i === "boolean") && (e = null);
  var l = !1;
  if (e === null) l = !0;
  else
    switch (i) {
      case "string":
      case "number":
        l = !0;
        break;
      case "object":
        switch (e.$$typeof) {
          case Wr:
          case Yh:
            l = !0;
        }
    }
  if (l)
    return (
      (l = e),
      (o = o(l)),
      (e = r === "" ? "." + Hi(l, 0) : r),
      ga(o)
        ? ((n = ""),
          e != null && (n = e.replace(ma, "$&/") + "/"),
          To(o, t, n, "", function (a) {
            return a;
          }))
        : o != null &&
          (ru(o) &&
            (o = lg(
              o,
              n +
                (!o.key || (l && l.key === o.key)
                  ? ""
                  : ("" + o.key).replace(ma, "$&/") + "/") +
                e
            )),
          t.push(o)),
      1
    );
  if (((l = 0), (r = r === "" ? "." : r + ":"), ga(e)))
    for (var s = 0; s < e.length; s++) {
      i = e[s];
      var u = r + Hi(i, s);
      l += To(i, t, n, u, o);
    }
  else if (((u = ig(e)), typeof u == "function"))
    for (e = u.call(e), s = 0; !(i = e.next()).done; )
      (i = i.value), (u = r + Hi(i, s++)), (l += To(i, t, n, u, o));
  else if (i === "object")
    throw (
      ((t = String(e)),
      Error(
        "Objects are not valid as a React child (found: " +
          (t === "[object Object]"
            ? "object with keys {" + Object.keys(e).join(", ") + "}"
            : t) +
          "). If you meant to render a collection of children, use an array instead."
      ))
    );
  return l;
}
function to(e, t, n) {
  if (e == null) return e;
  var r = [],
    o = 0;
  return (
    To(e, r, "", "", function (i) {
      return t.call(n, i, o++);
    }),
    r
  );
}
function ug(e) {
  if (e._status === -1) {
    var t = e._result;
    (t = t()),
      t.then(
        function (n) {
          (e._status === 0 || e._status === -1) &&
            ((e._status = 1), (e._result = n));
        },
        function (n) {
          (e._status === 0 || e._status === -1) &&
            ((e._status = 2), (e._result = n));
        }
      ),
      e._status === -1 && ((e._status = 0), (e._result = t));
  }
  if (e._status === 1) return e._result.default;
  throw e._result;
}
var ye = { current: null },
  Po = { transition: null },
  ag = {
    ReactCurrentDispatcher: ye,
    ReactCurrentBatchConfig: Po,
    ReactCurrentOwner: nu,
  };
L.Children = {
  map: to,
  forEach: function (e, t, n) {
    to(
      e,
      function () {
        t.apply(this, arguments);
      },
      n
    );
  },
  count: function (e) {
    var t = 0;
    return (
      to(e, function () {
        t++;
      }),
      t
    );
  },
  toArray: function (e) {
    return (
      to(e, function (t) {
        return t;
      }) || []
    );
  },
  only: function (e) {
    if (!ru(e))
      throw Error(
        "React.Children.only expected to receive a single React element child."
      );
    return e;
  },
};
L.Component = Wn;
L.Fragment = Xh;
L.Profiler = qh;
L.PureComponent = eu;
L.StrictMode = Zh;
L.Suspense = ng;
L.__SECRET_INTERNALS_DO_NOT_USE_OR_YOU_WILL_BE_FIRED = ag;
L.cloneElement = function (e, t, n) {
  if (e == null)
    throw Error(
      "React.cloneElement(...): The argument must be a React element, but you passed " +
        e +
        "."
    );
  var r = Id({}, e.props),
    o = e.key,
    i = e.ref,
    l = e._owner;
  if (t != null) {
    if (
      (t.ref !== void 0 && ((i = t.ref), (l = nu.current)),
      t.key !== void 0 && (o = "" + t.key),
      e.type && e.type.defaultProps)
    )
      var s = e.type.defaultProps;
    for (u in t)
      Rd.call(t, u) &&
        !_d.hasOwnProperty(u) &&
        (r[u] = t[u] === void 0 && s !== void 0 ? s[u] : t[u]);
  }
  var u = arguments.length - 2;
  if (u === 1) r.children = n;
  else if (1 < u) {
    s = Array(u);
    for (var a = 0; a < u; a++) s[a] = arguments[a + 2];
    r.children = s;
  }
  return { $$typeof: Wr, type: e.type, key: o, ref: i, props: r, _owner: l };
};
L.createContext = function (e) {
  return (
    (e = {
      $$typeof: eg,
      _currentValue: e,
      _currentValue2: e,
      _threadCount: 0,
      Provider: null,
      Consumer: null,
      _defaultValue: null,
      _globalName: null,
    }),
    (e.Provider = { $$typeof: Jh, _context: e }),
    (e.Consumer = e)
  );
};
L.createElement = Nd;
L.createFactory = function (e) {
  var t = Nd.bind(null, e);
  return (t.type = e), t;
};
L.createRef = function () {
  return { current: null };
};
L.forwardRef = function (e) {
  return { $$typeof: tg, render: e };
};
L.isValidElement = ru;
L.lazy = function (e) {
  return { $$typeof: og, _payload: { _status: -1, _result: e }, _init: ug };
};
L.memo = function (e, t) {
  return { $$typeof: rg, type: e, compare: t === void 0 ? null : t };
};
L.startTransition = function (e) {
  var t = Po.transition;
  Po.transition = {};
  try {
    e();
  } finally {
    Po.transition = t;
  }
};
L.unstable_act = function () {
  throw Error("act(...) is not supported in production builds of React.");
};
L.useCallback = function (e, t) {
  return ye.current.useCallback(e, t);
};
L.useContext = function (e) {
  return ye.current.useContext(e);
};
L.useDebugValue = function () {};
L.useDeferredValue = function (e) {
  return ye.current.useDeferredValue(e);
};
L.useEffect = function (e, t) {
  return ye.current.useEffect(e, t);
};
L.useId = function () {
  return ye.current.useId();
};
L.useImperativeHandle = function (e, t, n) {
  return ye.current.useImperativeHandle(e, t, n);
};
L.useInsertionEffect = function (e, t) {
  return ye.current.useInsertionEffect(e, t);
};
L.useLayoutEffect = function (e, t) {
  return ye.current.useLayoutEffect(e, t);
};
L.useMemo = function (e, t) {
  return ye.current.useMemo(e, t);
};
L.useReducer = function (e, t, n) {
  return ye.current.useReducer(e, t, n);
};
L.useRef = function (e) {
  return ye.current.useRef(e);
};
L.useState = function (e) {
  return ye.current.useState(e);
};
L.useSyncExternalStore = function (e, t, n) {
  return ye.current.useSyncExternalStore(e, t, n);
};
L.useTransition = function () {
  return ye.current.useTransition();
};
L.version = "18.2.0";
g.exports = L;
var me = g.exports,
  Wo = Gh({ __proto__: null, default: me }, [g.exports]),
  bd = { exports: {} },
  Md = {};
/**
 * @license React
 * scheduler.production.min.js
 *
 * Copyright (c) Facebook, Inc. and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */ (function (e) {
  function t(I, b) {
    var M = I.length;
    I.push(b);
    e: for (; 0 < M; ) {
      var X = (M - 1) >>> 1,
        ne = I[X];
      if (0 < o(ne, b)) (I[X] = b), (I[M] = ne), (M = X);
      else break e;
    }
  }
  function n(I) {
    return I.length === 0 ? null : I[0];
  }
  function r(I) {
    if (I.length === 0) return null;
    var b = I[0],
      M = I.pop();
    if (M !== b) {
      I[0] = M;
      e: for (var X = 0, ne = I.length, Jr = ne >>> 1; X < Jr; ) {
        var Lt = 2 * (X + 1) - 1,
          Wi = I[Lt],
          Ft = Lt + 1,
          eo = I[Ft];
        if (0 > o(Wi, M))
          Ft < ne && 0 > o(eo, Wi)
            ? ((I[X] = eo), (I[Ft] = M), (X = Ft))
            : ((I[X] = Wi), (I[Lt] = M), (X = Lt));
        else if (Ft < ne && 0 > o(eo, M)) (I[X] = eo), (I[Ft] = M), (X = Ft);
        else break e;
      }
    }
    return b;
  }
  function o(I, b) {
    var M = I.sortIndex - b.sortIndex;
    return M !== 0 ? M : I.id - b.id;
  }
  if (typeof performance == "object" && typeof performance.now == "function") {
    var i = performance;
    e.unstable_now = function () {
      return i.now();
    };
  } else {
    var l = Date,
      s = l.now();
    e.unstable_now = function () {
      return l.now() - s;
    };
  }
  var u = [],
    a = [],
    c = 1,
    f = null,
    p = 3,
    y = !1,
    S = !1,
    m = !1,
    C = typeof setTimeout == "function" ? setTimeout : null,
    h = typeof clearTimeout == "function" ? clearTimeout : null,
    d = typeof setImmediate != "undefined" ? setImmediate : null;
  typeof navigator != "undefined" &&
    navigator.scheduling !== void 0 &&
    navigator.scheduling.isInputPending !== void 0 &&
    navigator.scheduling.isInputPending.bind(navigator.scheduling);
  function v(I) {
    for (var b = n(a); b !== null; ) {
      if (b.callback === null) r(a);
      else if (b.startTime <= I)
        r(a), (b.sortIndex = b.expirationTime), t(u, b);
      else break;
      b = n(a);
    }
  }
  function w(I) {
    if (((m = !1), v(I), !S))
      if (n(u) !== null) (S = !0), Gn(E);
      else {
        var b = n(a);
        b !== null && Mt(w, b.startTime - I);
      }
  }
  function E(I, b) {
    (S = !1), m && ((m = !1), h(O), (O = -1)), (y = !0);
    var M = p;
    try {
      for (
        v(b), f = n(u);
        f !== null && (!(f.expirationTime > b) || (I && !z()));

      ) {
        var X = f.callback;
        if (typeof X == "function") {
          (f.callback = null), (p = f.priorityLevel);
          var ne = X(f.expirationTime <= b);
          (b = e.unstable_now()),
            typeof ne == "function" ? (f.callback = ne) : f === n(u) && r(u),
            v(b);
        } else r(u);
        f = n(u);
      }
      if (f !== null) var Jr = !0;
      else {
        var Lt = n(a);
        Lt !== null && Mt(w, Lt.startTime - b), (Jr = !1);
      }
      return Jr;
    } finally {
      (f = null), (p = M), (y = !1);
    }
  }
  var x = !1,
    k = null,
    O = -1,
    _ = 5,
    R = -1;
  function z() {
    return !(e.unstable_now() - R < _);
  }
  function q() {
    if (k !== null) {
      var I = e.unstable_now();
      R = I;
      var b = !0;
      try {
        b = k(!0, I);
      } finally {
        b ? ae() : ((x = !1), (k = null));
      }
    } else x = !1;
  }
  var ae;
  if (typeof d == "function")
    ae = function () {
      d(q);
    };
  else if (typeof MessageChannel != "undefined") {
    var bt = new MessageChannel(),
      qr = bt.port2;
    (bt.port1.onmessage = q),
      (ae = function () {
        qr.postMessage(null);
      });
  } else
    ae = function () {
      C(q, 0);
    };
  function Gn(I) {
    (k = I), x || ((x = !0), ae());
  }
  function Mt(I, b) {
    O = C(function () {
      I(e.unstable_now());
    }, b);
  }
  (e.unstable_IdlePriority = 5),
    (e.unstable_ImmediatePriority = 1),
    (e.unstable_LowPriority = 4),
    (e.unstable_NormalPriority = 3),
    (e.unstable_Profiling = null),
    (e.unstable_UserBlockingPriority = 2),
    (e.unstable_cancelCallback = function (I) {
      I.callback = null;
    }),
    (e.unstable_continueExecution = function () {
      S || y || ((S = !0), Gn(E));
    }),
    (e.unstable_forceFrameRate = function (I) {
      0 > I || 125 < I
        ? console.error(
            "forceFrameRate takes a positive int between 0 and 125, forcing frame rates higher than 125 fps is not supported"
          )
        : (_ = 0 < I ? Math.floor(1e3 / I) : 5);
    }),
    (e.unstable_getCurrentPriorityLevel = function () {
      return p;
    }),
    (e.unstable_getFirstCallbackNode = function () {
      return n(u);
    }),
    (e.unstable_next = function (I) {
      switch (p) {
        case 1:
        case 2:
        case 3:
          var b = 3;
          break;
        default:
          b = p;
      }
      var M = p;
      p = b;
      try {
        return I();
      } finally {
        p = M;
      }
    }),
    (e.unstable_pauseExecution = function () {}),
    (e.unstable_requestPaint = function () {}),
    (e.unstable_runWithPriority = function (I, b) {
      switch (I) {
        case 1:
        case 2:
        case 3:
        case 4:
        case 5:
          break;
        default:
          I = 3;
      }
      var M = p;
      p = I;
      try {
        return b();
      } finally {
        p = M;
      }
    }),
    (e.unstable_scheduleCallback = function (I, b, M) {
      var X = e.unstable_now();
      switch (
        (typeof M == "object" && M !== null
          ? ((M = M.delay), (M = typeof M == "number" && 0 < M ? X + M : X))
          : (M = X),
        I)
      ) {
        case 1:
          var ne = -1;
          break;
        case 2:
          ne = 250;
          break;
        case 5:
          ne = 1073741823;
          break;
        case 4:
          ne = 1e4;
          break;
        default:
          ne = 5e3;
      }
      return (
        (ne = M + ne),
        (I = {
          id: c++,
          callback: b,
          priorityLevel: I,
          startTime: M,
          expirationTime: ne,
          sortIndex: -1,
        }),
        M > X
          ? ((I.sortIndex = M),
            t(a, I),
            n(u) === null &&
              I === n(a) &&
              (m ? (h(O), (O = -1)) : (m = !0), Mt(w, M - X)))
          : ((I.sortIndex = ne), t(u, I), S || y || ((S = !0), Gn(E))),
        I
      );
    }),
    (e.unstable_shouldYield = z),
    (e.unstable_wrapCallback = function (I) {
      var b = p;
      return function () {
        var M = p;
        p = b;
        try {
          return I.apply(this, arguments);
        } finally {
          p = M;
        }
      };
    });
})(Md);
bd.exports = Md;
/**
 * @license React
 * react-dom.production.min.js
 *
 * Copyright (c) Facebook, Inc. and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */ var Ld = g.exports,
  Ie = bd.exports;
function T(e) {
  for (
    var t = "https://reactjs.org/docs/error-decoder.html?invariant=" + e, n = 1;
    n < arguments.length;
    n++
  )
    t += "&args[]=" + encodeURIComponent(arguments[n]);
  return (
    "Minified React error #" +
    e +
    "; visit " +
    t +
    " for the full message or use the non-minified dev environment for full errors and additional helpful warnings."
  );
}
var Fd = new Set(),
  Er = {};
function on(e, t) {
  Ln(e, t), Ln(e + "Capture", t);
}
function Ln(e, t) {
  for (Er[e] = t, e = 0; e < t.length; e++) Fd.add(t[e]);
}
var lt = !(
    typeof window == "undefined" ||
    typeof window.document == "undefined" ||
    typeof window.document.createElement == "undefined"
  ),
  bl = Object.prototype.hasOwnProperty,
  cg =
    /^[:A-Z_a-z\u00C0-\u00D6\u00D8-\u00F6\u00F8-\u02FF\u0370-\u037D\u037F-\u1FFF\u200C-\u200D\u2070-\u218F\u2C00-\u2FEF\u3001-\uD7FF\uF900-\uFDCF\uFDF0-\uFFFD][:A-Z_a-z\u00C0-\u00D6\u00D8-\u00F6\u00F8-\u02FF\u0370-\u037D\u037F-\u1FFF\u200C-\u200D\u2070-\u218F\u2C00-\u2FEF\u3001-\uD7FF\uF900-\uFDCF\uFDF0-\uFFFD\-.0-9\u00B7\u0300-\u036F\u203F-\u2040]*$/,
  va = {},
  ya = {};
function dg(e) {
  return bl.call(ya, e)
    ? !0
    : bl.call(va, e)
    ? !1
    : cg.test(e)
    ? (ya[e] = !0)
    : ((va[e] = !0), !1);
}
function fg(e, t, n, r) {
  if (n !== null && n.type === 0) return !1;
  switch (typeof t) {
    case "function":
    case "symbol":
      return !0;
    case "boolean":
      return r
        ? !1
        : n !== null
        ? !n.acceptsBooleans
        : ((e = e.toLowerCase().slice(0, 5)), e !== "data-" && e !== "aria-");
    default:
      return !1;
  }
}
function pg(e, t, n, r) {
  if (t === null || typeof t == "undefined" || fg(e, t, n, r)) return !0;
  if (r) return !1;
  if (n !== null)
    switch (n.type) {
      case 3:
        return !t;
      case 4:
        return t === !1;
      case 5:
        return isNaN(t);
      case 6:
        return isNaN(t) || 1 > t;
    }
  return !1;
}
function Se(e, t, n, r, o, i, l) {
  (this.acceptsBooleans = t === 2 || t === 3 || t === 4),
    (this.attributeName = r),
    (this.attributeNamespace = o),
    (this.mustUseProperty = n),
    (this.propertyName = e),
    (this.type = t),
    (this.sanitizeURL = i),
    (this.removeEmptyString = l);
}
var ue = {};
"children dangerouslySetInnerHTML defaultValue defaultChecked innerHTML suppressContentEditableWarning suppressHydrationWarning style"
  .split(" ")
  .forEach(function (e) {
    ue[e] = new Se(e, 0, !1, e, null, !1, !1);
  });
[
  ["acceptCharset", "accept-charset"],
  ["className", "class"],
  ["htmlFor", "for"],
  ["httpEquiv", "http-equiv"],
].forEach(function (e) {
  var t = e[0];
  ue[t] = new Se(t, 1, !1, e[1], null, !1, !1);
});
["contentEditable", "draggable", "spellCheck", "value"].forEach(function (e) {
  ue[e] = new Se(e, 2, !1, e.toLowerCase(), null, !1, !1);
});
[
  "autoReverse",
  "externalResourcesRequired",
  "focusable",
  "preserveAlpha",
].forEach(function (e) {
  ue[e] = new Se(e, 2, !1, e, null, !1, !1);
});
"allowFullScreen async autoFocus autoPlay controls default defer disabled disablePictureInPicture disableRemotePlayback formNoValidate hidden loop noModule noValidate open playsInline readOnly required reversed scoped seamless itemScope"
  .split(" ")
  .forEach(function (e) {
    ue[e] = new Se(e, 3, !1, e.toLowerCase(), null, !1, !1);
  });
["checked", "multiple", "muted", "selected"].forEach(function (e) {
  ue[e] = new Se(e, 3, !0, e, null, !1, !1);
});
["capture", "download"].forEach(function (e) {
  ue[e] = new Se(e, 4, !1, e, null, !1, !1);
});
["cols", "rows", "size", "span"].forEach(function (e) {
  ue[e] = new Se(e, 6, !1, e, null, !1, !1);
});
["rowSpan", "start"].forEach(function (e) {
  ue[e] = new Se(e, 5, !1, e.toLowerCase(), null, !1, !1);
});
var ou = /[\-:]([a-z])/g;
function iu(e) {
  return e[1].toUpperCase();
}
"accent-height alignment-baseline arabic-form baseline-shift cap-height clip-path clip-rule color-interpolation color-interpolation-filters color-profile color-rendering dominant-baseline enable-background fill-opacity fill-rule flood-color flood-opacity font-family font-size font-size-adjust font-stretch font-style font-variant font-weight glyph-name glyph-orientation-horizontal glyph-orientation-vertical horiz-adv-x horiz-origin-x image-rendering letter-spacing lighting-color marker-end marker-mid marker-start overline-position overline-thickness paint-order panose-1 pointer-events rendering-intent shape-rendering stop-color stop-opacity strikethrough-position strikethrough-thickness stroke-dasharray stroke-dashoffset stroke-linecap stroke-linejoin stroke-miterlimit stroke-opacity stroke-width text-anchor text-decoration text-rendering underline-position underline-thickness unicode-bidi unicode-range units-per-em v-alphabetic v-hanging v-ideographic v-mathematical vector-effect vert-adv-y vert-origin-x vert-origin-y word-spacing writing-mode xmlns:xlink x-height"
  .split(" ")
  .forEach(function (e) {
    var t = e.replace(ou, iu);
    ue[t] = new Se(t, 1, !1, e, null, !1, !1);
  });
"xlink:actuate xlink:arcrole xlink:role xlink:show xlink:title xlink:type"
  .split(" ")
  .forEach(function (e) {
    var t = e.replace(ou, iu);
    ue[t] = new Se(t, 1, !1, e, "http://www.w3.org/1999/xlink", !1, !1);
  });
["xml:base", "xml:lang", "xml:space"].forEach(function (e) {
  var t = e.replace(ou, iu);
  ue[t] = new Se(t, 1, !1, e, "http://www.w3.org/XML/1998/namespace", !1, !1);
});
["tabIndex", "crossOrigin"].forEach(function (e) {
  ue[e] = new Se(e, 1, !1, e.toLowerCase(), null, !1, !1);
});
ue.xlinkHref = new Se(
  "xlinkHref",
  1,
  !1,
  "xlink:href",
  "http://www.w3.org/1999/xlink",
  !0,
  !1
);
["src", "href", "action", "formAction"].forEach(function (e) {
  ue[e] = new Se(e, 1, !1, e.toLowerCase(), null, !0, !0);
});
function lu(e, t, n, r) {
  var o = ue.hasOwnProperty(t) ? ue[t] : null;
  (o !== null
    ? o.type !== 0
    : r ||
      !(2 < t.length) ||
      (t[0] !== "o" && t[0] !== "O") ||
      (t[1] !== "n" && t[1] !== "N")) &&
    (pg(t, n, o, r) && (n = null),
    r || o === null
      ? dg(t) && (n === null ? e.removeAttribute(t) : e.setAttribute(t, "" + n))
      : o.mustUseProperty
      ? (e[o.propertyName] = n === null ? (o.type === 3 ? !1 : "") : n)
      : ((t = o.attributeName),
        (r = o.attributeNamespace),
        n === null
          ? e.removeAttribute(t)
          : ((o = o.type),
            (n = o === 3 || (o === 4 && n === !0) ? "" : "" + n),
            r ? e.setAttributeNS(r, t, n) : e.setAttribute(t, n))));
}
var dt = Ld.__SECRET_INTERNALS_DO_NOT_USE_OR_YOU_WILL_BE_FIRED,
  no = Symbol.for("react.element"),
  mn = Symbol.for("react.portal"),
  vn = Symbol.for("react.fragment"),
  su = Symbol.for("react.strict_mode"),
  Ml = Symbol.for("react.profiler"),
  zd = Symbol.for("react.provider"),
  jd = Symbol.for("react.context"),
  uu = Symbol.for("react.forward_ref"),
  Ll = Symbol.for("react.suspense"),
  Fl = Symbol.for("react.suspense_list"),
  au = Symbol.for("react.memo"),
  pt = Symbol.for("react.lazy"),
  Ad = Symbol.for("react.offscreen"),
  Sa = Symbol.iterator;
function Kn(e) {
  return e === null || typeof e != "object"
    ? null
    : ((e = (Sa && e[Sa]) || e["@@iterator"]),
      typeof e == "function" ? e : null);
}
var K = Object.assign,
  Vi;
function ir(e) {
  if (Vi === void 0)
    try {
      throw Error();
    } catch (n) {
      var t = n.stack.trim().match(/\n( *(at )?)/);
      Vi = (t && t[1]) || "";
    }
  return (
    `
` +
    Vi +
    e
  );
}
var Qi = !1;
function Gi(e, t) {
  if (!e || Qi) return "";
  Qi = !0;
  var n = Error.prepareStackTrace;
  Error.prepareStackTrace = void 0;
  try {
    if (t)
      if (
        ((t = function () {
          throw Error();
        }),
        Object.defineProperty(t.prototype, "props", {
          set: function () {
            throw Error();
          },
        }),
        typeof Reflect == "object" && Reflect.construct)
      ) {
        try {
          Reflect.construct(t, []);
        } catch (a) {
          var r = a;
        }
        Reflect.construct(e, [], t);
      } else {
        try {
          t.call();
        } catch (a) {
          r = a;
        }
        e.call(t.prototype);
      }
    else {
      try {
        throw Error();
      } catch (a) {
        r = a;
      }
      e();
    }
  } catch (a) {
    if (a && r && typeof a.stack == "string") {
      for (
        var o = a.stack.split(`
`),
          i = r.stack.split(`
`),
          l = o.length - 1,
          s = i.length - 1;
        1 <= l && 0 <= s && o[l] !== i[s];

      )
        s--;
      for (; 1 <= l && 0 <= s; l--, s--)
        if (o[l] !== i[s]) {
          if (l !== 1 || s !== 1)
            do
              if ((l--, s--, 0 > s || o[l] !== i[s])) {
                var u =
                  `
` + o[l].replace(" at new ", " at ");
                return (
                  e.displayName &&
                    u.includes("<anonymous>") &&
                    (u = u.replace("<anonymous>", e.displayName)),
                  u
                );
              }
            while (1 <= l && 0 <= s);
          break;
        }
    }
  } finally {
    (Qi = !1), (Error.prepareStackTrace = n);
  }
  return (e = e ? e.displayName || e.name : "") ? ir(e) : "";
}
function hg(e) {
  switch (e.tag) {
    case 5:
      return ir(e.type);
    case 16:
      return ir("Lazy");
    case 13:
      return ir("Suspense");
    case 19:
      return ir("SuspenseList");
    case 0:
    case 2:
    case 15:
      return (e = Gi(e.type, !1)), e;
    case 11:
      return (e = Gi(e.type.render, !1)), e;
    case 1:
      return (e = Gi(e.type, !0)), e;
    default:
      return "";
  }
}
function zl(e) {
  if (e == null) return null;
  if (typeof e == "function") return e.displayName || e.name || null;
  if (typeof e == "string") return e;
  switch (e) {
    case vn:
      return "Fragment";
    case mn:
      return "Portal";
    case Ml:
      return "Profiler";
    case su:
      return "StrictMode";
    case Ll:
      return "Suspense";
    case Fl:
      return "SuspenseList";
  }
  if (typeof e == "object")
    switch (e.$$typeof) {
      case jd:
        return (e.displayName || "Context") + ".Consumer";
      case zd:
        return (e._context.displayName || "Context") + ".Provider";
      case uu:
        var t = e.render;
        return (
          (e = e.displayName),
          e ||
            ((e = t.displayName || t.name || ""),
            (e = e !== "" ? "ForwardRef(" + e + ")" : "ForwardRef")),
          e
        );
      case au:
        return (
          (t = e.displayName || null), t !== null ? t : zl(e.type) || "Memo"
        );
      case pt:
        (t = e._payload), (e = e._init);
        try {
          return zl(e(t));
        } catch {}
    }
  return null;
}
function gg(e) {
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
      return (
        (e = t.render),
        (e = e.displayName || e.name || ""),
        t.displayName || (e !== "" ? "ForwardRef(" + e + ")" : "ForwardRef")
      );
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
      return zl(t);
    case 8:
      return t === su ? "StrictMode" : "Mode";
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
      if (typeof t == "string") return t;
  }
  return null;
}
function Dt(e) {
  switch (typeof e) {
    case "boolean":
    case "number":
    case "string":
    case "undefined":
      return e;
    case "object":
      return e;
    default:
      return "";
  }
}
function Bd(e) {
  var t = e.type;
  return (
    (e = e.nodeName) &&
    e.toLowerCase() === "input" &&
    (t === "checkbox" || t === "radio")
  );
}
function mg(e) {
  var t = Bd(e) ? "checked" : "value",
    n = Object.getOwnPropertyDescriptor(e.constructor.prototype, t),
    r = "" + e[t];
  if (
    !e.hasOwnProperty(t) &&
    typeof n != "undefined" &&
    typeof n.get == "function" &&
    typeof n.set == "function"
  ) {
    var o = n.get,
      i = n.set;
    return (
      Object.defineProperty(e, t, {
        configurable: !0,
        get: function () {
          return o.call(this);
        },
        set: function (l) {
          (r = "" + l), i.call(this, l);
        },
      }),
      Object.defineProperty(e, t, { enumerable: n.enumerable }),
      {
        getValue: function () {
          return r;
        },
        setValue: function (l) {
          r = "" + l;
        },
        stopTracking: function () {
          (e._valueTracker = null), delete e[t];
        },
      }
    );
  }
}
function ro(e) {
  e._valueTracker || (e._valueTracker = mg(e));
}
function Ud(e) {
  if (!e) return !1;
  var t = e._valueTracker;
  if (!t) return !0;
  var n = t.getValue(),
    r = "";
  return (
    e && (r = Bd(e) ? (e.checked ? "true" : "false") : e.value),
    (e = r),
    e !== n ? (t.setValue(e), !0) : !1
  );
}
function Ho(e) {
  if (
    ((e = e || (typeof document != "undefined" ? document : void 0)),
    typeof e == "undefined")
  )
    return null;
  try {
    return e.activeElement || e.body;
  } catch {
    return e.body;
  }
}
function jl(e, t) {
  var n = t.checked;
  return K({}, t, {
    defaultChecked: void 0,
    defaultValue: void 0,
    value: void 0,
    checked: n != null ? n : e._wrapperState.initialChecked,
  });
}
function wa(e, t) {
  var n = t.defaultValue == null ? "" : t.defaultValue,
    r = t.checked != null ? t.checked : t.defaultChecked;
  (n = Dt(t.value != null ? t.value : n)),
    (e._wrapperState = {
      initialChecked: r,
      initialValue: n,
      controlled:
        t.type === "checkbox" || t.type === "radio"
          ? t.checked != null
          : t.value != null,
    });
}
function Wd(e, t) {
  (t = t.checked), t != null && lu(e, "checked", t, !1);
}
function Al(e, t) {
  Wd(e, t);
  var n = Dt(t.value),
    r = t.type;
  if (n != null)
    r === "number"
      ? ((n === 0 && e.value === "") || e.value != n) && (e.value = "" + n)
      : e.value !== "" + n && (e.value = "" + n);
  else if (r === "submit" || r === "reset") {
    e.removeAttribute("value");
    return;
  }
  t.hasOwnProperty("value")
    ? Bl(e, t.type, n)
    : t.hasOwnProperty("defaultValue") && Bl(e, t.type, Dt(t.defaultValue)),
    t.checked == null &&
      t.defaultChecked != null &&
      (e.defaultChecked = !!t.defaultChecked);
}
function xa(e, t, n) {
  if (t.hasOwnProperty("value") || t.hasOwnProperty("defaultValue")) {
    var r = t.type;
    if (
      !(
        (r !== "submit" && r !== "reset") ||
        (t.value !== void 0 && t.value !== null)
      )
    )
      return;
    (t = "" + e._wrapperState.initialValue),
      n || t === e.value || (e.value = t),
      (e.defaultValue = t);
  }
  (n = e.name),
    n !== "" && (e.name = ""),
    (e.defaultChecked = !!e._wrapperState.initialChecked),
    n !== "" && (e.name = n);
}
function Bl(e, t, n) {
  (t !== "number" || Ho(e.ownerDocument) !== e) &&
    (n == null
      ? (e.defaultValue = "" + e._wrapperState.initialValue)
      : e.defaultValue !== "" + n && (e.defaultValue = "" + n));
}
var lr = Array.isArray;
function Dn(e, t, n, r) {
  if (((e = e.options), t)) {
    t = {};
    for (var o = 0; o < n.length; o++) t["$" + n[o]] = !0;
    for (n = 0; n < e.length; n++)
      (o = t.hasOwnProperty("$" + e[n].value)),
        e[n].selected !== o && (e[n].selected = o),
        o && r && (e[n].defaultSelected = !0);
  } else {
    for (n = "" + Dt(n), t = null, o = 0; o < e.length; o++) {
      if (e[o].value === n) {
        (e[o].selected = !0), r && (e[o].defaultSelected = !0);
        return;
      }
      t !== null || e[o].disabled || (t = e[o]);
    }
    t !== null && (t.selected = !0);
  }
}
function Ul(e, t) {
  if (t.dangerouslySetInnerHTML != null) throw Error(T(91));
  return K({}, t, {
    value: void 0,
    defaultValue: void 0,
    children: "" + e._wrapperState.initialValue,
  });
}
function Ea(e, t) {
  var n = t.value;
  if (n == null) {
    if (((n = t.children), (t = t.defaultValue), n != null)) {
      if (t != null) throw Error(T(92));
      if (lr(n)) {
        if (1 < n.length) throw Error(T(93));
        n = n[0];
      }
      t = n;
    }
    t == null && (t = ""), (n = t);
  }
  e._wrapperState = { initialValue: Dt(n) };
}
function Hd(e, t) {
  var n = Dt(t.value),
    r = Dt(t.defaultValue);
  n != null &&
    ((n = "" + n),
    n !== e.value && (e.value = n),
    t.defaultValue == null && e.defaultValue !== n && (e.defaultValue = n)),
    r != null && (e.defaultValue = "" + r);
}
function Ca(e) {
  var t = e.textContent;
  t === e._wrapperState.initialValue && t !== "" && t !== null && (e.value = t);
}
function Vd(e) {
  switch (e) {
    case "svg":
      return "http://www.w3.org/2000/svg";
    case "math":
      return "http://www.w3.org/1998/Math/MathML";
    default:
      return "http://www.w3.org/1999/xhtml";
  }
}
function Wl(e, t) {
  return e == null || e === "http://www.w3.org/1999/xhtml"
    ? Vd(t)
    : e === "http://www.w3.org/2000/svg" && t === "foreignObject"
    ? "http://www.w3.org/1999/xhtml"
    : e;
}
var oo,
  Qd = (function (e) {
    return typeof MSApp != "undefined" && MSApp.execUnsafeLocalFunction
      ? function (t, n, r, o) {
          MSApp.execUnsafeLocalFunction(function () {
            return e(t, n, r, o);
          });
        }
      : e;
  })(function (e, t) {
    if (e.namespaceURI !== "http://www.w3.org/2000/svg" || "innerHTML" in e)
      e.innerHTML = t;
    else {
      for (
        oo = oo || document.createElement("div"),
          oo.innerHTML = "<svg>" + t.valueOf().toString() + "</svg>",
          t = oo.firstChild;
        e.firstChild;

      )
        e.removeChild(e.firstChild);
      for (; t.firstChild; ) e.appendChild(t.firstChild);
    }
  });
function Cr(e, t) {
  if (t) {
    var n = e.firstChild;
    if (n && n === e.lastChild && n.nodeType === 3) {
      n.nodeValue = t;
      return;
    }
  }
  e.textContent = t;
}
var cr = {
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
    strokeWidth: !0,
  },
  vg = ["Webkit", "ms", "Moz", "O"];
Object.keys(cr).forEach(function (e) {
  vg.forEach(function (t) {
    (t = t + e.charAt(0).toUpperCase() + e.substring(1)), (cr[t] = cr[e]);
  });
});
function Gd(e, t, n) {
  return t == null || typeof t == "boolean" || t === ""
    ? ""
    : n || typeof t != "number" || t === 0 || (cr.hasOwnProperty(e) && cr[e])
    ? ("" + t).trim()
    : t + "px";
}
function Kd(e, t) {
  e = e.style;
  for (var n in t)
    if (t.hasOwnProperty(n)) {
      var r = n.indexOf("--") === 0,
        o = Gd(n, t[n], r);
      n === "float" && (n = "cssFloat"), r ? e.setProperty(n, o) : (e[n] = o);
    }
}
var yg = K(
  { menuitem: !0 },
  {
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
    wbr: !0,
  }
);
function Hl(e, t) {
  if (t) {
    if (yg[e] && (t.children != null || t.dangerouslySetInnerHTML != null))
      throw Error(T(137, e));
    if (t.dangerouslySetInnerHTML != null) {
      if (t.children != null) throw Error(T(60));
      if (
        typeof t.dangerouslySetInnerHTML != "object" ||
        !("__html" in t.dangerouslySetInnerHTML)
      )
        throw Error(T(61));
    }
    if (t.style != null && typeof t.style != "object") throw Error(T(62));
  }
}
function Vl(e, t) {
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
      return !0;
  }
}
var Ql = null;
function cu(e) {
  return (
    (e = e.target || e.srcElement || window),
    e.correspondingUseElement && (e = e.correspondingUseElement),
    e.nodeType === 3 ? e.parentNode : e
  );
}
var Gl = null,
  $n = null,
  Rn = null;
function ka(e) {
  if ((e = Qr(e))) {
    if (typeof Gl != "function") throw Error(T(280));
    var t = e.stateNode;
    t && ((t = wi(t)), Gl(e.stateNode, e.type, t));
  }
}
function Yd(e) {
  $n ? (Rn ? Rn.push(e) : (Rn = [e])) : ($n = e);
}
function Xd() {
  if ($n) {
    var e = $n,
      t = Rn;
    if (((Rn = $n = null), ka(e), t)) for (e = 0; e < t.length; e++) ka(t[e]);
  }
}
function Zd(e, t) {
  return e(t);
}
function qd() {}
var Ki = !1;
function Jd(e, t, n) {
  if (Ki) return e(t, n);
  Ki = !0;
  try {
    return Zd(e, t, n);
  } finally {
    (Ki = !1), ($n !== null || Rn !== null) && (qd(), Xd());
  }
}
function kr(e, t) {
  var n = e.stateNode;
  if (n === null) return null;
  var r = wi(n);
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
      (r = !r.disabled) ||
        ((e = e.type),
        (r = !(
          e === "button" ||
          e === "input" ||
          e === "select" ||
          e === "textarea"
        ))),
        (e = !r);
      break e;
    default:
      e = !1;
  }
  if (e) return null;
  if (n && typeof n != "function") throw Error(T(231, t, typeof n));
  return n;
}
var Kl = !1;
if (lt)
  try {
    var Yn = {};
    Object.defineProperty(Yn, "passive", {
      get: function () {
        Kl = !0;
      },
    }),
      window.addEventListener("test", Yn, Yn),
      window.removeEventListener("test", Yn, Yn);
  } catch {
    Kl = !1;
  }
function Sg(e, t, n, r, o, i, l, s, u) {
  var a = Array.prototype.slice.call(arguments, 3);
  try {
    t.apply(n, a);
  } catch (c) {
    this.onError(c);
  }
}
var dr = !1,
  Vo = null,
  Qo = !1,
  Yl = null,
  wg = {
    onError: function (e) {
      (dr = !0), (Vo = e);
    },
  };
function xg(e, t, n, r, o, i, l, s, u) {
  (dr = !1), (Vo = null), Sg.apply(wg, arguments);
}
function Eg(e, t, n, r, o, i, l, s, u) {
  if ((xg.apply(this, arguments), dr)) {
    if (dr) {
      var a = Vo;
      (dr = !1), (Vo = null);
    } else throw Error(T(198));
    Qo || ((Qo = !0), (Yl = a));
  }
}
function ln(e) {
  var t = e,
    n = e;
  if (e.alternate) for (; t.return; ) t = t.return;
  else {
    e = t;
    do (t = e), (t.flags & 4098) !== 0 && (n = t.return), (e = t.return);
    while (e);
  }
  return t.tag === 3 ? n : null;
}
function ef(e) {
  if (e.tag === 13) {
    var t = e.memoizedState;
    if (
      (t === null && ((e = e.alternate), e !== null && (t = e.memoizedState)),
      t !== null)
    )
      return t.dehydrated;
  }
  return null;
}
function Oa(e) {
  if (ln(e) !== e) throw Error(T(188));
}
function Cg(e) {
  var t = e.alternate;
  if (!t) {
    if (((t = ln(e)), t === null)) throw Error(T(188));
    return t !== e ? null : e;
  }
  for (var n = e, r = t; ; ) {
    var o = n.return;
    if (o === null) break;
    var i = o.alternate;
    if (i === null) {
      if (((r = o.return), r !== null)) {
        n = r;
        continue;
      }
      break;
    }
    if (o.child === i.child) {
      for (i = o.child; i; ) {
        if (i === n) return Oa(o), e;
        if (i === r) return Oa(o), t;
        i = i.sibling;
      }
      throw Error(T(188));
    }
    if (n.return !== r.return) (n = o), (r = i);
    else {
      for (var l = !1, s = o.child; s; ) {
        if (s === n) {
          (l = !0), (n = o), (r = i);
          break;
        }
        if (s === r) {
          (l = !0), (r = o), (n = i);
          break;
        }
        s = s.sibling;
      }
      if (!l) {
        for (s = i.child; s; ) {
          if (s === n) {
            (l = !0), (n = i), (r = o);
            break;
          }
          if (s === r) {
            (l = !0), (r = i), (n = o);
            break;
          }
          s = s.sibling;
        }
        if (!l) throw Error(T(189));
      }
    }
    if (n.alternate !== r) throw Error(T(190));
  }
  if (n.tag !== 3) throw Error(T(188));
  return n.stateNode.current === n ? e : t;
}
function tf(e) {
  return (e = Cg(e)), e !== null ? nf(e) : null;
}
function nf(e) {
  if (e.tag === 5 || e.tag === 6) return e;
  for (e = e.child; e !== null; ) {
    var t = nf(e);
    if (t !== null) return t;
    e = e.sibling;
  }
  return null;
}
var rf = Ie.unstable_scheduleCallback,
  Ta = Ie.unstable_cancelCallback,
  kg = Ie.unstable_shouldYield,
  Og = Ie.unstable_requestPaint,
  Z = Ie.unstable_now,
  Tg = Ie.unstable_getCurrentPriorityLevel,
  du = Ie.unstable_ImmediatePriority,
  of = Ie.unstable_UserBlockingPriority,
  Go = Ie.unstable_NormalPriority,
  Pg = Ie.unstable_LowPriority,
  lf = Ie.unstable_IdlePriority,
  mi = null,
  qe = null;
function Ig(e) {
  if (qe && typeof qe.onCommitFiberRoot == "function")
    try {
      qe.onCommitFiberRoot(mi, e, void 0, (e.current.flags & 128) === 128);
    } catch {}
}
var Ve = Math.clz32 ? Math.clz32 : Rg,
  Dg = Math.log,
  $g = Math.LN2;
function Rg(e) {
  return (e >>>= 0), e === 0 ? 32 : (31 - ((Dg(e) / $g) | 0)) | 0;
}
var io = 64,
  lo = 4194304;
function sr(e) {
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
      return e;
  }
}
function Ko(e, t) {
  var n = e.pendingLanes;
  if (n === 0) return 0;
  var r = 0,
    o = e.suspendedLanes,
    i = e.pingedLanes,
    l = n & 268435455;
  if (l !== 0) {
    var s = l & ~o;
    s !== 0 ? (r = sr(s)) : ((i &= l), i !== 0 && (r = sr(i)));
  } else (l = n & ~o), l !== 0 ? (r = sr(l)) : i !== 0 && (r = sr(i));
  if (r === 0) return 0;
  if (
    t !== 0 &&
    t !== r &&
    (t & o) === 0 &&
    ((o = r & -r), (i = t & -t), o >= i || (o === 16 && (i & 4194240) !== 0))
  )
    return t;
  if (((r & 4) !== 0 && (r |= n & 16), (t = e.entangledLanes), t !== 0))
    for (e = e.entanglements, t &= r; 0 < t; )
      (n = 31 - Ve(t)), (o = 1 << n), (r |= e[n]), (t &= ~o);
  return r;
}
function _g(e, t) {
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
      return -1;
  }
}
function Ng(e, t) {
  for (
    var n = e.suspendedLanes,
      r = e.pingedLanes,
      o = e.expirationTimes,
      i = e.pendingLanes;
    0 < i;

  ) {
    var l = 31 - Ve(i),
      s = 1 << l,
      u = o[l];
    u === -1
      ? ((s & n) === 0 || (s & r) !== 0) && (o[l] = _g(s, t))
      : u <= t && (e.expiredLanes |= s),
      (i &= ~s);
  }
}
function Xl(e) {
  return (
    (e = e.pendingLanes & -1073741825),
    e !== 0 ? e : e & 1073741824 ? 1073741824 : 0
  );
}
function sf() {
  var e = io;
  return (io <<= 1), (io & 4194240) === 0 && (io = 64), e;
}
function Yi(e) {
  for (var t = [], n = 0; 31 > n; n++) t.push(e);
  return t;
}
function Hr(e, t, n) {
  (e.pendingLanes |= t),
    t !== 536870912 && ((e.suspendedLanes = 0), (e.pingedLanes = 0)),
    (e = e.eventTimes),
    (t = 31 - Ve(t)),
    (e[t] = n);
}
function bg(e, t) {
  var n = e.pendingLanes & ~t;
  (e.pendingLanes = t),
    (e.suspendedLanes = 0),
    (e.pingedLanes = 0),
    (e.expiredLanes &= t),
    (e.mutableReadLanes &= t),
    (e.entangledLanes &= t),
    (t = e.entanglements);
  var r = e.eventTimes;
  for (e = e.expirationTimes; 0 < n; ) {
    var o = 31 - Ve(n),
      i = 1 << o;
    (t[o] = 0), (r[o] = -1), (e[o] = -1), (n &= ~i);
  }
}
function fu(e, t) {
  var n = (e.entangledLanes |= t);
  for (e = e.entanglements; n; ) {
    var r = 31 - Ve(n),
      o = 1 << r;
    (o & t) | (e[r] & t) && (e[r] |= t), (n &= ~o);
  }
}
var A = 0;
function uf(e) {
  return (
    (e &= -e),
    1 < e ? (4 < e ? ((e & 268435455) !== 0 ? 16 : 536870912) : 4) : 1
  );
}
var af,
  pu,
  cf,
  df,
  ff,
  Zl = !1,
  so = [],
  wt = null,
  xt = null,
  Et = null,
  Or = new Map(),
  Tr = new Map(),
  gt = [],
  Mg =
    "mousedown mouseup touchcancel touchend touchstart auxclick dblclick pointercancel pointerdown pointerup dragend dragstart drop compositionend compositionstart keydown keypress keyup input textInput copy cut paste click change contextmenu reset submit".split(
      " "
    );
function Pa(e, t) {
  switch (e) {
    case "focusin":
    case "focusout":
      wt = null;
      break;
    case "dragenter":
    case "dragleave":
      xt = null;
      break;
    case "mouseover":
    case "mouseout":
      Et = null;
      break;
    case "pointerover":
    case "pointerout":
      Or.delete(t.pointerId);
      break;
    case "gotpointercapture":
    case "lostpointercapture":
      Tr.delete(t.pointerId);
  }
}
function Xn(e, t, n, r, o, i) {
  return e === null || e.nativeEvent !== i
    ? ((e = {
        blockedOn: t,
        domEventName: n,
        eventSystemFlags: r,
        nativeEvent: i,
        targetContainers: [o],
      }),
      t !== null && ((t = Qr(t)), t !== null && pu(t)),
      e)
    : ((e.eventSystemFlags |= r),
      (t = e.targetContainers),
      o !== null && t.indexOf(o) === -1 && t.push(o),
      e);
}
function Lg(e, t, n, r, o) {
  switch (t) {
    case "focusin":
      return (wt = Xn(wt, e, t, n, r, o)), !0;
    case "dragenter":
      return (xt = Xn(xt, e, t, n, r, o)), !0;
    case "mouseover":
      return (Et = Xn(Et, e, t, n, r, o)), !0;
    case "pointerover":
      var i = o.pointerId;
      return Or.set(i, Xn(Or.get(i) || null, e, t, n, r, o)), !0;
    case "gotpointercapture":
      return (
        (i = o.pointerId), Tr.set(i, Xn(Tr.get(i) || null, e, t, n, r, o)), !0
      );
  }
  return !1;
}
function pf(e) {
  var t = Ut(e.target);
  if (t !== null) {
    var n = ln(t);
    if (n !== null) {
      if (((t = n.tag), t === 13)) {
        if (((t = ef(n)), t !== null)) {
          (e.blockedOn = t),
            ff(e.priority, function () {
              cf(n);
            });
          return;
        }
      } else if (t === 3 && n.stateNode.current.memoizedState.isDehydrated) {
        e.blockedOn = n.tag === 3 ? n.stateNode.containerInfo : null;
        return;
      }
    }
  }
  e.blockedOn = null;
}
function Io(e) {
  if (e.blockedOn !== null) return !1;
  for (var t = e.targetContainers; 0 < t.length; ) {
    var n = ql(e.domEventName, e.eventSystemFlags, t[0], e.nativeEvent);
    if (n === null) {
      n = e.nativeEvent;
      var r = new n.constructor(n.type, n);
      (Ql = r), n.target.dispatchEvent(r), (Ql = null);
    } else return (t = Qr(n)), t !== null && pu(t), (e.blockedOn = n), !1;
    t.shift();
  }
  return !0;
}
function Ia(e, t, n) {
  Io(e) && n.delete(t);
}
function Fg() {
  (Zl = !1),
    wt !== null && Io(wt) && (wt = null),
    xt !== null && Io(xt) && (xt = null),
    Et !== null && Io(Et) && (Et = null),
    Or.forEach(Ia),
    Tr.forEach(Ia);
}
function Zn(e, t) {
  e.blockedOn === t &&
    ((e.blockedOn = null),
    Zl ||
      ((Zl = !0),
      Ie.unstable_scheduleCallback(Ie.unstable_NormalPriority, Fg)));
}
function Pr(e) {
  function t(o) {
    return Zn(o, e);
  }
  if (0 < so.length) {
    Zn(so[0], e);
    for (var n = 1; n < so.length; n++) {
      var r = so[n];
      r.blockedOn === e && (r.blockedOn = null);
    }
  }
  for (
    wt !== null && Zn(wt, e),
      xt !== null && Zn(xt, e),
      Et !== null && Zn(Et, e),
      Or.forEach(t),
      Tr.forEach(t),
      n = 0;
    n < gt.length;
    n++
  )
    (r = gt[n]), r.blockedOn === e && (r.blockedOn = null);
  for (; 0 < gt.length && ((n = gt[0]), n.blockedOn === null); )
    pf(n), n.blockedOn === null && gt.shift();
}
var _n = dt.ReactCurrentBatchConfig,
  Yo = !0;
function zg(e, t, n, r) {
  var o = A,
    i = _n.transition;
  _n.transition = null;
  try {
    (A = 1), hu(e, t, n, r);
  } finally {
    (A = o), (_n.transition = i);
  }
}
function jg(e, t, n, r) {
  var o = A,
    i = _n.transition;
  _n.transition = null;
  try {
    (A = 4), hu(e, t, n, r);
  } finally {
    (A = o), (_n.transition = i);
  }
}
function hu(e, t, n, r) {
  if (Yo) {
    var o = ql(e, t, n, r);
    if (o === null) il(e, t, r, Xo, n), Pa(e, r);
    else if (Lg(o, e, t, n, r)) r.stopPropagation();
    else if ((Pa(e, r), t & 4 && -1 < Mg.indexOf(e))) {
      for (; o !== null; ) {
        var i = Qr(o);
        if (
          (i !== null && af(i),
          (i = ql(e, t, n, r)),
          i === null && il(e, t, r, Xo, n),
          i === o)
        )
          break;
        o = i;
      }
      o !== null && r.stopPropagation();
    } else il(e, t, r, null, n);
  }
}
var Xo = null;
function ql(e, t, n, r) {
  if (((Xo = null), (e = cu(r)), (e = Ut(e)), e !== null))
    if (((t = ln(e)), t === null)) e = null;
    else if (((n = t.tag), n === 13)) {
      if (((e = ef(t)), e !== null)) return e;
      e = null;
    } else if (n === 3) {
      if (t.stateNode.current.memoizedState.isDehydrated)
        return t.tag === 3 ? t.stateNode.containerInfo : null;
      e = null;
    } else t !== e && (e = null);
  return (Xo = e), null;
}
function hf(e) {
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
      switch (Tg()) {
        case du:
          return 1;
        case of:
          return 4;
        case Go:
        case Pg:
          return 16;
        case lf:
          return 536870912;
        default:
          return 16;
      }
    default:
      return 16;
  }
}
var vt = null,
  gu = null,
  Do = null;
function gf() {
  if (Do) return Do;
  var e,
    t = gu,
    n = t.length,
    r,
    o = "value" in vt ? vt.value : vt.textContent,
    i = o.length;
  for (e = 0; e < n && t[e] === o[e]; e++);
  var l = n - e;
  for (r = 1; r <= l && t[n - r] === o[i - r]; r++);
  return (Do = o.slice(e, 1 < r ? 1 - r : void 0));
}
function $o(e) {
  var t = e.keyCode;
  return (
    "charCode" in e
      ? ((e = e.charCode), e === 0 && t === 13 && (e = 13))
      : (e = t),
    e === 10 && (e = 13),
    32 <= e || e === 13 ? e : 0
  );
}
function uo() {
  return !0;
}
function Da() {
  return !1;
}
function Re(e) {
  function t(n, r, o, i, l) {
    (this._reactName = n),
      (this._targetInst = o),
      (this.type = r),
      (this.nativeEvent = i),
      (this.target = l),
      (this.currentTarget = null);
    for (var s in e)
      e.hasOwnProperty(s) && ((n = e[s]), (this[s] = n ? n(i) : i[s]));
    return (
      (this.isDefaultPrevented = (
        i.defaultPrevented != null ? i.defaultPrevented : i.returnValue === !1
      )
        ? uo
        : Da),
      (this.isPropagationStopped = Da),
      this
    );
  }
  return (
    K(t.prototype, {
      preventDefault: function () {
        this.defaultPrevented = !0;
        var n = this.nativeEvent;
        n &&
          (n.preventDefault
            ? n.preventDefault()
            : typeof n.returnValue != "unknown" && (n.returnValue = !1),
          (this.isDefaultPrevented = uo));
      },
      stopPropagation: function () {
        var n = this.nativeEvent;
        n &&
          (n.stopPropagation
            ? n.stopPropagation()
            : typeof n.cancelBubble != "unknown" && (n.cancelBubble = !0),
          (this.isPropagationStopped = uo));
      },
      persist: function () {},
      isPersistent: uo,
    }),
    t
  );
}
var Hn = {
    eventPhase: 0,
    bubbles: 0,
    cancelable: 0,
    timeStamp: function (e) {
      return e.timeStamp || Date.now();
    },
    defaultPrevented: 0,
    isTrusted: 0,
  },
  mu = Re(Hn),
  Vr = K({}, Hn, { view: 0, detail: 0 }),
  Ag = Re(Vr),
  Xi,
  Zi,
  qn,
  vi = K({}, Vr, {
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
    getModifierState: vu,
    button: 0,
    buttons: 0,
    relatedTarget: function (e) {
      return e.relatedTarget === void 0
        ? e.fromElement === e.srcElement
          ? e.toElement
          : e.fromElement
        : e.relatedTarget;
    },
    movementX: function (e) {
      return "movementX" in e
        ? e.movementX
        : (e !== qn &&
            (qn && e.type === "mousemove"
              ? ((Xi = e.screenX - qn.screenX), (Zi = e.screenY - qn.screenY))
              : (Zi = Xi = 0),
            (qn = e)),
          Xi);
    },
    movementY: function (e) {
      return "movementY" in e ? e.movementY : Zi;
    },
  }),
  $a = Re(vi),
  Bg = K({}, vi, { dataTransfer: 0 }),
  Ug = Re(Bg),
  Wg = K({}, Vr, { relatedTarget: 0 }),
  qi = Re(Wg),
  Hg = K({}, Hn, { animationName: 0, elapsedTime: 0, pseudoElement: 0 }),
  Vg = Re(Hg),
  Qg = K({}, Hn, {
    clipboardData: function (e) {
      return "clipboardData" in e ? e.clipboardData : window.clipboardData;
    },
  }),
  Gg = Re(Qg),
  Kg = K({}, Hn, { data: 0 }),
  Ra = Re(Kg),
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
    MozPrintableKey: "Unidentified",
  },
  Xg = {
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
    224: "Meta",
  },
  Zg = {
    Alt: "altKey",
    Control: "ctrlKey",
    Meta: "metaKey",
    Shift: "shiftKey",
  };
function qg(e) {
  var t = this.nativeEvent;
  return t.getModifierState ? t.getModifierState(e) : (e = Zg[e]) ? !!t[e] : !1;
}
function vu() {
  return qg;
}
var Jg = K({}, Vr, {
    key: function (e) {
      if (e.key) {
        var t = Yg[e.key] || e.key;
        if (t !== "Unidentified") return t;
      }
      return e.type === "keypress"
        ? ((e = $o(e)), e === 13 ? "Enter" : String.fromCharCode(e))
        : e.type === "keydown" || e.type === "keyup"
        ? Xg[e.keyCode] || "Unidentified"
        : "";
    },
    code: 0,
    location: 0,
    ctrlKey: 0,
    shiftKey: 0,
    altKey: 0,
    metaKey: 0,
    repeat: 0,
    locale: 0,
    getModifierState: vu,
    charCode: function (e) {
      return e.type === "keypress" ? $o(e) : 0;
    },
    keyCode: function (e) {
      return e.type === "keydown" || e.type === "keyup" ? e.keyCode : 0;
    },
    which: function (e) {
      return e.type === "keypress"
        ? $o(e)
        : e.type === "keydown" || e.type === "keyup"
        ? e.keyCode
        : 0;
    },
  }),
  em = Re(Jg),
  tm = K({}, vi, {
    pointerId: 0,
    width: 0,
    height: 0,
    pressure: 0,
    tangentialPressure: 0,
    tiltX: 0,
    tiltY: 0,
    twist: 0,
    pointerType: 0,
    isPrimary: 0,
  }),
  _a = Re(tm),
  nm = K({}, Vr, {
    touches: 0,
    targetTouches: 0,
    changedTouches: 0,
    altKey: 0,
    metaKey: 0,
    ctrlKey: 0,
    shiftKey: 0,
    getModifierState: vu,
  }),
  rm = Re(nm),
  om = K({}, Hn, { propertyName: 0, elapsedTime: 0, pseudoElement: 0 }),
  im = Re(om),
  lm = K({}, vi, {
    deltaX: function (e) {
      return "deltaX" in e ? e.deltaX : "wheelDeltaX" in e ? -e.wheelDeltaX : 0;
    },
    deltaY: function (e) {
      return "deltaY" in e
        ? e.deltaY
        : "wheelDeltaY" in e
        ? -e.wheelDeltaY
        : "wheelDelta" in e
        ? -e.wheelDelta
        : 0;
    },
    deltaZ: 0,
    deltaMode: 0,
  }),
  sm = Re(lm),
  um = [9, 13, 27, 32],
  yu = lt && "CompositionEvent" in window,
  fr = null;
lt && "documentMode" in document && (fr = document.documentMode);
var am = lt && "TextEvent" in window && !fr,
  mf = lt && (!yu || (fr && 8 < fr && 11 >= fr)),
  Na = String.fromCharCode(32),
  ba = !1;
function vf(e, t) {
  switch (e) {
    case "keyup":
      return um.indexOf(t.keyCode) !== -1;
    case "keydown":
      return t.keyCode !== 229;
    case "keypress":
    case "mousedown":
    case "focusout":
      return !0;
    default:
      return !1;
  }
}
function yf(e) {
  return (e = e.detail), typeof e == "object" && "data" in e ? e.data : null;
}
var yn = !1;
function cm(e, t) {
  switch (e) {
    case "compositionend":
      return yf(t);
    case "keypress":
      return t.which !== 32 ? null : ((ba = !0), Na);
    case "textInput":
      return (e = t.data), e === Na && ba ? null : e;
    default:
      return null;
  }
}
function dm(e, t) {
  if (yn)
    return e === "compositionend" || (!yu && vf(e, t))
      ? ((e = gf()), (Do = gu = vt = null), (yn = !1), e)
      : null;
  switch (e) {
    case "paste":
      return null;
    case "keypress":
      if (!(t.ctrlKey || t.altKey || t.metaKey) || (t.ctrlKey && t.altKey)) {
        if (t.char && 1 < t.char.length) return t.char;
        if (t.which) return String.fromCharCode(t.which);
      }
      return null;
    case "compositionend":
      return mf && t.locale !== "ko" ? null : t.data;
    default:
      return null;
  }
}
var fm = {
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
  week: !0,
};
function Ma(e) {
  var t = e && e.nodeName && e.nodeName.toLowerCase();
  return t === "input" ? !!fm[e.type] : t === "textarea";
}
function Sf(e, t, n, r) {
  Yd(r),
    (t = Zo(t, "onChange")),
    0 < t.length &&
      ((n = new mu("onChange", "change", null, n, r)),
      e.push({ event: n, listeners: t }));
}
var pr = null,
  Ir = null;
function pm(e) {
  $f(e, 0);
}
function yi(e) {
  var t = xn(e);
  if (Ud(t)) return e;
}
function hm(e, t) {
  if (e === "change") return t;
}
var wf = !1;
if (lt) {
  var Ji;
  if (lt) {
    var el = "oninput" in document;
    if (!el) {
      var La = document.createElement("div");
      La.setAttribute("oninput", "return;"),
        (el = typeof La.oninput == "function");
    }
    Ji = el;
  } else Ji = !1;
  wf = Ji && (!document.documentMode || 9 < document.documentMode);
}
function Fa() {
  pr && (pr.detachEvent("onpropertychange", xf), (Ir = pr = null));
}
function xf(e) {
  if (e.propertyName === "value" && yi(Ir)) {
    var t = [];
    Sf(t, Ir, e, cu(e)), Jd(pm, t);
  }
}
function gm(e, t, n) {
  e === "focusin"
    ? (Fa(), (pr = t), (Ir = n), pr.attachEvent("onpropertychange", xf))
    : e === "focusout" && Fa();
}
function mm(e) {
  if (e === "selectionchange" || e === "keyup" || e === "keydown")
    return yi(Ir);
}
function vm(e, t) {
  if (e === "click") return yi(t);
}
function ym(e, t) {
  if (e === "input" || e === "change") return yi(t);
}
function Sm(e, t) {
  return (e === t && (e !== 0 || 1 / e === 1 / t)) || (e !== e && t !== t);
}
var Ge = typeof Object.is == "function" ? Object.is : Sm;
function Dr(e, t) {
  if (Ge(e, t)) return !0;
  if (typeof e != "object" || e === null || typeof t != "object" || t === null)
    return !1;
  var n = Object.keys(e),
    r = Object.keys(t);
  if (n.length !== r.length) return !1;
  for (r = 0; r < n.length; r++) {
    var o = n[r];
    if (!bl.call(t, o) || !Ge(e[o], t[o])) return !1;
  }
  return !0;
}
function za(e) {
  for (; e && e.firstChild; ) e = e.firstChild;
  return e;
}
function ja(e, t) {
  var n = za(e);
  e = 0;
  for (var r; n; ) {
    if (n.nodeType === 3) {
      if (((r = e + n.textContent.length), e <= t && r >= t))
        return { node: n, offset: t - e };
      e = r;
    }
    e: {
      for (; n; ) {
        if (n.nextSibling) {
          n = n.nextSibling;
          break e;
        }
        n = n.parentNode;
      }
      n = void 0;
    }
    n = za(n);
  }
}
function Ef(e, t) {
  return e && t
    ? e === t
      ? !0
      : e && e.nodeType === 3
      ? !1
      : t && t.nodeType === 3
      ? Ef(e, t.parentNode)
      : "contains" in e
      ? e.contains(t)
      : e.compareDocumentPosition
      ? !!(e.compareDocumentPosition(t) & 16)
      : !1
    : !1;
}
function Cf() {
  for (var e = window, t = Ho(); t instanceof e.HTMLIFrameElement; ) {
    try {
      var n = typeof t.contentWindow.location.href == "string";
    } catch {
      n = !1;
    }
    if (n) e = t.contentWindow;
    else break;
    t = Ho(e.document);
  }
  return t;
}
function Su(e) {
  var t = e && e.nodeName && e.nodeName.toLowerCase();
  return (
    t &&
    ((t === "input" &&
      (e.type === "text" ||
        e.type === "search" ||
        e.type === "tel" ||
        e.type === "url" ||
        e.type === "password")) ||
      t === "textarea" ||
      e.contentEditable === "true")
  );
}
function wm(e) {
  var t = Cf(),
    n = e.focusedElem,
    r = e.selectionRange;
  if (
    t !== n &&
    n &&
    n.ownerDocument &&
    Ef(n.ownerDocument.documentElement, n)
  ) {
    if (r !== null && Su(n)) {
      if (
        ((t = r.start),
        (e = r.end),
        e === void 0 && (e = t),
        "selectionStart" in n)
      )
        (n.selectionStart = t), (n.selectionEnd = Math.min(e, n.value.length));
      else if (
        ((e = ((t = n.ownerDocument || document) && t.defaultView) || window),
        e.getSelection)
      ) {
        e = e.getSelection();
        var o = n.textContent.length,
          i = Math.min(r.start, o);
        (r = r.end === void 0 ? i : Math.min(r.end, o)),
          !e.extend && i > r && ((o = r), (r = i), (i = o)),
          (o = ja(n, i));
        var l = ja(n, r);
        o &&
          l &&
          (e.rangeCount !== 1 ||
            e.anchorNode !== o.node ||
            e.anchorOffset !== o.offset ||
            e.focusNode !== l.node ||
            e.focusOffset !== l.offset) &&
          ((t = t.createRange()),
          t.setStart(o.node, o.offset),
          e.removeAllRanges(),
          i > r
            ? (e.addRange(t), e.extend(l.node, l.offset))
            : (t.setEnd(l.node, l.offset), e.addRange(t)));
      }
    }
    for (t = [], e = n; (e = e.parentNode); )
      e.nodeType === 1 &&
        t.push({ element: e, left: e.scrollLeft, top: e.scrollTop });
    for (typeof n.focus == "function" && n.focus(), n = 0; n < t.length; n++)
      (e = t[n]),
        (e.element.scrollLeft = e.left),
        (e.element.scrollTop = e.top);
  }
}
var xm = lt && "documentMode" in document && 11 >= document.documentMode,
  Sn = null,
  Jl = null,
  hr = null,
  es = !1;
function Aa(e, t, n) {
  var r = n.window === n ? n.document : n.nodeType === 9 ? n : n.ownerDocument;
  es ||
    Sn == null ||
    Sn !== Ho(r) ||
    ((r = Sn),
    "selectionStart" in r && Su(r)
      ? (r = { start: r.selectionStart, end: r.selectionEnd })
      : ((r = (
          (r.ownerDocument && r.ownerDocument.defaultView) ||
          window
        ).getSelection()),
        (r = {
          anchorNode: r.anchorNode,
          anchorOffset: r.anchorOffset,
          focusNode: r.focusNode,
          focusOffset: r.focusOffset,
        })),
    (hr && Dr(hr, r)) ||
      ((hr = r),
      (r = Zo(Jl, "onSelect")),
      0 < r.length &&
        ((t = new mu("onSelect", "select", null, t, n)),
        e.push({ event: t, listeners: r }),
        (t.target = Sn))));
}
function ao(e, t) {
  var n = {};
  return (
    (n[e.toLowerCase()] = t.toLowerCase()),
    (n["Webkit" + e] = "webkit" + t),
    (n["Moz" + e] = "moz" + t),
    n
  );
}
var wn = {
    animationend: ao("Animation", "AnimationEnd"),
    animationiteration: ao("Animation", "AnimationIteration"),
    animationstart: ao("Animation", "AnimationStart"),
    transitionend: ao("Transition", "TransitionEnd"),
  },
  tl = {},
  kf = {};
lt &&
  ((kf = document.createElement("div").style),
  "AnimationEvent" in window ||
    (delete wn.animationend.animation,
    delete wn.animationiteration.animation,
    delete wn.animationstart.animation),
  "TransitionEvent" in window || delete wn.transitionend.transition);
function Si(e) {
  if (tl[e]) return tl[e];
  if (!wn[e]) return e;
  var t = wn[e],
    n;
  for (n in t) if (t.hasOwnProperty(n) && n in kf) return (tl[e] = t[n]);
  return e;
}
var Of = Si("animationend"),
  Tf = Si("animationiteration"),
  Pf = Si("animationstart"),
  If = Si("transitionend"),
  Df = new Map(),
  Ba =
    "abort auxClick cancel canPlay canPlayThrough click close contextMenu copy cut drag dragEnd dragEnter dragExit dragLeave dragOver dragStart drop durationChange emptied encrypted ended error gotPointerCapture input invalid keyDown keyPress keyUp load loadedData loadedMetadata loadStart lostPointerCapture mouseDown mouseMove mouseOut mouseOver mouseUp paste pause play playing pointerCancel pointerDown pointerMove pointerOut pointerOver pointerUp progress rateChange reset resize seeked seeking stalled submit suspend timeUpdate touchCancel touchEnd touchStart volumeChange scroll toggle touchMove waiting wheel".split(
      " "
    );
function Rt(e, t) {
  Df.set(e, t), on(t, [e]);
}
for (var nl = 0; nl < Ba.length; nl++) {
  var rl = Ba[nl],
    Em = rl.toLowerCase(),
    Cm = rl[0].toUpperCase() + rl.slice(1);
  Rt(Em, "on" + Cm);
}
Rt(Of, "onAnimationEnd");
Rt(Tf, "onAnimationIteration");
Rt(Pf, "onAnimationStart");
Rt("dblclick", "onDoubleClick");
Rt("focusin", "onFocus");
Rt("focusout", "onBlur");
Rt(If, "onTransitionEnd");
Ln("onMouseEnter", ["mouseout", "mouseover"]);
Ln("onMouseLeave", ["mouseout", "mouseover"]);
Ln("onPointerEnter", ["pointerout", "pointerover"]);
Ln("onPointerLeave", ["pointerout", "pointerover"]);
on(
  "onChange",
  "change click focusin focusout input keydown keyup selectionchange".split(" ")
);
on(
  "onSelect",
  "focusout contextmenu dragend focusin keydown keyup mousedown mouseup selectionchange".split(
    " "
  )
);
on("onBeforeInput", ["compositionend", "keypress", "textInput", "paste"]);
on(
  "onCompositionEnd",
  "compositionend focusout keydown keypress keyup mousedown".split(" ")
);
on(
  "onCompositionStart",
  "compositionstart focusout keydown keypress keyup mousedown".split(" ")
);
on(
  "onCompositionUpdate",
  "compositionupdate focusout keydown keypress keyup mousedown".split(" ")
);
var ur =
    "abort canplay canplaythrough durationchange emptied encrypted ended error loadeddata loadedmetadata loadstart pause play playing progress ratechange resize seeked seeking stalled suspend timeupdate volumechange waiting".split(
      " "
    ),
  km = new Set("cancel close invalid load scroll toggle".split(" ").concat(ur));
function Ua(e, t, n) {
  var r = e.type || "unknown-event";
  (e.currentTarget = n), Eg(r, t, void 0, e), (e.currentTarget = null);
}
function $f(e, t) {
  t = (t & 4) !== 0;
  for (var n = 0; n < e.length; n++) {
    var r = e[n],
      o = r.event;
    r = r.listeners;
    e: {
      var i = void 0;
      if (t)
        for (var l = r.length - 1; 0 <= l; l--) {
          var s = r[l],
            u = s.instance,
            a = s.currentTarget;
          if (((s = s.listener), u !== i && o.isPropagationStopped())) break e;
          Ua(o, s, a), (i = u);
        }
      else
        for (l = 0; l < r.length; l++) {
          if (
            ((s = r[l]),
            (u = s.instance),
            (a = s.currentTarget),
            (s = s.listener),
            u !== i && o.isPropagationStopped())
          )
            break e;
          Ua(o, s, a), (i = u);
        }
    }
  }
  if (Qo) throw ((e = Yl), (Qo = !1), (Yl = null), e);
}
function W(e, t) {
  var n = t[is];
  n === void 0 && (n = t[is] = new Set());
  var r = e + "__bubble";
  n.has(r) || (Rf(t, e, 2, !1), n.add(r));
}
function ol(e, t, n) {
  var r = 0;
  t && (r |= 4), Rf(n, e, r, t);
}
var co = "_reactListening" + Math.random().toString(36).slice(2);
function $r(e) {
  if (!e[co]) {
    (e[co] = !0),
      Fd.forEach(function (n) {
        n !== "selectionchange" && (km.has(n) || ol(n, !1, e), ol(n, !0, e));
      });
    var t = e.nodeType === 9 ? e : e.ownerDocument;
    t === null || t[co] || ((t[co] = !0), ol("selectionchange", !1, t));
  }
}
function Rf(e, t, n, r) {
  switch (hf(t)) {
    case 1:
      var o = zg;
      break;
    case 4:
      o = jg;
      break;
    default:
      o = hu;
  }
  (n = o.bind(null, t, n, e)),
    (o = void 0),
    !Kl ||
      (t !== "touchstart" && t !== "touchmove" && t !== "wheel") ||
      (o = !0),
    r
      ? o !== void 0
        ? e.addEventListener(t, n, { capture: !0, passive: o })
        : e.addEventListener(t, n, !0)
      : o !== void 0
      ? e.addEventListener(t, n, { passive: o })
      : e.addEventListener(t, n, !1);
}
function il(e, t, n, r, o) {
  var i = r;
  if ((t & 1) === 0 && (t & 2) === 0 && r !== null)
    e: for (;;) {
      if (r === null) return;
      var l = r.tag;
      if (l === 3 || l === 4) {
        var s = r.stateNode.containerInfo;
        if (s === o || (s.nodeType === 8 && s.parentNode === o)) break;
        if (l === 4)
          for (l = r.return; l !== null; ) {
            var u = l.tag;
            if (
              (u === 3 || u === 4) &&
              ((u = l.stateNode.containerInfo),
              u === o || (u.nodeType === 8 && u.parentNode === o))
            )
              return;
            l = l.return;
          }
        for (; s !== null; ) {
          if (((l = Ut(s)), l === null)) return;
          if (((u = l.tag), u === 5 || u === 6)) {
            r = i = l;
            continue e;
          }
          s = s.parentNode;
        }
      }
      r = r.return;
    }
  Jd(function () {
    var a = i,
      c = cu(n),
      f = [];
    e: {
      var p = Df.get(e);
      if (p !== void 0) {
        var y = mu,
          S = e;
        switch (e) {
          case "keypress":
            if ($o(n) === 0) break e;
          case "keydown":
          case "keyup":
            y = em;
            break;
          case "focusin":
            (S = "focus"), (y = qi);
            break;
          case "focusout":
            (S = "blur"), (y = qi);
            break;
          case "beforeblur":
          case "afterblur":
            y = qi;
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
            y = $a;
            break;
          case "drag":
          case "dragend":
          case "dragenter":
          case "dragexit":
          case "dragleave":
          case "dragover":
          case "dragstart":
          case "drop":
            y = Ug;
            break;
          case "touchcancel":
          case "touchend":
          case "touchmove":
          case "touchstart":
            y = rm;
            break;
          case Of:
          case Tf:
          case Pf:
            y = Vg;
            break;
          case If:
            y = im;
            break;
          case "scroll":
            y = Ag;
            break;
          case "wheel":
            y = sm;
            break;
          case "copy":
          case "cut":
          case "paste":
            y = Gg;
            break;
          case "gotpointercapture":
          case "lostpointercapture":
          case "pointercancel":
          case "pointerdown":
          case "pointermove":
          case "pointerout":
          case "pointerover":
          case "pointerup":
            y = _a;
        }
        var m = (t & 4) !== 0,
          C = !m && e === "scroll",
          h = m ? (p !== null ? p + "Capture" : null) : p;
        m = [];
        for (var d = a, v; d !== null; ) {
          v = d;
          var w = v.stateNode;
          if (
            (v.tag === 5 &&
              w !== null &&
              ((v = w),
              h !== null && ((w = kr(d, h)), w != null && m.push(Rr(d, w, v)))),
            C)
          )
            break;
          d = d.return;
        }
        0 < m.length &&
          ((p = new y(p, S, null, n, c)), f.push({ event: p, listeners: m }));
      }
    }
    if ((t & 7) === 0) {
      e: {
        if (
          ((p = e === "mouseover" || e === "pointerover"),
          (y = e === "mouseout" || e === "pointerout"),
          p &&
            n !== Ql &&
            (S = n.relatedTarget || n.fromElement) &&
            (Ut(S) || S[st]))
        )
          break e;
        if (
          (y || p) &&
          ((p =
            c.window === c
              ? c
              : (p = c.ownerDocument)
              ? p.defaultView || p.parentWindow
              : window),
          y
            ? ((S = n.relatedTarget || n.toElement),
              (y = a),
              (S = S ? Ut(S) : null),
              S !== null &&
                ((C = ln(S)), S !== C || (S.tag !== 5 && S.tag !== 6)) &&
                (S = null))
            : ((y = null), (S = a)),
          y !== S)
        ) {
          if (
            ((m = $a),
            (w = "onMouseLeave"),
            (h = "onMouseEnter"),
            (d = "mouse"),
            (e === "pointerout" || e === "pointerover") &&
              ((m = _a),
              (w = "onPointerLeave"),
              (h = "onPointerEnter"),
              (d = "pointer")),
            (C = y == null ? p : xn(y)),
            (v = S == null ? p : xn(S)),
            (p = new m(w, d + "leave", y, n, c)),
            (p.target = C),
            (p.relatedTarget = v),
            (w = null),
            Ut(c) === a &&
              ((m = new m(h, d + "enter", S, n, c)),
              (m.target = v),
              (m.relatedTarget = C),
              (w = m)),
            (C = w),
            y && S)
          )
            t: {
              for (m = y, h = S, d = 0, v = m; v; v = an(v)) d++;
              for (v = 0, w = h; w; w = an(w)) v++;
              for (; 0 < d - v; ) (m = an(m)), d--;
              for (; 0 < v - d; ) (h = an(h)), v--;
              for (; d--; ) {
                if (m === h || (h !== null && m === h.alternate)) break t;
                (m = an(m)), (h = an(h));
              }
              m = null;
            }
          else m = null;
          y !== null && Wa(f, p, y, m, !1),
            S !== null && C !== null && Wa(f, C, S, m, !0);
        }
      }
      e: {
        if (
          ((p = a ? xn(a) : window),
          (y = p.nodeName && p.nodeName.toLowerCase()),
          y === "select" || (y === "input" && p.type === "file"))
        )
          var E = hm;
        else if (Ma(p))
          if (wf) E = ym;
          else {
            E = mm;
            var x = gm;
          }
        else
          (y = p.nodeName) &&
            y.toLowerCase() === "input" &&
            (p.type === "checkbox" || p.type === "radio") &&
            (E = vm);
        if (E && (E = E(e, a))) {
          Sf(f, E, n, c);
          break e;
        }
        x && x(e, p, a),
          e === "focusout" &&
            (x = p._wrapperState) &&
            x.controlled &&
            p.type === "number" &&
            Bl(p, "number", p.value);
      }
      switch (((x = a ? xn(a) : window), e)) {
        case "focusin":
          (Ma(x) || x.contentEditable === "true") &&
            ((Sn = x), (Jl = a), (hr = null));
          break;
        case "focusout":
          hr = Jl = Sn = null;
          break;
        case "mousedown":
          es = !0;
          break;
        case "contextmenu":
        case "mouseup":
        case "dragend":
          (es = !1), Aa(f, n, c);
          break;
        case "selectionchange":
          if (xm) break;
        case "keydown":
        case "keyup":
          Aa(f, n, c);
      }
      var k;
      if (yu)
        e: {
          switch (e) {
            case "compositionstart":
              var O = "onCompositionStart";
              break e;
            case "compositionend":
              O = "onCompositionEnd";
              break e;
            case "compositionupdate":
              O = "onCompositionUpdate";
              break e;
          }
          O = void 0;
        }
      else
        yn
          ? vf(e, n) && (O = "onCompositionEnd")
          : e === "keydown" && n.keyCode === 229 && (O = "onCompositionStart");
      O &&
        (mf &&
          n.locale !== "ko" &&
          (yn || O !== "onCompositionStart"
            ? O === "onCompositionEnd" && yn && (k = gf())
            : ((vt = c),
              (gu = "value" in vt ? vt.value : vt.textContent),
              (yn = !0))),
        (x = Zo(a, O)),
        0 < x.length &&
          ((O = new Ra(O, e, null, n, c)),
          f.push({ event: O, listeners: x }),
          k ? (O.data = k) : ((k = yf(n)), k !== null && (O.data = k)))),
        (k = am ? cm(e, n) : dm(e, n)) &&
          ((a = Zo(a, "onBeforeInput")),
          0 < a.length &&
            ((c = new Ra("onBeforeInput", "beforeinput", null, n, c)),
            f.push({ event: c, listeners: a }),
            (c.data = k)));
    }
    $f(f, t);
  });
}
function Rr(e, t, n) {
  return { instance: e, listener: t, currentTarget: n };
}
function Zo(e, t) {
  for (var n = t + "Capture", r = []; e !== null; ) {
    var o = e,
      i = o.stateNode;
    o.tag === 5 &&
      i !== null &&
      ((o = i),
      (i = kr(e, n)),
      i != null && r.unshift(Rr(e, i, o)),
      (i = kr(e, t)),
      i != null && r.push(Rr(e, i, o))),
      (e = e.return);
  }
  return r;
}
function an(e) {
  if (e === null) return null;
  do e = e.return;
  while (e && e.tag !== 5);
  return e || null;
}
function Wa(e, t, n, r, o) {
  for (var i = t._reactName, l = []; n !== null && n !== r; ) {
    var s = n,
      u = s.alternate,
      a = s.stateNode;
    if (u !== null && u === r) break;
    s.tag === 5 &&
      a !== null &&
      ((s = a),
      o
        ? ((u = kr(n, i)), u != null && l.unshift(Rr(n, u, s)))
        : o || ((u = kr(n, i)), u != null && l.push(Rr(n, u, s)))),
      (n = n.return);
  }
  l.length !== 0 && e.push({ event: t, listeners: l });
}
var Om = /\r\n?/g,
  Tm = /\u0000|\uFFFD/g;
function Ha(e) {
  return (typeof e == "string" ? e : "" + e)
    .replace(
      Om,
      `
`
    )
    .replace(Tm, "");
}
function fo(e, t, n) {
  if (((t = Ha(t)), Ha(e) !== t && n)) throw Error(T(425));
}
function qo() {}
var ts = null,
  ns = null;
function rs(e, t) {
  return (
    e === "textarea" ||
    e === "noscript" ||
    typeof t.children == "string" ||
    typeof t.children == "number" ||
    (typeof t.dangerouslySetInnerHTML == "object" &&
      t.dangerouslySetInnerHTML !== null &&
      t.dangerouslySetInnerHTML.__html != null)
  );
}
var os = typeof setTimeout == "function" ? setTimeout : void 0,
  Pm = typeof clearTimeout == "function" ? clearTimeout : void 0,
  Va = typeof Promise == "function" ? Promise : void 0,
  Im =
    typeof queueMicrotask == "function"
      ? queueMicrotask
      : typeof Va != "undefined"
      ? function (e) {
          return Va.resolve(null).then(e).catch(Dm);
        }
      : os;
function Dm(e) {
  setTimeout(function () {
    throw e;
  });
}
function ll(e, t) {
  var n = t,
    r = 0;
  do {
    var o = n.nextSibling;
    if ((e.removeChild(n), o && o.nodeType === 8))
      if (((n = o.data), n === "/$")) {
        if (r === 0) {
          e.removeChild(o), Pr(t);
          return;
        }
        r--;
      } else (n !== "$" && n !== "$?" && n !== "$!") || r++;
    n = o;
  } while (n);
  Pr(t);
}
function Ct(e) {
  for (; e != null; e = e.nextSibling) {
    var t = e.nodeType;
    if (t === 1 || t === 3) break;
    if (t === 8) {
      if (((t = e.data), t === "$" || t === "$!" || t === "$?")) break;
      if (t === "/$") return null;
    }
  }
  return e;
}
function Qa(e) {
  e = e.previousSibling;
  for (var t = 0; e; ) {
    if (e.nodeType === 8) {
      var n = e.data;
      if (n === "$" || n === "$!" || n === "$?") {
        if (t === 0) return e;
        t--;
      } else n === "/$" && t++;
    }
    e = e.previousSibling;
  }
  return null;
}
var Vn = Math.random().toString(36).slice(2),
  Xe = "__reactFiber$" + Vn,
  _r = "__reactProps$" + Vn,
  st = "__reactContainer$" + Vn,
  is = "__reactEvents$" + Vn,
  $m = "__reactListeners$" + Vn,
  Rm = "__reactHandles$" + Vn;
function Ut(e) {
  var t = e[Xe];
  if (t) return t;
  for (var n = e.parentNode; n; ) {
    if ((t = n[st] || n[Xe])) {
      if (
        ((n = t.alternate),
        t.child !== null || (n !== null && n.child !== null))
      )
        for (e = Qa(e); e !== null; ) {
          if ((n = e[Xe])) return n;
          e = Qa(e);
        }
      return t;
    }
    (e = n), (n = e.parentNode);
  }
  return null;
}
function Qr(e) {
  return (
    (e = e[Xe] || e[st]),
    !e || (e.tag !== 5 && e.tag !== 6 && e.tag !== 13 && e.tag !== 3) ? null : e
  );
}
function xn(e) {
  if (e.tag === 5 || e.tag === 6) return e.stateNode;
  throw Error(T(33));
}
function wi(e) {
  return e[_r] || null;
}
var ls = [],
  En = -1;
function _t(e) {
  return { current: e };
}
function H(e) {
  0 > En || ((e.current = ls[En]), (ls[En] = null), En--);
}
function U(e, t) {
  En++, (ls[En] = e.current), (e.current = t);
}
var $t = {},
  pe = _t($t),
  Ee = _t(!1),
  Xt = $t;
function Fn(e, t) {
  var n = e.type.contextTypes;
  if (!n) return $t;
  var r = e.stateNode;
  if (r && r.__reactInternalMemoizedUnmaskedChildContext === t)
    return r.__reactInternalMemoizedMaskedChildContext;
  var o = {},
    i;
  for (i in n) o[i] = t[i];
  return (
    r &&
      ((e = e.stateNode),
      (e.__reactInternalMemoizedUnmaskedChildContext = t),
      (e.__reactInternalMemoizedMaskedChildContext = o)),
    o
  );
}
function Ce(e) {
  return (e = e.childContextTypes), e != null;
}
function Jo() {
  H(Ee), H(pe);
}
function Ga(e, t, n) {
  if (pe.current !== $t) throw Error(T(168));
  U(pe, t), U(Ee, n);
}
function _f(e, t, n) {
  var r = e.stateNode;
  if (((t = t.childContextTypes), typeof r.getChildContext != "function"))
    return n;
  r = r.getChildContext();
  for (var o in r) if (!(o in t)) throw Error(T(108, gg(e) || "Unknown", o));
  return K({}, n, r);
}
function ei(e) {
  return (
    (e =
      ((e = e.stateNode) && e.__reactInternalMemoizedMergedChildContext) || $t),
    (Xt = pe.current),
    U(pe, e),
    U(Ee, Ee.current),
    !0
  );
}
function Ka(e, t, n) {
  var r = e.stateNode;
  if (!r) throw Error(T(169));
  n
    ? ((e = _f(e, t, Xt)),
      (r.__reactInternalMemoizedMergedChildContext = e),
      H(Ee),
      H(pe),
      U(pe, e))
    : H(Ee),
    U(Ee, n);
}
var nt = null,
  xi = !1,
  sl = !1;
function Nf(e) {
  nt === null ? (nt = [e]) : nt.push(e);
}
function _m(e) {
  (xi = !0), Nf(e);
}
function Nt() {
  if (!sl && nt !== null) {
    sl = !0;
    var e = 0,
      t = A;
    try {
      var n = nt;
      for (A = 1; e < n.length; e++) {
        var r = n[e];
        do r = r(!0);
        while (r !== null);
      }
      (nt = null), (xi = !1);
    } catch (o) {
      throw (nt !== null && (nt = nt.slice(e + 1)), rf(du, Nt), o);
    } finally {
      (A = t), (sl = !1);
    }
  }
  return null;
}
var Cn = [],
  kn = 0,
  ti = null,
  ni = 0,
  be = [],
  Me = 0,
  Zt = null,
  rt = 1,
  ot = "";
function zt(e, t) {
  (Cn[kn++] = ni), (Cn[kn++] = ti), (ti = e), (ni = t);
}
function bf(e, t, n) {
  (be[Me++] = rt), (be[Me++] = ot), (be[Me++] = Zt), (Zt = e);
  var r = rt;
  e = ot;
  var o = 32 - Ve(r) - 1;
  (r &= ~(1 << o)), (n += 1);
  var i = 32 - Ve(t) + o;
  if (30 < i) {
    var l = o - (o % 5);
    (i = (r & ((1 << l) - 1)).toString(32)),
      (r >>= l),
      (o -= l),
      (rt = (1 << (32 - Ve(t) + o)) | (n << o) | r),
      (ot = i + e);
  } else (rt = (1 << i) | (n << o) | r), (ot = e);
}
function wu(e) {
  e.return !== null && (zt(e, 1), bf(e, 1, 0));
}
function xu(e) {
  for (; e === ti; )
    (ti = Cn[--kn]), (Cn[kn] = null), (ni = Cn[--kn]), (Cn[kn] = null);
  for (; e === Zt; )
    (Zt = be[--Me]),
      (be[Me] = null),
      (ot = be[--Me]),
      (be[Me] = null),
      (rt = be[--Me]),
      (be[Me] = null);
}
var Pe = null,
  Te = null,
  V = !1,
  He = null;
function Mf(e, t) {
  var n = Fe(5, null, null, 0);
  (n.elementType = "DELETED"),
    (n.stateNode = t),
    (n.return = e),
    (t = e.deletions),
    t === null ? ((e.deletions = [n]), (e.flags |= 16)) : t.push(n);
}
function Ya(e, t) {
  switch (e.tag) {
    case 5:
      var n = e.type;
      return (
        (t =
          t.nodeType !== 1 || n.toLowerCase() !== t.nodeName.toLowerCase()
            ? null
            : t),
        t !== null
          ? ((e.stateNode = t), (Pe = e), (Te = Ct(t.firstChild)), !0)
          : !1
      );
    case 6:
      return (
        (t = e.pendingProps === "" || t.nodeType !== 3 ? null : t),
        t !== null ? ((e.stateNode = t), (Pe = e), (Te = null), !0) : !1
      );
    case 13:
      return (
        (t = t.nodeType !== 8 ? null : t),
        t !== null
          ? ((n = Zt !== null ? { id: rt, overflow: ot } : null),
            (e.memoizedState = {
              dehydrated: t,
              treeContext: n,
              retryLane: 1073741824,
            }),
            (n = Fe(18, null, null, 0)),
            (n.stateNode = t),
            (n.return = e),
            (e.child = n),
            (Pe = e),
            (Te = null),
            !0)
          : !1
      );
    default:
      return !1;
  }
}
function ss(e) {
  return (e.mode & 1) !== 0 && (e.flags & 128) === 0;
}
function us(e) {
  if (V) {
    var t = Te;
    if (t) {
      var n = t;
      if (!Ya(e, t)) {
        if (ss(e)) throw Error(T(418));
        t = Ct(n.nextSibling);
        var r = Pe;
        t && Ya(e, t)
          ? Mf(r, n)
          : ((e.flags = (e.flags & -4097) | 2), (V = !1), (Pe = e));
      }
    } else {
      if (ss(e)) throw Error(T(418));
      (e.flags = (e.flags & -4097) | 2), (V = !1), (Pe = e);
    }
  }
}
function Xa(e) {
  for (e = e.return; e !== null && e.tag !== 5 && e.tag !== 3 && e.tag !== 13; )
    e = e.return;
  Pe = e;
}
function po(e) {
  if (e !== Pe) return !1;
  if (!V) return Xa(e), (V = !0), !1;
  var t;
  if (
    ((t = e.tag !== 3) &&
      !(t = e.tag !== 5) &&
      ((t = e.type),
      (t = t !== "head" && t !== "body" && !rs(e.type, e.memoizedProps))),
    t && (t = Te))
  ) {
    if (ss(e)) throw (Lf(), Error(T(418)));
    for (; t; ) Mf(e, t), (t = Ct(t.nextSibling));
  }
  if ((Xa(e), e.tag === 13)) {
    if (((e = e.memoizedState), (e = e !== null ? e.dehydrated : null), !e))
      throw Error(T(317));
    e: {
      for (e = e.nextSibling, t = 0; e; ) {
        if (e.nodeType === 8) {
          var n = e.data;
          if (n === "/$") {
            if (t === 0) {
              Te = Ct(e.nextSibling);
              break e;
            }
            t--;
          } else (n !== "$" && n !== "$!" && n !== "$?") || t++;
        }
        e = e.nextSibling;
      }
      Te = null;
    }
  } else Te = Pe ? Ct(e.stateNode.nextSibling) : null;
  return !0;
}
function Lf() {
  for (var e = Te; e; ) e = Ct(e.nextSibling);
}
function zn() {
  (Te = Pe = null), (V = !1);
}
function Eu(e) {
  He === null ? (He = [e]) : He.push(e);
}
var Nm = dt.ReactCurrentBatchConfig;
function Ue(e, t) {
  if (e && e.defaultProps) {
    (t = K({}, t)), (e = e.defaultProps);
    for (var n in e) t[n] === void 0 && (t[n] = e[n]);
    return t;
  }
  return t;
}
var ri = _t(null),
  oi = null,
  On = null,
  Cu = null;
function ku() {
  Cu = On = oi = null;
}
function Ou(e) {
  var t = ri.current;
  H(ri), (e._currentValue = t);
}
function as(e, t, n) {
  for (; e !== null; ) {
    var r = e.alternate;
    if (
      ((e.childLanes & t) !== t
        ? ((e.childLanes |= t), r !== null && (r.childLanes |= t))
        : r !== null && (r.childLanes & t) !== t && (r.childLanes |= t),
      e === n)
    )
      break;
    e = e.return;
  }
}
function Nn(e, t) {
  (oi = e),
    (Cu = On = null),
    (e = e.dependencies),
    e !== null &&
      e.firstContext !== null &&
      ((e.lanes & t) !== 0 && (xe = !0), (e.firstContext = null));
}
function je(e) {
  var t = e._currentValue;
  if (Cu !== e)
    if (((e = { context: e, memoizedValue: t, next: null }), On === null)) {
      if (oi === null) throw Error(T(308));
      (On = e), (oi.dependencies = { lanes: 0, firstContext: e });
    } else On = On.next = e;
  return t;
}
var Wt = null;
function Tu(e) {
  Wt === null ? (Wt = [e]) : Wt.push(e);
}
function Ff(e, t, n, r) {
  var o = t.interleaved;
  return (
    o === null ? ((n.next = n), Tu(t)) : ((n.next = o.next), (o.next = n)),
    (t.interleaved = n),
    ut(e, r)
  );
}
function ut(e, t) {
  e.lanes |= t;
  var n = e.alternate;
  for (n !== null && (n.lanes |= t), n = e, e = e.return; e !== null; )
    (e.childLanes |= t),
      (n = e.alternate),
      n !== null && (n.childLanes |= t),
      (n = e),
      (e = e.return);
  return n.tag === 3 ? n.stateNode : null;
}
var ht = !1;
function Pu(e) {
  e.updateQueue = {
    baseState: e.memoizedState,
    firstBaseUpdate: null,
    lastBaseUpdate: null,
    shared: { pending: null, interleaved: null, lanes: 0 },
    effects: null,
  };
}
function zf(e, t) {
  (e = e.updateQueue),
    t.updateQueue === e &&
      (t.updateQueue = {
        baseState: e.baseState,
        firstBaseUpdate: e.firstBaseUpdate,
        lastBaseUpdate: e.lastBaseUpdate,
        shared: e.shared,
        effects: e.effects,
      });
}
function it(e, t) {
  return {
    eventTime: e,
    lane: t,
    tag: 0,
    payload: null,
    callback: null,
    next: null,
  };
}
function kt(e, t, n) {
  var r = e.updateQueue;
  if (r === null) return null;
  if (((r = r.shared), (F & 2) !== 0)) {
    var o = r.pending;
    return (
      o === null ? (t.next = t) : ((t.next = o.next), (o.next = t)),
      (r.pending = t),
      ut(e, n)
    );
  }
  return (
    (o = r.interleaved),
    o === null ? ((t.next = t), Tu(r)) : ((t.next = o.next), (o.next = t)),
    (r.interleaved = t),
    ut(e, n)
  );
}
function Ro(e, t, n) {
  if (
    ((t = t.updateQueue), t !== null && ((t = t.shared), (n & 4194240) !== 0))
  ) {
    var r = t.lanes;
    (r &= e.pendingLanes), (n |= r), (t.lanes = n), fu(e, n);
  }
}
function Za(e, t) {
  var n = e.updateQueue,
    r = e.alternate;
  if (r !== null && ((r = r.updateQueue), n === r)) {
    var o = null,
      i = null;
    if (((n = n.firstBaseUpdate), n !== null)) {
      do {
        var l = {
          eventTime: n.eventTime,
          lane: n.lane,
          tag: n.tag,
          payload: n.payload,
          callback: n.callback,
          next: null,
        };
        i === null ? (o = i = l) : (i = i.next = l), (n = n.next);
      } while (n !== null);
      i === null ? (o = i = t) : (i = i.next = t);
    } else o = i = t;
    (n = {
      baseState: r.baseState,
      firstBaseUpdate: o,
      lastBaseUpdate: i,
      shared: r.shared,
      effects: r.effects,
    }),
      (e.updateQueue = n);
    return;
  }
  (e = n.lastBaseUpdate),
    e === null ? (n.firstBaseUpdate = t) : (e.next = t),
    (n.lastBaseUpdate = t);
}
function ii(e, t, n, r) {
  var o = e.updateQueue;
  ht = !1;
  var i = o.firstBaseUpdate,
    l = o.lastBaseUpdate,
    s = o.shared.pending;
  if (s !== null) {
    o.shared.pending = null;
    var u = s,
      a = u.next;
    (u.next = null), l === null ? (i = a) : (l.next = a), (l = u);
    var c = e.alternate;
    c !== null &&
      ((c = c.updateQueue),
      (s = c.lastBaseUpdate),
      s !== l &&
        (s === null ? (c.firstBaseUpdate = a) : (s.next = a),
        (c.lastBaseUpdate = u)));
  }
  if (i !== null) {
    var f = o.baseState;
    (l = 0), (c = a = u = null), (s = i);
    do {
      var p = s.lane,
        y = s.eventTime;
      if ((r & p) === p) {
        c !== null &&
          (c = c.next =
            {
              eventTime: y,
              lane: 0,
              tag: s.tag,
              payload: s.payload,
              callback: s.callback,
              next: null,
            });
        e: {
          var S = e,
            m = s;
          switch (((p = t), (y = n), m.tag)) {
            case 1:
              if (((S = m.payload), typeof S == "function")) {
                f = S.call(y, f, p);
                break e;
              }
              f = S;
              break e;
            case 3:
              S.flags = (S.flags & -65537) | 128;
            case 0:
              if (
                ((S = m.payload),
                (p = typeof S == "function" ? S.call(y, f, p) : S),
                p == null)
              )
                break e;
              f = K({}, f, p);
              break e;
            case 2:
              ht = !0;
          }
        }
        s.callback !== null &&
          s.lane !== 0 &&
          ((e.flags |= 64),
          (p = o.effects),
          p === null ? (o.effects = [s]) : p.push(s));
      } else
        (y = {
          eventTime: y,
          lane: p,
          tag: s.tag,
          payload: s.payload,
          callback: s.callback,
          next: null,
        }),
          c === null ? ((a = c = y), (u = f)) : (c = c.next = y),
          (l |= p);
      if (((s = s.next), s === null)) {
        if (((s = o.shared.pending), s === null)) break;
        (p = s),
          (s = p.next),
          (p.next = null),
          (o.lastBaseUpdate = p),
          (o.shared.pending = null);
      }
    } while (1);
    if (
      (c === null && (u = f),
      (o.baseState = u),
      (o.firstBaseUpdate = a),
      (o.lastBaseUpdate = c),
      (t = o.shared.interleaved),
      t !== null)
    ) {
      o = t;
      do (l |= o.lane), (o = o.next);
      while (o !== t);
    } else i === null && (o.shared.lanes = 0);
    (Jt |= l), (e.lanes = l), (e.memoizedState = f);
  }
}
function qa(e, t, n) {
  if (((e = t.effects), (t.effects = null), e !== null))
    for (t = 0; t < e.length; t++) {
      var r = e[t],
        o = r.callback;
      if (o !== null) {
        if (((r.callback = null), (r = n), typeof o != "function"))
          throw Error(T(191, o));
        o.call(r);
      }
    }
}
var jf = new Ld.Component().refs;
function cs(e, t, n, r) {
  (t = e.memoizedState),
    (n = n(r, t)),
    (n = n == null ? t : K({}, t, n)),
    (e.memoizedState = n),
    e.lanes === 0 && (e.updateQueue.baseState = n);
}
var Ei = {
  isMounted: function (e) {
    return (e = e._reactInternals) ? ln(e) === e : !1;
  },
  enqueueSetState: function (e, t, n) {
    e = e._reactInternals;
    var r = ve(),
      o = Tt(e),
      i = it(r, o);
    (i.payload = t),
      n != null && (i.callback = n),
      (t = kt(e, i, o)),
      t !== null && (Qe(t, e, o, r), Ro(t, e, o));
  },
  enqueueReplaceState: function (e, t, n) {
    e = e._reactInternals;
    var r = ve(),
      o = Tt(e),
      i = it(r, o);
    (i.tag = 1),
      (i.payload = t),
      n != null && (i.callback = n),
      (t = kt(e, i, o)),
      t !== null && (Qe(t, e, o, r), Ro(t, e, o));
  },
  enqueueForceUpdate: function (e, t) {
    e = e._reactInternals;
    var n = ve(),
      r = Tt(e),
      o = it(n, r);
    (o.tag = 2),
      t != null && (o.callback = t),
      (t = kt(e, o, r)),
      t !== null && (Qe(t, e, r, n), Ro(t, e, r));
  },
};
function Ja(e, t, n, r, o, i, l) {
  return (
    (e = e.stateNode),
    typeof e.shouldComponentUpdate == "function"
      ? e.shouldComponentUpdate(r, i, l)
      : t.prototype && t.prototype.isPureReactComponent
      ? !Dr(n, r) || !Dr(o, i)
      : !0
  );
}
function Af(e, t, n) {
  var r = !1,
    o = $t,
    i = t.contextType;
  return (
    typeof i == "object" && i !== null
      ? (i = je(i))
      : ((o = Ce(t) ? Xt : pe.current),
        (r = t.contextTypes),
        (i = (r = r != null) ? Fn(e, o) : $t)),
    (t = new t(n, i)),
    (e.memoizedState = t.state !== null && t.state !== void 0 ? t.state : null),
    (t.updater = Ei),
    (e.stateNode = t),
    (t._reactInternals = e),
    r &&
      ((e = e.stateNode),
      (e.__reactInternalMemoizedUnmaskedChildContext = o),
      (e.__reactInternalMemoizedMaskedChildContext = i)),
    t
  );
}
function ec(e, t, n, r) {
  (e = t.state),
    typeof t.componentWillReceiveProps == "function" &&
      t.componentWillReceiveProps(n, r),
    typeof t.UNSAFE_componentWillReceiveProps == "function" &&
      t.UNSAFE_componentWillReceiveProps(n, r),
    t.state !== e && Ei.enqueueReplaceState(t, t.state, null);
}
function ds(e, t, n, r) {
  var o = e.stateNode;
  (o.props = n), (o.state = e.memoizedState), (o.refs = jf), Pu(e);
  var i = t.contextType;
  typeof i == "object" && i !== null
    ? (o.context = je(i))
    : ((i = Ce(t) ? Xt : pe.current), (o.context = Fn(e, i))),
    (o.state = e.memoizedState),
    (i = t.getDerivedStateFromProps),
    typeof i == "function" && (cs(e, t, i, n), (o.state = e.memoizedState)),
    typeof t.getDerivedStateFromProps == "function" ||
      typeof o.getSnapshotBeforeUpdate == "function" ||
      (typeof o.UNSAFE_componentWillMount != "function" &&
        typeof o.componentWillMount != "function") ||
      ((t = o.state),
      typeof o.componentWillMount == "function" && o.componentWillMount(),
      typeof o.UNSAFE_componentWillMount == "function" &&
        o.UNSAFE_componentWillMount(),
      t !== o.state && Ei.enqueueReplaceState(o, o.state, null),
      ii(e, n, o, r),
      (o.state = e.memoizedState)),
    typeof o.componentDidMount == "function" && (e.flags |= 4194308);
}
function Jn(e, t, n) {
  if (
    ((e = n.ref), e !== null && typeof e != "function" && typeof e != "object")
  ) {
    if (n._owner) {
      if (((n = n._owner), n)) {
        if (n.tag !== 1) throw Error(T(309));
        var r = n.stateNode;
      }
      if (!r) throw Error(T(147, e));
      var o = r,
        i = "" + e;
      return t !== null &&
        t.ref !== null &&
        typeof t.ref == "function" &&
        t.ref._stringRef === i
        ? t.ref
        : ((t = function (l) {
            var s = o.refs;
            s === jf && (s = o.refs = {}),
              l === null ? delete s[i] : (s[i] = l);
          }),
          (t._stringRef = i),
          t);
    }
    if (typeof e != "string") throw Error(T(284));
    if (!n._owner) throw Error(T(290, e));
  }
  return e;
}
function ho(e, t) {
  throw (
    ((e = Object.prototype.toString.call(t)),
    Error(
      T(
        31,
        e === "[object Object]"
          ? "object with keys {" + Object.keys(t).join(", ") + "}"
          : e
      )
    ))
  );
}
function tc(e) {
  var t = e._init;
  return t(e._payload);
}
function Bf(e) {
  function t(h, d) {
    if (e) {
      var v = h.deletions;
      v === null ? ((h.deletions = [d]), (h.flags |= 16)) : v.push(d);
    }
  }
  function n(h, d) {
    if (!e) return null;
    for (; d !== null; ) t(h, d), (d = d.sibling);
    return null;
  }
  function r(h, d) {
    for (h = new Map(); d !== null; )
      d.key !== null ? h.set(d.key, d) : h.set(d.index, d), (d = d.sibling);
    return h;
  }
  function o(h, d) {
    return (h = Pt(h, d)), (h.index = 0), (h.sibling = null), h;
  }
  function i(h, d, v) {
    return (
      (h.index = v),
      e
        ? ((v = h.alternate),
          v !== null
            ? ((v = v.index), v < d ? ((h.flags |= 2), d) : v)
            : ((h.flags |= 2), d))
        : ((h.flags |= 1048576), d)
    );
  }
  function l(h) {
    return e && h.alternate === null && (h.flags |= 2), h;
  }
  function s(h, d, v, w) {
    return d === null || d.tag !== 6
      ? ((d = hl(v, h.mode, w)), (d.return = h), d)
      : ((d = o(d, v)), (d.return = h), d);
  }
  function u(h, d, v, w) {
    var E = v.type;
    return E === vn
      ? c(h, d, v.props.children, w, v.key)
      : d !== null &&
        (d.elementType === E ||
          (typeof E == "object" &&
            E !== null &&
            E.$$typeof === pt &&
            tc(E) === d.type))
      ? ((w = o(d, v.props)), (w.ref = Jn(h, d, v)), (w.return = h), w)
      : ((w = Fo(v.type, v.key, v.props, null, h.mode, w)),
        (w.ref = Jn(h, d, v)),
        (w.return = h),
        w);
  }
  function a(h, d, v, w) {
    return d === null ||
      d.tag !== 4 ||
      d.stateNode.containerInfo !== v.containerInfo ||
      d.stateNode.implementation !== v.implementation
      ? ((d = gl(v, h.mode, w)), (d.return = h), d)
      : ((d = o(d, v.children || [])), (d.return = h), d);
  }
  function c(h, d, v, w, E) {
    return d === null || d.tag !== 7
      ? ((d = Qt(v, h.mode, w, E)), (d.return = h), d)
      : ((d = o(d, v)), (d.return = h), d);
  }
  function f(h, d, v) {
    if ((typeof d == "string" && d !== "") || typeof d == "number")
      return (d = hl("" + d, h.mode, v)), (d.return = h), d;
    if (typeof d == "object" && d !== null) {
      switch (d.$$typeof) {
        case no:
          return (
            (v = Fo(d.type, d.key, d.props, null, h.mode, v)),
            (v.ref = Jn(h, null, d)),
            (v.return = h),
            v
          );
        case mn:
          return (d = gl(d, h.mode, v)), (d.return = h), d;
        case pt:
          var w = d._init;
          return f(h, w(d._payload), v);
      }
      if (lr(d) || Kn(d))
        return (d = Qt(d, h.mode, v, null)), (d.return = h), d;
      ho(h, d);
    }
    return null;
  }
  function p(h, d, v, w) {
    var E = d !== null ? d.key : null;
    if ((typeof v == "string" && v !== "") || typeof v == "number")
      return E !== null ? null : s(h, d, "" + v, w);
    if (typeof v == "object" && v !== null) {
      switch (v.$$typeof) {
        case no:
          return v.key === E ? u(h, d, v, w) : null;
        case mn:
          return v.key === E ? a(h, d, v, w) : null;
        case pt:
          return (E = v._init), p(h, d, E(v._payload), w);
      }
      if (lr(v) || Kn(v)) return E !== null ? null : c(h, d, v, w, null);
      ho(h, v);
    }
    return null;
  }
  function y(h, d, v, w, E) {
    if ((typeof w == "string" && w !== "") || typeof w == "number")
      return (h = h.get(v) || null), s(d, h, "" + w, E);
    if (typeof w == "object" && w !== null) {
      switch (w.$$typeof) {
        case no:
          return (h = h.get(w.key === null ? v : w.key) || null), u(d, h, w, E);
        case mn:
          return (h = h.get(w.key === null ? v : w.key) || null), a(d, h, w, E);
        case pt:
          var x = w._init;
          return y(h, d, v, x(w._payload), E);
      }
      if (lr(w) || Kn(w)) return (h = h.get(v) || null), c(d, h, w, E, null);
      ho(d, w);
    }
    return null;
  }
  function S(h, d, v, w) {
    for (
      var E = null, x = null, k = d, O = (d = 0), _ = null;
      k !== null && O < v.length;
      O++
    ) {
      k.index > O ? ((_ = k), (k = null)) : (_ = k.sibling);
      var R = p(h, k, v[O], w);
      if (R === null) {
        k === null && (k = _);
        break;
      }
      e && k && R.alternate === null && t(h, k),
        (d = i(R, d, O)),
        x === null ? (E = R) : (x.sibling = R),
        (x = R),
        (k = _);
    }
    if (O === v.length) return n(h, k), V && zt(h, O), E;
    if (k === null) {
      for (; O < v.length; O++)
        (k = f(h, v[O], w)),
          k !== null &&
            ((d = i(k, d, O)), x === null ? (E = k) : (x.sibling = k), (x = k));
      return V && zt(h, O), E;
    }
    for (k = r(h, k); O < v.length; O++)
      (_ = y(k, h, O, v[O], w)),
        _ !== null &&
          (e && _.alternate !== null && k.delete(_.key === null ? O : _.key),
          (d = i(_, d, O)),
          x === null ? (E = _) : (x.sibling = _),
          (x = _));
    return (
      e &&
        k.forEach(function (z) {
          return t(h, z);
        }),
      V && zt(h, O),
      E
    );
  }
  function m(h, d, v, w) {
    var E = Kn(v);
    if (typeof E != "function") throw Error(T(150));
    if (((v = E.call(v)), v == null)) throw Error(T(151));
    for (
      var x = (E = null), k = d, O = (d = 0), _ = null, R = v.next();
      k !== null && !R.done;
      O++, R = v.next()
    ) {
      k.index > O ? ((_ = k), (k = null)) : (_ = k.sibling);
      var z = p(h, k, R.value, w);
      if (z === null) {
        k === null && (k = _);
        break;
      }
      e && k && z.alternate === null && t(h, k),
        (d = i(z, d, O)),
        x === null ? (E = z) : (x.sibling = z),
        (x = z),
        (k = _);
    }
    if (R.done) return n(h, k), V && zt(h, O), E;
    if (k === null) {
      for (; !R.done; O++, R = v.next())
        (R = f(h, R.value, w)),
          R !== null &&
            ((d = i(R, d, O)), x === null ? (E = R) : (x.sibling = R), (x = R));
      return V && zt(h, O), E;
    }
    for (k = r(h, k); !R.done; O++, R = v.next())
      (R = y(k, h, O, R.value, w)),
        R !== null &&
          (e && R.alternate !== null && k.delete(R.key === null ? O : R.key),
          (d = i(R, d, O)),
          x === null ? (E = R) : (x.sibling = R),
          (x = R));
    return (
      e &&
        k.forEach(function (q) {
          return t(h, q);
        }),
      V && zt(h, O),
      E
    );
  }
  function C(h, d, v, w) {
    if (
      (typeof v == "object" &&
        v !== null &&
        v.type === vn &&
        v.key === null &&
        (v = v.props.children),
      typeof v == "object" && v !== null)
    ) {
      switch (v.$$typeof) {
        case no:
          e: {
            for (var E = v.key, x = d; x !== null; ) {
              if (x.key === E) {
                if (((E = v.type), E === vn)) {
                  if (x.tag === 7) {
                    n(h, x.sibling),
                      (d = o(x, v.props.children)),
                      (d.return = h),
                      (h = d);
                    break e;
                  }
                } else if (
                  x.elementType === E ||
                  (typeof E == "object" &&
                    E !== null &&
                    E.$$typeof === pt &&
                    tc(E) === x.type)
                ) {
                  n(h, x.sibling),
                    (d = o(x, v.props)),
                    (d.ref = Jn(h, x, v)),
                    (d.return = h),
                    (h = d);
                  break e;
                }
                n(h, x);
                break;
              } else t(h, x);
              x = x.sibling;
            }
            v.type === vn
              ? ((d = Qt(v.props.children, h.mode, w, v.key)),
                (d.return = h),
                (h = d))
              : ((w = Fo(v.type, v.key, v.props, null, h.mode, w)),
                (w.ref = Jn(h, d, v)),
                (w.return = h),
                (h = w));
          }
          return l(h);
        case mn:
          e: {
            for (x = v.key; d !== null; ) {
              if (d.key === x)
                if (
                  d.tag === 4 &&
                  d.stateNode.containerInfo === v.containerInfo &&
                  d.stateNode.implementation === v.implementation
                ) {
                  n(h, d.sibling),
                    (d = o(d, v.children || [])),
                    (d.return = h),
                    (h = d);
                  break e;
                } else {
                  n(h, d);
                  break;
                }
              else t(h, d);
              d = d.sibling;
            }
            (d = gl(v, h.mode, w)), (d.return = h), (h = d);
          }
          return l(h);
        case pt:
          return (x = v._init), C(h, d, x(v._payload), w);
      }
      if (lr(v)) return S(h, d, v, w);
      if (Kn(v)) return m(h, d, v, w);
      ho(h, v);
    }
    return (typeof v == "string" && v !== "") || typeof v == "number"
      ? ((v = "" + v),
        d !== null && d.tag === 6
          ? (n(h, d.sibling), (d = o(d, v)), (d.return = h), (h = d))
          : (n(h, d), (d = hl(v, h.mode, w)), (d.return = h), (h = d)),
        l(h))
      : n(h, d);
  }
  return C;
}
var jn = Bf(!0),
  Uf = Bf(!1),
  Gr = {},
  Je = _t(Gr),
  Nr = _t(Gr),
  br = _t(Gr);
function Ht(e) {
  if (e === Gr) throw Error(T(174));
  return e;
}
function Iu(e, t) {
  switch ((U(br, t), U(Nr, e), U(Je, Gr), (e = t.nodeType), e)) {
    case 9:
    case 11:
      t = (t = t.documentElement) ? t.namespaceURI : Wl(null, "");
      break;
    default:
      (e = e === 8 ? t.parentNode : t),
        (t = e.namespaceURI || null),
        (e = e.tagName),
        (t = Wl(t, e));
  }
  H(Je), U(Je, t);
}
function An() {
  H(Je), H(Nr), H(br);
}
function Wf(e) {
  Ht(br.current);
  var t = Ht(Je.current),
    n = Wl(t, e.type);
  t !== n && (U(Nr, e), U(Je, n));
}
function Du(e) {
  Nr.current === e && (H(Je), H(Nr));
}
var Q = _t(0);
function li(e) {
  for (var t = e; t !== null; ) {
    if (t.tag === 13) {
      var n = t.memoizedState;
      if (
        n !== null &&
        ((n = n.dehydrated), n === null || n.data === "$?" || n.data === "$!")
      )
        return t;
    } else if (t.tag === 19 && t.memoizedProps.revealOrder !== void 0) {
      if ((t.flags & 128) !== 0) return t;
    } else if (t.child !== null) {
      (t.child.return = t), (t = t.child);
      continue;
    }
    if (t === e) break;
    for (; t.sibling === null; ) {
      if (t.return === null || t.return === e) return null;
      t = t.return;
    }
    (t.sibling.return = t.return), (t = t.sibling);
  }
  return null;
}
var ul = [];
function $u() {
  for (var e = 0; e < ul.length; e++)
    ul[e]._workInProgressVersionPrimary = null;
  ul.length = 0;
}
var _o = dt.ReactCurrentDispatcher,
  al = dt.ReactCurrentBatchConfig,
  qt = 0,
  G = null,
  ee = null,
  re = null,
  si = !1,
  gr = !1,
  Mr = 0,
  bm = 0;
function ce() {
  throw Error(T(321));
}
function Ru(e, t) {
  if (t === null) return !1;
  for (var n = 0; n < t.length && n < e.length; n++)
    if (!Ge(e[n], t[n])) return !1;
  return !0;
}
function _u(e, t, n, r, o, i) {
  if (
    ((qt = i),
    (G = t),
    (t.memoizedState = null),
    (t.updateQueue = null),
    (t.lanes = 0),
    (_o.current = e === null || e.memoizedState === null ? zm : jm),
    (e = n(r, o)),
    gr)
  ) {
    i = 0;
    do {
      if (((gr = !1), (Mr = 0), 25 <= i)) throw Error(T(301));
      (i += 1),
        (re = ee = null),
        (t.updateQueue = null),
        (_o.current = Am),
        (e = n(r, o));
    } while (gr);
  }
  if (
    ((_o.current = ui),
    (t = ee !== null && ee.next !== null),
    (qt = 0),
    (re = ee = G = null),
    (si = !1),
    t)
  )
    throw Error(T(300));
  return e;
}
function Nu() {
  var e = Mr !== 0;
  return (Mr = 0), e;
}
function Ye() {
  var e = {
    memoizedState: null,
    baseState: null,
    baseQueue: null,
    queue: null,
    next: null,
  };
  return re === null ? (G.memoizedState = re = e) : (re = re.next = e), re;
}
function Ae() {
  if (ee === null) {
    var e = G.alternate;
    e = e !== null ? e.memoizedState : null;
  } else e = ee.next;
  var t = re === null ? G.memoizedState : re.next;
  if (t !== null) (re = t), (ee = e);
  else {
    if (e === null) throw Error(T(310));
    (ee = e),
      (e = {
        memoizedState: ee.memoizedState,
        baseState: ee.baseState,
        baseQueue: ee.baseQueue,
        queue: ee.queue,
        next: null,
      }),
      re === null ? (G.memoizedState = re = e) : (re = re.next = e);
  }
  return re;
}
function Lr(e, t) {
  return typeof t == "function" ? t(e) : t;
}
function cl(e) {
  var t = Ae(),
    n = t.queue;
  if (n === null) throw Error(T(311));
  n.lastRenderedReducer = e;
  var r = ee,
    o = r.baseQueue,
    i = n.pending;
  if (i !== null) {
    if (o !== null) {
      var l = o.next;
      (o.next = i.next), (i.next = l);
    }
    (r.baseQueue = o = i), (n.pending = null);
  }
  if (o !== null) {
    (i = o.next), (r = r.baseState);
    var s = (l = null),
      u = null,
      a = i;
    do {
      var c = a.lane;
      if ((qt & c) === c)
        u !== null &&
          (u = u.next =
            {
              lane: 0,
              action: a.action,
              hasEagerState: a.hasEagerState,
              eagerState: a.eagerState,
              next: null,
            }),
          (r = a.hasEagerState ? a.eagerState : e(r, a.action));
      else {
        var f = {
          lane: c,
          action: a.action,
          hasEagerState: a.hasEagerState,
          eagerState: a.eagerState,
          next: null,
        };
        u === null ? ((s = u = f), (l = r)) : (u = u.next = f),
          (G.lanes |= c),
          (Jt |= c);
      }
      a = a.next;
    } while (a !== null && a !== i);
    u === null ? (l = r) : (u.next = s),
      Ge(r, t.memoizedState) || (xe = !0),
      (t.memoizedState = r),
      (t.baseState = l),
      (t.baseQueue = u),
      (n.lastRenderedState = r);
  }
  if (((e = n.interleaved), e !== null)) {
    o = e;
    do (i = o.lane), (G.lanes |= i), (Jt |= i), (o = o.next);
    while (o !== e);
  } else o === null && (n.lanes = 0);
  return [t.memoizedState, n.dispatch];
}
function dl(e) {
  var t = Ae(),
    n = t.queue;
  if (n === null) throw Error(T(311));
  n.lastRenderedReducer = e;
  var r = n.dispatch,
    o = n.pending,
    i = t.memoizedState;
  if (o !== null) {
    n.pending = null;
    var l = (o = o.next);
    do (i = e(i, l.action)), (l = l.next);
    while (l !== o);
    Ge(i, t.memoizedState) || (xe = !0),
      (t.memoizedState = i),
      t.baseQueue === null && (t.baseState = i),
      (n.lastRenderedState = i);
  }
  return [i, r];
}
function Hf() {}
function Vf(e, t) {
  var n = G,
    r = Ae(),
    o = t(),
    i = !Ge(r.memoizedState, o);
  if (
    (i && ((r.memoizedState = o), (xe = !0)),
    (r = r.queue),
    bu(Kf.bind(null, n, r, e), [e]),
    r.getSnapshot !== t || i || (re !== null && re.memoizedState.tag & 1))
  ) {
    if (
      ((n.flags |= 2048),
      Fr(9, Gf.bind(null, n, r, o, t), void 0, null),
      oe === null)
    )
      throw Error(T(349));
    (qt & 30) !== 0 || Qf(n, t, o);
  }
  return o;
}
function Qf(e, t, n) {
  (e.flags |= 16384),
    (e = { getSnapshot: t, value: n }),
    (t = G.updateQueue),
    t === null
      ? ((t = { lastEffect: null, stores: null }),
        (G.updateQueue = t),
        (t.stores = [e]))
      : ((n = t.stores), n === null ? (t.stores = [e]) : n.push(e));
}
function Gf(e, t, n, r) {
  (t.value = n), (t.getSnapshot = r), Yf(t) && Xf(e);
}
function Kf(e, t, n) {
  return n(function () {
    Yf(t) && Xf(e);
  });
}
function Yf(e) {
  var t = e.getSnapshot;
  e = e.value;
  try {
    var n = t();
    return !Ge(e, n);
  } catch {
    return !0;
  }
}
function Xf(e) {
  var t = ut(e, 1);
  t !== null && Qe(t, e, 1, -1);
}
function nc(e) {
  var t = Ye();
  return (
    typeof e == "function" && (e = e()),
    (t.memoizedState = t.baseState = e),
    (e = {
      pending: null,
      interleaved: null,
      lanes: 0,
      dispatch: null,
      lastRenderedReducer: Lr,
      lastRenderedState: e,
    }),
    (t.queue = e),
    (e = e.dispatch = Fm.bind(null, G, e)),
    [t.memoizedState, e]
  );
}
function Fr(e, t, n, r) {
  return (
    (e = { tag: e, create: t, destroy: n, deps: r, next: null }),
    (t = G.updateQueue),
    t === null
      ? ((t = { lastEffect: null, stores: null }),
        (G.updateQueue = t),
        (t.lastEffect = e.next = e))
      : ((n = t.lastEffect),
        n === null
          ? (t.lastEffect = e.next = e)
          : ((r = n.next), (n.next = e), (e.next = r), (t.lastEffect = e))),
    e
  );
}
function Zf() {
  return Ae().memoizedState;
}
function No(e, t, n, r) {
  var o = Ye();
  (G.flags |= e),
    (o.memoizedState = Fr(1 | t, n, void 0, r === void 0 ? null : r));
}
function Ci(e, t, n, r) {
  var o = Ae();
  r = r === void 0 ? null : r;
  var i = void 0;
  if (ee !== null) {
    var l = ee.memoizedState;
    if (((i = l.destroy), r !== null && Ru(r, l.deps))) {
      o.memoizedState = Fr(t, n, i, r);
      return;
    }
  }
  (G.flags |= e), (o.memoizedState = Fr(1 | t, n, i, r));
}
function rc(e, t) {
  return No(8390656, 8, e, t);
}
function bu(e, t) {
  return Ci(2048, 8, e, t);
}
function qf(e, t) {
  return Ci(4, 2, e, t);
}
function Jf(e, t) {
  return Ci(4, 4, e, t);
}
function ep(e, t) {
  if (typeof t == "function")
    return (
      (e = e()),
      t(e),
      function () {
        t(null);
      }
    );
  if (t != null)
    return (
      (e = e()),
      (t.current = e),
      function () {
        t.current = null;
      }
    );
}
function tp(e, t, n) {
  return (
    (n = n != null ? n.concat([e]) : null), Ci(4, 4, ep.bind(null, t, e), n)
  );
}
function Mu() {}
function np(e, t) {
  var n = Ae();
  t = t === void 0 ? null : t;
  var r = n.memoizedState;
  return r !== null && t !== null && Ru(t, r[1])
    ? r[0]
    : ((n.memoizedState = [e, t]), e);
}
function rp(e, t) {
  var n = Ae();
  t = t === void 0 ? null : t;
  var r = n.memoizedState;
  return r !== null && t !== null && Ru(t, r[1])
    ? r[0]
    : ((e = e()), (n.memoizedState = [e, t]), e);
}
function op(e, t, n) {
  return (qt & 21) === 0
    ? (e.baseState && ((e.baseState = !1), (xe = !0)), (e.memoizedState = n))
    : (Ge(n, t) || ((n = sf()), (G.lanes |= n), (Jt |= n), (e.baseState = !0)),
      t);
}
function Mm(e, t) {
  var n = A;
  (A = n !== 0 && 4 > n ? n : 4), e(!0);
  var r = al.transition;
  al.transition = {};
  try {
    e(!1), t();
  } finally {
    (A = n), (al.transition = r);
  }
}
function ip() {
  return Ae().memoizedState;
}
function Lm(e, t, n) {
  var r = Tt(e);
  if (
    ((n = {
      lane: r,
      action: n,
      hasEagerState: !1,
      eagerState: null,
      next: null,
    }),
    lp(e))
  )
    sp(t, n);
  else if (((n = Ff(e, t, n, r)), n !== null)) {
    var o = ve();
    Qe(n, e, r, o), up(n, t, r);
  }
}
function Fm(e, t, n) {
  var r = Tt(e),
    o = { lane: r, action: n, hasEagerState: !1, eagerState: null, next: null };
  if (lp(e)) sp(t, o);
  else {
    var i = e.alternate;
    if (
      e.lanes === 0 &&
      (i === null || i.lanes === 0) &&
      ((i = t.lastRenderedReducer), i !== null)
    )
      try {
        var l = t.lastRenderedState,
          s = i(l, n);
        if (((o.hasEagerState = !0), (o.eagerState = s), Ge(s, l))) {
          var u = t.interleaved;
          u === null
            ? ((o.next = o), Tu(t))
            : ((o.next = u.next), (u.next = o)),
            (t.interleaved = o);
          return;
        }
      } catch {
      } finally {
      }
    (n = Ff(e, t, o, r)),
      n !== null && ((o = ve()), Qe(n, e, r, o), up(n, t, r));
  }
}
function lp(e) {
  var t = e.alternate;
  return e === G || (t !== null && t === G);
}
function sp(e, t) {
  gr = si = !0;
  var n = e.pending;
  n === null ? (t.next = t) : ((t.next = n.next), (n.next = t)),
    (e.pending = t);
}
function up(e, t, n) {
  if ((n & 4194240) !== 0) {
    var r = t.lanes;
    (r &= e.pendingLanes), (n |= r), (t.lanes = n), fu(e, n);
  }
}
var ui = {
    readContext: je,
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
    unstable_isNewReconciler: !1,
  },
  zm = {
    readContext: je,
    useCallback: function (e, t) {
      return (Ye().memoizedState = [e, t === void 0 ? null : t]), e;
    },
    useContext: je,
    useEffect: rc,
    useImperativeHandle: function (e, t, n) {
      return (
        (n = n != null ? n.concat([e]) : null),
        No(4194308, 4, ep.bind(null, t, e), n)
      );
    },
    useLayoutEffect: function (e, t) {
      return No(4194308, 4, e, t);
    },
    useInsertionEffect: function (e, t) {
      return No(4, 2, e, t);
    },
    useMemo: function (e, t) {
      var n = Ye();
      return (
        (t = t === void 0 ? null : t), (e = e()), (n.memoizedState = [e, t]), e
      );
    },
    useReducer: function (e, t, n) {
      var r = Ye();
      return (
        (t = n !== void 0 ? n(t) : t),
        (r.memoizedState = r.baseState = t),
        (e = {
          pending: null,
          interleaved: null,
          lanes: 0,
          dispatch: null,
          lastRenderedReducer: e,
          lastRenderedState: t,
        }),
        (r.queue = e),
        (e = e.dispatch = Lm.bind(null, G, e)),
        [r.memoizedState, e]
      );
    },
    useRef: function (e) {
      var t = Ye();
      return (e = { current: e }), (t.memoizedState = e);
    },
    useState: nc,
    useDebugValue: Mu,
    useDeferredValue: function (e) {
      return (Ye().memoizedState = e);
    },
    useTransition: function () {
      var e = nc(!1),
        t = e[0];
      return (e = Mm.bind(null, e[1])), (Ye().memoizedState = e), [t, e];
    },
    useMutableSource: function () {},
    useSyncExternalStore: function (e, t, n) {
      var r = G,
        o = Ye();
      if (V) {
        if (n === void 0) throw Error(T(407));
        n = n();
      } else {
        if (((n = t()), oe === null)) throw Error(T(349));
        (qt & 30) !== 0 || Qf(r, t, n);
      }
      o.memoizedState = n;
      var i = { value: n, getSnapshot: t };
      return (
        (o.queue = i),
        rc(Kf.bind(null, r, i, e), [e]),
        (r.flags |= 2048),
        Fr(9, Gf.bind(null, r, i, n, t), void 0, null),
        n
      );
    },
    useId: function () {
      var e = Ye(),
        t = oe.identifierPrefix;
      if (V) {
        var n = ot,
          r = rt;
        (n = (r & ~(1 << (32 - Ve(r) - 1))).toString(32) + n),
          (t = ":" + t + "R" + n),
          (n = Mr++),
          0 < n && (t += "H" + n.toString(32)),
          (t += ":");
      } else (n = bm++), (t = ":" + t + "r" + n.toString(32) + ":");
      return (e.memoizedState = t);
    },
    unstable_isNewReconciler: !1,
  },
  jm = {
    readContext: je,
    useCallback: np,
    useContext: je,
    useEffect: bu,
    useImperativeHandle: tp,
    useInsertionEffect: qf,
    useLayoutEffect: Jf,
    useMemo: rp,
    useReducer: cl,
    useRef: Zf,
    useState: function () {
      return cl(Lr);
    },
    useDebugValue: Mu,
    useDeferredValue: function (e) {
      var t = Ae();
      return op(t, ee.memoizedState, e);
    },
    useTransition: function () {
      var e = cl(Lr)[0],
        t = Ae().memoizedState;
      return [e, t];
    },
    useMutableSource: Hf,
    useSyncExternalStore: Vf,
    useId: ip,
    unstable_isNewReconciler: !1,
  },
  Am = {
    readContext: je,
    useCallback: np,
    useContext: je,
    useEffect: bu,
    useImperativeHandle: tp,
    useInsertionEffect: qf,
    useLayoutEffect: Jf,
    useMemo: rp,
    useReducer: dl,
    useRef: Zf,
    useState: function () {
      return dl(Lr);
    },
    useDebugValue: Mu,
    useDeferredValue: function (e) {
      var t = Ae();
      return ee === null ? (t.memoizedState = e) : op(t, ee.memoizedState, e);
    },
    useTransition: function () {
      var e = dl(Lr)[0],
        t = Ae().memoizedState;
      return [e, t];
    },
    useMutableSource: Hf,
    useSyncExternalStore: Vf,
    useId: ip,
    unstable_isNewReconciler: !1,
  };
function Bn(e, t) {
  try {
    var n = "",
      r = t;
    do (n += hg(r)), (r = r.return);
    while (r);
    var o = n;
  } catch (i) {
    o =
      `
Error generating stack: ` +
      i.message +
      `
` +
      i.stack;
  }
  return { value: e, source: t, stack: o, digest: null };
}
function fl(e, t, n) {
  return {
    value: e,
    source: null,
    stack: n != null ? n : null,
    digest: t != null ? t : null,
  };
}
function fs(e, t) {
  try {
    console.error(t.value);
  } catch (n) {
    setTimeout(function () {
      throw n;
    });
  }
}
var Bm = typeof WeakMap == "function" ? WeakMap : Map;
function ap(e, t, n) {
  (n = it(-1, n)), (n.tag = 3), (n.payload = { element: null });
  var r = t.value;
  return (
    (n.callback = function () {
      ci || ((ci = !0), (Es = r)), fs(e, t);
    }),
    n
  );
}
function cp(e, t, n) {
  (n = it(-1, n)), (n.tag = 3);
  var r = e.type.getDerivedStateFromError;
  if (typeof r == "function") {
    var o = t.value;
    (n.payload = function () {
      return r(o);
    }),
      (n.callback = function () {
        fs(e, t);
      });
  }
  var i = e.stateNode;
  return (
    i !== null &&
      typeof i.componentDidCatch == "function" &&
      (n.callback = function () {
        fs(e, t),
          typeof r != "function" &&
            (Ot === null ? (Ot = new Set([this])) : Ot.add(this));
        var l = t.stack;
        this.componentDidCatch(t.value, {
          componentStack: l !== null ? l : "",
        });
      }),
    n
  );
}
function oc(e, t, n) {
  var r = e.pingCache;
  if (r === null) {
    r = e.pingCache = new Bm();
    var o = new Set();
    r.set(t, o);
  } else (o = r.get(t)), o === void 0 && ((o = new Set()), r.set(t, o));
  o.has(n) || (o.add(n), (e = tv.bind(null, e, t, n)), t.then(e, e));
}
function ic(e) {
  do {
    var t;
    if (
      ((t = e.tag === 13) &&
        ((t = e.memoizedState), (t = t !== null ? t.dehydrated !== null : !0)),
      t)
    )
      return e;
    e = e.return;
  } while (e !== null);
  return null;
}
function lc(e, t, n, r, o) {
  return (e.mode & 1) === 0
    ? (e === t
        ? (e.flags |= 65536)
        : ((e.flags |= 128),
          (n.flags |= 131072),
          (n.flags &= -52805),
          n.tag === 1 &&
            (n.alternate === null
              ? (n.tag = 17)
              : ((t = it(-1, 1)), (t.tag = 2), kt(n, t, 1))),
          (n.lanes |= 1)),
      e)
    : ((e.flags |= 65536), (e.lanes = o), e);
}
var Um = dt.ReactCurrentOwner,
  xe = !1;
function ge(e, t, n, r) {
  t.child = e === null ? Uf(t, null, n, r) : jn(t, e.child, n, r);
}
function sc(e, t, n, r, o) {
  n = n.render;
  var i = t.ref;
  return (
    Nn(t, o),
    (r = _u(e, t, n, r, i, o)),
    (n = Nu()),
    e !== null && !xe
      ? ((t.updateQueue = e.updateQueue),
        (t.flags &= -2053),
        (e.lanes &= ~o),
        at(e, t, o))
      : (V && n && wu(t), (t.flags |= 1), ge(e, t, r, o), t.child)
  );
}
function uc(e, t, n, r, o) {
  if (e === null) {
    var i = n.type;
    return typeof i == "function" &&
      !Wu(i) &&
      i.defaultProps === void 0 &&
      n.compare === null &&
      n.defaultProps === void 0
      ? ((t.tag = 15), (t.type = i), dp(e, t, i, r, o))
      : ((e = Fo(n.type, null, r, t, t.mode, o)),
        (e.ref = t.ref),
        (e.return = t),
        (t.child = e));
  }
  if (((i = e.child), (e.lanes & o) === 0)) {
    var l = i.memoizedProps;
    if (
      ((n = n.compare), (n = n !== null ? n : Dr), n(l, r) && e.ref === t.ref)
    )
      return at(e, t, o);
  }
  return (
    (t.flags |= 1),
    (e = Pt(i, r)),
    (e.ref = t.ref),
    (e.return = t),
    (t.child = e)
  );
}
function dp(e, t, n, r, o) {
  if (e !== null) {
    var i = e.memoizedProps;
    if (Dr(i, r) && e.ref === t.ref)
      if (((xe = !1), (t.pendingProps = r = i), (e.lanes & o) !== 0))
        (e.flags & 131072) !== 0 && (xe = !0);
      else return (t.lanes = e.lanes), at(e, t, o);
  }
  return ps(e, t, n, r, o);
}
function fp(e, t, n) {
  var r = t.pendingProps,
    o = r.children,
    i = e !== null ? e.memoizedState : null;
  if (r.mode === "hidden")
    if ((t.mode & 1) === 0)
      (t.memoizedState = { baseLanes: 0, cachePool: null, transitions: null }),
        U(Pn, Oe),
        (Oe |= n);
    else {
      if ((n & 1073741824) === 0)
        return (
          (e = i !== null ? i.baseLanes | n : n),
          (t.lanes = t.childLanes = 1073741824),
          (t.memoizedState = {
            baseLanes: e,
            cachePool: null,
            transitions: null,
          }),
          (t.updateQueue = null),
          U(Pn, Oe),
          (Oe |= e),
          null
        );
      (t.memoizedState = { baseLanes: 0, cachePool: null, transitions: null }),
        (r = i !== null ? i.baseLanes : n),
        U(Pn, Oe),
        (Oe |= r);
    }
  else
    i !== null ? ((r = i.baseLanes | n), (t.memoizedState = null)) : (r = n),
      U(Pn, Oe),
      (Oe |= r);
  return ge(e, t, o, n), t.child;
}
function pp(e, t) {
  var n = t.ref;
  ((e === null && n !== null) || (e !== null && e.ref !== n)) &&
    ((t.flags |= 512), (t.flags |= 2097152));
}
function ps(e, t, n, r, o) {
  var i = Ce(n) ? Xt : pe.current;
  return (
    (i = Fn(t, i)),
    Nn(t, o),
    (n = _u(e, t, n, r, i, o)),
    (r = Nu()),
    e !== null && !xe
      ? ((t.updateQueue = e.updateQueue),
        (t.flags &= -2053),
        (e.lanes &= ~o),
        at(e, t, o))
      : (V && r && wu(t), (t.flags |= 1), ge(e, t, n, o), t.child)
  );
}
function ac(e, t, n, r, o) {
  if (Ce(n)) {
    var i = !0;
    ei(t);
  } else i = !1;
  if ((Nn(t, o), t.stateNode === null))
    bo(e, t), Af(t, n, r), ds(t, n, r, o), (r = !0);
  else if (e === null) {
    var l = t.stateNode,
      s = t.memoizedProps;
    l.props = s;
    var u = l.context,
      a = n.contextType;
    typeof a == "object" && a !== null
      ? (a = je(a))
      : ((a = Ce(n) ? Xt : pe.current), (a = Fn(t, a)));
    var c = n.getDerivedStateFromProps,
      f =
        typeof c == "function" ||
        typeof l.getSnapshotBeforeUpdate == "function";
    f ||
      (typeof l.UNSAFE_componentWillReceiveProps != "function" &&
        typeof l.componentWillReceiveProps != "function") ||
      ((s !== r || u !== a) && ec(t, l, r, a)),
      (ht = !1);
    var p = t.memoizedState;
    (l.state = p),
      ii(t, r, l, o),
      (u = t.memoizedState),
      s !== r || p !== u || Ee.current || ht
        ? (typeof c == "function" && (cs(t, n, c, r), (u = t.memoizedState)),
          (s = ht || Ja(t, n, s, r, p, u, a))
            ? (f ||
                (typeof l.UNSAFE_componentWillMount != "function" &&
                  typeof l.componentWillMount != "function") ||
                (typeof l.componentWillMount == "function" &&
                  l.componentWillMount(),
                typeof l.UNSAFE_componentWillMount == "function" &&
                  l.UNSAFE_componentWillMount()),
              typeof l.componentDidMount == "function" && (t.flags |= 4194308))
            : (typeof l.componentDidMount == "function" && (t.flags |= 4194308),
              (t.memoizedProps = r),
              (t.memoizedState = u)),
          (l.props = r),
          (l.state = u),
          (l.context = a),
          (r = s))
        : (typeof l.componentDidMount == "function" && (t.flags |= 4194308),
          (r = !1));
  } else {
    (l = t.stateNode),
      zf(e, t),
      (s = t.memoizedProps),
      (a = t.type === t.elementType ? s : Ue(t.type, s)),
      (l.props = a),
      (f = t.pendingProps),
      (p = l.context),
      (u = n.contextType),
      typeof u == "object" && u !== null
        ? (u = je(u))
        : ((u = Ce(n) ? Xt : pe.current), (u = Fn(t, u)));
    var y = n.getDerivedStateFromProps;
    (c =
      typeof y == "function" ||
      typeof l.getSnapshotBeforeUpdate == "function") ||
      (typeof l.UNSAFE_componentWillReceiveProps != "function" &&
        typeof l.componentWillReceiveProps != "function") ||
      ((s !== f || p !== u) && ec(t, l, r, u)),
      (ht = !1),
      (p = t.memoizedState),
      (l.state = p),
      ii(t, r, l, o);
    var S = t.memoizedState;
    s !== f || p !== S || Ee.current || ht
      ? (typeof y == "function" && (cs(t, n, y, r), (S = t.memoizedState)),
        (a = ht || Ja(t, n, a, r, p, S, u) || !1)
          ? (c ||
              (typeof l.UNSAFE_componentWillUpdate != "function" &&
                typeof l.componentWillUpdate != "function") ||
              (typeof l.componentWillUpdate == "function" &&
                l.componentWillUpdate(r, S, u),
              typeof l.UNSAFE_componentWillUpdate == "function" &&
                l.UNSAFE_componentWillUpdate(r, S, u)),
            typeof l.componentDidUpdate == "function" && (t.flags |= 4),
            typeof l.getSnapshotBeforeUpdate == "function" && (t.flags |= 1024))
          : (typeof l.componentDidUpdate != "function" ||
              (s === e.memoizedProps && p === e.memoizedState) ||
              (t.flags |= 4),
            typeof l.getSnapshotBeforeUpdate != "function" ||
              (s === e.memoizedProps && p === e.memoizedState) ||
              (t.flags |= 1024),
            (t.memoizedProps = r),
            (t.memoizedState = S)),
        (l.props = r),
        (l.state = S),
        (l.context = u),
        (r = a))
      : (typeof l.componentDidUpdate != "function" ||
          (s === e.memoizedProps && p === e.memoizedState) ||
          (t.flags |= 4),
        typeof l.getSnapshotBeforeUpdate != "function" ||
          (s === e.memoizedProps && p === e.memoizedState) ||
          (t.flags |= 1024),
        (r = !1));
  }
  return hs(e, t, n, r, i, o);
}
function hs(e, t, n, r, o, i) {
  pp(e, t);
  var l = (t.flags & 128) !== 0;
  if (!r && !l) return o && Ka(t, n, !1), at(e, t, i);
  (r = t.stateNode), (Um.current = t);
  var s =
    l && typeof n.getDerivedStateFromError != "function" ? null : r.render();
  return (
    (t.flags |= 1),
    e !== null && l
      ? ((t.child = jn(t, e.child, null, i)), (t.child = jn(t, null, s, i)))
      : ge(e, t, s, i),
    (t.memoizedState = r.state),
    o && Ka(t, n, !0),
    t.child
  );
}
function hp(e) {
  var t = e.stateNode;
  t.pendingContext
    ? Ga(e, t.pendingContext, t.pendingContext !== t.context)
    : t.context && Ga(e, t.context, !1),
    Iu(e, t.containerInfo);
}
function cc(e, t, n, r, o) {
  return zn(), Eu(o), (t.flags |= 256), ge(e, t, n, r), t.child;
}
var gs = { dehydrated: null, treeContext: null, retryLane: 0 };
function ms(e) {
  return { baseLanes: e, cachePool: null, transitions: null };
}
function gp(e, t, n) {
  var r = t.pendingProps,
    o = Q.current,
    i = !1,
    l = (t.flags & 128) !== 0,
    s;
  if (
    ((s = l) ||
      (s = e !== null && e.memoizedState === null ? !1 : (o & 2) !== 0),
    s
      ? ((i = !0), (t.flags &= -129))
      : (e === null || e.memoizedState !== null) && (o |= 1),
    U(Q, o & 1),
    e === null)
  )
    return (
      us(t),
      (e = t.memoizedState),
      e !== null && ((e = e.dehydrated), e !== null)
        ? ((t.mode & 1) === 0
            ? (t.lanes = 1)
            : e.data === "$!"
            ? (t.lanes = 8)
            : (t.lanes = 1073741824),
          null)
        : ((l = r.children),
          (e = r.fallback),
          i
            ? ((r = t.mode),
              (i = t.child),
              (l = { mode: "hidden", children: l }),
              (r & 1) === 0 && i !== null
                ? ((i.childLanes = 0), (i.pendingProps = l))
                : (i = Ti(l, r, 0, null)),
              (e = Qt(e, r, n, null)),
              (i.return = t),
              (e.return = t),
              (i.sibling = e),
              (t.child = i),
              (t.child.memoizedState = ms(n)),
              (t.memoizedState = gs),
              e)
            : Lu(t, l))
    );
  if (((o = e.memoizedState), o !== null && ((s = o.dehydrated), s !== null)))
    return Wm(e, t, l, r, s, o, n);
  if (i) {
    (i = r.fallback), (l = t.mode), (o = e.child), (s = o.sibling);
    var u = { mode: "hidden", children: r.children };
    return (
      (l & 1) === 0 && t.child !== o
        ? ((r = t.child),
          (r.childLanes = 0),
          (r.pendingProps = u),
          (t.deletions = null))
        : ((r = Pt(o, u)), (r.subtreeFlags = o.subtreeFlags & 14680064)),
      s !== null ? (i = Pt(s, i)) : ((i = Qt(i, l, n, null)), (i.flags |= 2)),
      (i.return = t),
      (r.return = t),
      (r.sibling = i),
      (t.child = r),
      (r = i),
      (i = t.child),
      (l = e.child.memoizedState),
      (l =
        l === null
          ? ms(n)
          : {
              baseLanes: l.baseLanes | n,
              cachePool: null,
              transitions: l.transitions,
            }),
      (i.memoizedState = l),
      (i.childLanes = e.childLanes & ~n),
      (t.memoizedState = gs),
      r
    );
  }
  return (
    (i = e.child),
    (e = i.sibling),
    (r = Pt(i, { mode: "visible", children: r.children })),
    (t.mode & 1) === 0 && (r.lanes = n),
    (r.return = t),
    (r.sibling = null),
    e !== null &&
      ((n = t.deletions),
      n === null ? ((t.deletions = [e]), (t.flags |= 16)) : n.push(e)),
    (t.child = r),
    (t.memoizedState = null),
    r
  );
}
function Lu(e, t) {
  return (
    (t = Ti({ mode: "visible", children: t }, e.mode, 0, null)),
    (t.return = e),
    (e.child = t)
  );
}
function go(e, t, n, r) {
  return (
    r !== null && Eu(r),
    jn(t, e.child, null, n),
    (e = Lu(t, t.pendingProps.children)),
    (e.flags |= 2),
    (t.memoizedState = null),
    e
  );
}
function Wm(e, t, n, r, o, i, l) {
  if (n)
    return t.flags & 256
      ? ((t.flags &= -257), (r = fl(Error(T(422)))), go(e, t, l, r))
      : t.memoizedState !== null
      ? ((t.child = e.child), (t.flags |= 128), null)
      : ((i = r.fallback),
        (o = t.mode),
        (r = Ti({ mode: "visible", children: r.children }, o, 0, null)),
        (i = Qt(i, o, l, null)),
        (i.flags |= 2),
        (r.return = t),
        (i.return = t),
        (r.sibling = i),
        (t.child = r),
        (t.mode & 1) !== 0 && jn(t, e.child, null, l),
        (t.child.memoizedState = ms(l)),
        (t.memoizedState = gs),
        i);
  if ((t.mode & 1) === 0) return go(e, t, l, null);
  if (o.data === "$!") {
    if (((r = o.nextSibling && o.nextSibling.dataset), r)) var s = r.dgst;
    return (r = s), (i = Error(T(419))), (r = fl(i, r, void 0)), go(e, t, l, r);
  }
  if (((s = (l & e.childLanes) !== 0), xe || s)) {
    if (((r = oe), r !== null)) {
      switch (l & -l) {
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
          o = 0;
      }
      (o = (o & (r.suspendedLanes | l)) !== 0 ? 0 : o),
        o !== 0 &&
          o !== i.retryLane &&
          ((i.retryLane = o), ut(e, o), Qe(r, e, o, -1));
    }
    return Uu(), (r = fl(Error(T(421)))), go(e, t, l, r);
  }
  return o.data === "$?"
    ? ((t.flags |= 128),
      (t.child = e.child),
      (t = nv.bind(null, e)),
      (o._reactRetry = t),
      null)
    : ((e = i.treeContext),
      (Te = Ct(o.nextSibling)),
      (Pe = t),
      (V = !0),
      (He = null),
      e !== null &&
        ((be[Me++] = rt),
        (be[Me++] = ot),
        (be[Me++] = Zt),
        (rt = e.id),
        (ot = e.overflow),
        (Zt = t)),
      (t = Lu(t, r.children)),
      (t.flags |= 4096),
      t);
}
function dc(e, t, n) {
  e.lanes |= t;
  var r = e.alternate;
  r !== null && (r.lanes |= t), as(e.return, t, n);
}
function pl(e, t, n, r, o) {
  var i = e.memoizedState;
  i === null
    ? (e.memoizedState = {
        isBackwards: t,
        rendering: null,
        renderingStartTime: 0,
        last: r,
        tail: n,
        tailMode: o,
      })
    : ((i.isBackwards = t),
      (i.rendering = null),
      (i.renderingStartTime = 0),
      (i.last = r),
      (i.tail = n),
      (i.tailMode = o));
}
function mp(e, t, n) {
  var r = t.pendingProps,
    o = r.revealOrder,
    i = r.tail;
  if ((ge(e, t, r.children, n), (r = Q.current), (r & 2) !== 0))
    (r = (r & 1) | 2), (t.flags |= 128);
  else {
    if (e !== null && (e.flags & 128) !== 0)
      e: for (e = t.child; e !== null; ) {
        if (e.tag === 13) e.memoizedState !== null && dc(e, n, t);
        else if (e.tag === 19) dc(e, n, t);
        else if (e.child !== null) {
          (e.child.return = e), (e = e.child);
          continue;
        }
        if (e === t) break e;
        for (; e.sibling === null; ) {
          if (e.return === null || e.return === t) break e;
          e = e.return;
        }
        (e.sibling.return = e.return), (e = e.sibling);
      }
    r &= 1;
  }
  if ((U(Q, r), (t.mode & 1) === 0)) t.memoizedState = null;
  else
    switch (o) {
      case "forwards":
        for (n = t.child, o = null; n !== null; )
          (e = n.alternate),
            e !== null && li(e) === null && (o = n),
            (n = n.sibling);
        (n = o),
          n === null
            ? ((o = t.child), (t.child = null))
            : ((o = n.sibling), (n.sibling = null)),
          pl(t, !1, o, n, i);
        break;
      case "backwards":
        for (n = null, o = t.child, t.child = null; o !== null; ) {
          if (((e = o.alternate), e !== null && li(e) === null)) {
            t.child = o;
            break;
          }
          (e = o.sibling), (o.sibling = n), (n = o), (o = e);
        }
        pl(t, !0, n, null, i);
        break;
      case "together":
        pl(t, !1, null, null, void 0);
        break;
      default:
        t.memoizedState = null;
    }
  return t.child;
}
function bo(e, t) {
  (t.mode & 1) === 0 &&
    e !== null &&
    ((e.alternate = null), (t.alternate = null), (t.flags |= 2));
}
function at(e, t, n) {
  if (
    (e !== null && (t.dependencies = e.dependencies),
    (Jt |= t.lanes),
    (n & t.childLanes) === 0)
  )
    return null;
  if (e !== null && t.child !== e.child) throw Error(T(153));
  if (t.child !== null) {
    for (
      e = t.child, n = Pt(e, e.pendingProps), t.child = n, n.return = t;
      e.sibling !== null;

    )
      (e = e.sibling), (n = n.sibling = Pt(e, e.pendingProps)), (n.return = t);
    n.sibling = null;
  }
  return t.child;
}
function Hm(e, t, n) {
  switch (t.tag) {
    case 3:
      hp(t), zn();
      break;
    case 5:
      Wf(t);
      break;
    case 1:
      Ce(t.type) && ei(t);
      break;
    case 4:
      Iu(t, t.stateNode.containerInfo);
      break;
    case 10:
      var r = t.type._context,
        o = t.memoizedProps.value;
      U(ri, r._currentValue), (r._currentValue = o);
      break;
    case 13:
      if (((r = t.memoizedState), r !== null))
        return r.dehydrated !== null
          ? (U(Q, Q.current & 1), (t.flags |= 128), null)
          : (n & t.child.childLanes) !== 0
          ? gp(e, t, n)
          : (U(Q, Q.current & 1),
            (e = at(e, t, n)),
            e !== null ? e.sibling : null);
      U(Q, Q.current & 1);
      break;
    case 19:
      if (((r = (n & t.childLanes) !== 0), (e.flags & 128) !== 0)) {
        if (r) return mp(e, t, n);
        t.flags |= 128;
      }
      if (
        ((o = t.memoizedState),
        o !== null &&
          ((o.rendering = null), (o.tail = null), (o.lastEffect = null)),
        U(Q, Q.current),
        r)
      )
        break;
      return null;
    case 22:
    case 23:
      return (t.lanes = 0), fp(e, t, n);
  }
  return at(e, t, n);
}
var vp, vs, yp, Sp;
vp = function (e, t) {
  for (var n = t.child; n !== null; ) {
    if (n.tag === 5 || n.tag === 6) e.appendChild(n.stateNode);
    else if (n.tag !== 4 && n.child !== null) {
      (n.child.return = n), (n = n.child);
      continue;
    }
    if (n === t) break;
    for (; n.sibling === null; ) {
      if (n.return === null || n.return === t) return;
      n = n.return;
    }
    (n.sibling.return = n.return), (n = n.sibling);
  }
};
vs = function () {};
yp = function (e, t, n, r) {
  var o = e.memoizedProps;
  if (o !== r) {
    (e = t.stateNode), Ht(Je.current);
    var i = null;
    switch (n) {
      case "input":
        (o = jl(e, o)), (r = jl(e, r)), (i = []);
        break;
      case "select":
        (o = K({}, o, { value: void 0 })),
          (r = K({}, r, { value: void 0 })),
          (i = []);
        break;
      case "textarea":
        (o = Ul(e, o)), (r = Ul(e, r)), (i = []);
        break;
      default:
        typeof o.onClick != "function" &&
          typeof r.onClick == "function" &&
          (e.onclick = qo);
    }
    Hl(n, r);
    var l;
    n = null;
    for (a in o)
      if (!r.hasOwnProperty(a) && o.hasOwnProperty(a) && o[a] != null)
        if (a === "style") {
          var s = o[a];
          for (l in s) s.hasOwnProperty(l) && (n || (n = {}), (n[l] = ""));
        } else
          a !== "dangerouslySetInnerHTML" &&
            a !== "children" &&
            a !== "suppressContentEditableWarning" &&
            a !== "suppressHydrationWarning" &&
            a !== "autoFocus" &&
            (Er.hasOwnProperty(a)
              ? i || (i = [])
              : (i = i || []).push(a, null));
    for (a in r) {
      var u = r[a];
      if (
        ((s = o != null ? o[a] : void 0),
        r.hasOwnProperty(a) && u !== s && (u != null || s != null))
      )
        if (a === "style")
          if (s) {
            for (l in s)
              !s.hasOwnProperty(l) ||
                (u && u.hasOwnProperty(l)) ||
                (n || (n = {}), (n[l] = ""));
            for (l in u)
              u.hasOwnProperty(l) &&
                s[l] !== u[l] &&
                (n || (n = {}), (n[l] = u[l]));
          } else n || (i || (i = []), i.push(a, n)), (n = u);
        else
          a === "dangerouslySetInnerHTML"
            ? ((u = u ? u.__html : void 0),
              (s = s ? s.__html : void 0),
              u != null && s !== u && (i = i || []).push(a, u))
            : a === "children"
            ? (typeof u != "string" && typeof u != "number") ||
              (i = i || []).push(a, "" + u)
            : a !== "suppressContentEditableWarning" &&
              a !== "suppressHydrationWarning" &&
              (Er.hasOwnProperty(a)
                ? (u != null && a === "onScroll" && W("scroll", e),
                  i || s === u || (i = []))
                : (i = i || []).push(a, u));
    }
    n && (i = i || []).push("style", n);
    var a = i;
    (t.updateQueue = a) && (t.flags |= 4);
  }
};
Sp = function (e, t, n, r) {
  n !== r && (t.flags |= 4);
};
function er(e, t) {
  if (!V)
    switch (e.tailMode) {
      case "hidden":
        t = e.tail;
        for (var n = null; t !== null; )
          t.alternate !== null && (n = t), (t = t.sibling);
        n === null ? (e.tail = null) : (n.sibling = null);
        break;
      case "collapsed":
        n = e.tail;
        for (var r = null; n !== null; )
          n.alternate !== null && (r = n), (n = n.sibling);
        r === null
          ? t || e.tail === null
            ? (e.tail = null)
            : (e.tail.sibling = null)
          : (r.sibling = null);
    }
}
function de(e) {
  var t = e.alternate !== null && e.alternate.child === e.child,
    n = 0,
    r = 0;
  if (t)
    for (var o = e.child; o !== null; )
      (n |= o.lanes | o.childLanes),
        (r |= o.subtreeFlags & 14680064),
        (r |= o.flags & 14680064),
        (o.return = e),
        (o = o.sibling);
  else
    for (o = e.child; o !== null; )
      (n |= o.lanes | o.childLanes),
        (r |= o.subtreeFlags),
        (r |= o.flags),
        (o.return = e),
        (o = o.sibling);
  return (e.subtreeFlags |= r), (e.childLanes = n), t;
}
function Vm(e, t, n) {
  var r = t.pendingProps;
  switch ((xu(t), t.tag)) {
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
      return de(t), null;
    case 1:
      return Ce(t.type) && Jo(), de(t), null;
    case 3:
      return (
        (r = t.stateNode),
        An(),
        H(Ee),
        H(pe),
        $u(),
        r.pendingContext &&
          ((r.context = r.pendingContext), (r.pendingContext = null)),
        (e === null || e.child === null) &&
          (po(t)
            ? (t.flags |= 4)
            : e === null ||
              (e.memoizedState.isDehydrated && (t.flags & 256) === 0) ||
              ((t.flags |= 1024), He !== null && (Os(He), (He = null)))),
        vs(e, t),
        de(t),
        null
      );
    case 5:
      Du(t);
      var o = Ht(br.current);
      if (((n = t.type), e !== null && t.stateNode != null))
        yp(e, t, n, r, o),
          e.ref !== t.ref && ((t.flags |= 512), (t.flags |= 2097152));
      else {
        if (!r) {
          if (t.stateNode === null) throw Error(T(166));
          return de(t), null;
        }
        if (((e = Ht(Je.current)), po(t))) {
          (r = t.stateNode), (n = t.type);
          var i = t.memoizedProps;
          switch (((r[Xe] = t), (r[_r] = i), (e = (t.mode & 1) !== 0), n)) {
            case "dialog":
              W("cancel", r), W("close", r);
              break;
            case "iframe":
            case "object":
            case "embed":
              W("load", r);
              break;
            case "video":
            case "audio":
              for (o = 0; o < ur.length; o++) W(ur[o], r);
              break;
            case "source":
              W("error", r);
              break;
            case "img":
            case "image":
            case "link":
              W("error", r), W("load", r);
              break;
            case "details":
              W("toggle", r);
              break;
            case "input":
              wa(r, i), W("invalid", r);
              break;
            case "select":
              (r._wrapperState = { wasMultiple: !!i.multiple }),
                W("invalid", r);
              break;
            case "textarea":
              Ea(r, i), W("invalid", r);
          }
          Hl(n, i), (o = null);
          for (var l in i)
            if (i.hasOwnProperty(l)) {
              var s = i[l];
              l === "children"
                ? typeof s == "string"
                  ? r.textContent !== s &&
                    (i.suppressHydrationWarning !== !0 &&
                      fo(r.textContent, s, e),
                    (o = ["children", s]))
                  : typeof s == "number" &&
                    r.textContent !== "" + s &&
                    (i.suppressHydrationWarning !== !0 &&
                      fo(r.textContent, s, e),
                    (o = ["children", "" + s]))
                : Er.hasOwnProperty(l) &&
                  s != null &&
                  l === "onScroll" &&
                  W("scroll", r);
            }
          switch (n) {
            case "input":
              ro(r), xa(r, i, !0);
              break;
            case "textarea":
              ro(r), Ca(r);
              break;
            case "select":
            case "option":
              break;
            default:
              typeof i.onClick == "function" && (r.onclick = qo);
          }
          (r = o), (t.updateQueue = r), r !== null && (t.flags |= 4);
        } else {
          (l = o.nodeType === 9 ? o : o.ownerDocument),
            e === "http://www.w3.org/1999/xhtml" && (e = Vd(n)),
            e === "http://www.w3.org/1999/xhtml"
              ? n === "script"
                ? ((e = l.createElement("div")),
                  (e.innerHTML = "<script></script>"),
                  (e = e.removeChild(e.firstChild)))
                : typeof r.is == "string"
                ? (e = l.createElement(n, { is: r.is }))
                : ((e = l.createElement(n)),
                  n === "select" &&
                    ((l = e),
                    r.multiple
                      ? (l.multiple = !0)
                      : r.size && (l.size = r.size)))
              : (e = l.createElementNS(e, n)),
            (e[Xe] = t),
            (e[_r] = r),
            vp(e, t, !1, !1),
            (t.stateNode = e);
          e: {
            switch (((l = Vl(n, r)), n)) {
              case "dialog":
                W("cancel", e), W("close", e), (o = r);
                break;
              case "iframe":
              case "object":
              case "embed":
                W("load", e), (o = r);
                break;
              case "video":
              case "audio":
                for (o = 0; o < ur.length; o++) W(ur[o], e);
                o = r;
                break;
              case "source":
                W("error", e), (o = r);
                break;
              case "img":
              case "image":
              case "link":
                W("error", e), W("load", e), (o = r);
                break;
              case "details":
                W("toggle", e), (o = r);
                break;
              case "input":
                wa(e, r), (o = jl(e, r)), W("invalid", e);
                break;
              case "option":
                o = r;
                break;
              case "select":
                (e._wrapperState = { wasMultiple: !!r.multiple }),
                  (o = K({}, r, { value: void 0 })),
                  W("invalid", e);
                break;
              case "textarea":
                Ea(e, r), (o = Ul(e, r)), W("invalid", e);
                break;
              default:
                o = r;
            }
            Hl(n, o), (s = o);
            for (i in s)
              if (s.hasOwnProperty(i)) {
                var u = s[i];
                i === "style"
                  ? Kd(e, u)
                  : i === "dangerouslySetInnerHTML"
                  ? ((u = u ? u.__html : void 0), u != null && Qd(e, u))
                  : i === "children"
                  ? typeof u == "string"
                    ? (n !== "textarea" || u !== "") && Cr(e, u)
                    : typeof u == "number" && Cr(e, "" + u)
                  : i !== "suppressContentEditableWarning" &&
                    i !== "suppressHydrationWarning" &&
                    i !== "autoFocus" &&
                    (Er.hasOwnProperty(i)
                      ? u != null && i === "onScroll" && W("scroll", e)
                      : u != null && lu(e, i, u, l));
              }
            switch (n) {
              case "input":
                ro(e), xa(e, r, !1);
                break;
              case "textarea":
                ro(e), Ca(e);
                break;
              case "option":
                r.value != null && e.setAttribute("value", "" + Dt(r.value));
                break;
              case "select":
                (e.multiple = !!r.multiple),
                  (i = r.value),
                  i != null
                    ? Dn(e, !!r.multiple, i, !1)
                    : r.defaultValue != null &&
                      Dn(e, !!r.multiple, r.defaultValue, !0);
                break;
              default:
                typeof o.onClick == "function" && (e.onclick = qo);
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
                r = !1;
            }
          }
          r && (t.flags |= 4);
        }
        t.ref !== null && ((t.flags |= 512), (t.flags |= 2097152));
      }
      return de(t), null;
    case 6:
      if (e && t.stateNode != null) Sp(e, t, e.memoizedProps, r);
      else {
        if (typeof r != "string" && t.stateNode === null) throw Error(T(166));
        if (((n = Ht(br.current)), Ht(Je.current), po(t))) {
          if (
            ((r = t.stateNode),
            (n = t.memoizedProps),
            (r[Xe] = t),
            (i = r.nodeValue !== n) && ((e = Pe), e !== null))
          )
            switch (e.tag) {
              case 3:
                fo(r.nodeValue, n, (e.mode & 1) !== 0);
                break;
              case 5:
                e.memoizedProps.suppressHydrationWarning !== !0 &&
                  fo(r.nodeValue, n, (e.mode & 1) !== 0);
            }
          i && (t.flags |= 4);
        } else
          (r = (n.nodeType === 9 ? n : n.ownerDocument).createTextNode(r)),
            (r[Xe] = t),
            (t.stateNode = r);
      }
      return de(t), null;
    case 13:
      if (
        (H(Q),
        (r = t.memoizedState),
        e === null ||
          (e.memoizedState !== null && e.memoizedState.dehydrated !== null))
      ) {
        if (V && Te !== null && (t.mode & 1) !== 0 && (t.flags & 128) === 0)
          Lf(), zn(), (t.flags |= 98560), (i = !1);
        else if (((i = po(t)), r !== null && r.dehydrated !== null)) {
          if (e === null) {
            if (!i) throw Error(T(318));
            if (
              ((i = t.memoizedState),
              (i = i !== null ? i.dehydrated : null),
              !i)
            )
              throw Error(T(317));
            i[Xe] = t;
          } else
            zn(),
              (t.flags & 128) === 0 && (t.memoizedState = null),
              (t.flags |= 4);
          de(t), (i = !1);
        } else He !== null && (Os(He), (He = null)), (i = !0);
        if (!i) return t.flags & 65536 ? t : null;
      }
      return (t.flags & 128) !== 0
        ? ((t.lanes = n), t)
        : ((r = r !== null),
          r !== (e !== null && e.memoizedState !== null) &&
            r &&
            ((t.child.flags |= 8192),
            (t.mode & 1) !== 0 &&
              (e === null || (Q.current & 1) !== 0
                ? te === 0 && (te = 3)
                : Uu())),
          t.updateQueue !== null && (t.flags |= 4),
          de(t),
          null);
    case 4:
      return (
        An(), vs(e, t), e === null && $r(t.stateNode.containerInfo), de(t), null
      );
    case 10:
      return Ou(t.type._context), de(t), null;
    case 17:
      return Ce(t.type) && Jo(), de(t), null;
    case 19:
      if ((H(Q), (i = t.memoizedState), i === null)) return de(t), null;
      if (((r = (t.flags & 128) !== 0), (l = i.rendering), l === null))
        if (r) er(i, !1);
        else {
          if (te !== 0 || (e !== null && (e.flags & 128) !== 0))
            for (e = t.child; e !== null; ) {
              if (((l = li(e)), l !== null)) {
                for (
                  t.flags |= 128,
                    er(i, !1),
                    r = l.updateQueue,
                    r !== null && ((t.updateQueue = r), (t.flags |= 4)),
                    t.subtreeFlags = 0,
                    r = n,
                    n = t.child;
                  n !== null;

                )
                  (i = n),
                    (e = r),
                    (i.flags &= 14680066),
                    (l = i.alternate),
                    l === null
                      ? ((i.childLanes = 0),
                        (i.lanes = e),
                        (i.child = null),
                        (i.subtreeFlags = 0),
                        (i.memoizedProps = null),
                        (i.memoizedState = null),
                        (i.updateQueue = null),
                        (i.dependencies = null),
                        (i.stateNode = null))
                      : ((i.childLanes = l.childLanes),
                        (i.lanes = l.lanes),
                        (i.child = l.child),
                        (i.subtreeFlags = 0),
                        (i.deletions = null),
                        (i.memoizedProps = l.memoizedProps),
                        (i.memoizedState = l.memoizedState),
                        (i.updateQueue = l.updateQueue),
                        (i.type = l.type),
                        (e = l.dependencies),
                        (i.dependencies =
                          e === null
                            ? null
                            : {
                                lanes: e.lanes,
                                firstContext: e.firstContext,
                              })),
                    (n = n.sibling);
                return U(Q, (Q.current & 1) | 2), t.child;
              }
              e = e.sibling;
            }
          i.tail !== null &&
            Z() > Un &&
            ((t.flags |= 128), (r = !0), er(i, !1), (t.lanes = 4194304));
        }
      else {
        if (!r)
          if (((e = li(l)), e !== null)) {
            if (
              ((t.flags |= 128),
              (r = !0),
              (n = e.updateQueue),
              n !== null && ((t.updateQueue = n), (t.flags |= 4)),
              er(i, !0),
              i.tail === null && i.tailMode === "hidden" && !l.alternate && !V)
            )
              return de(t), null;
          } else
            2 * Z() - i.renderingStartTime > Un &&
              n !== 1073741824 &&
              ((t.flags |= 128), (r = !0), er(i, !1), (t.lanes = 4194304));
        i.isBackwards
          ? ((l.sibling = t.child), (t.child = l))
          : ((n = i.last),
            n !== null ? (n.sibling = l) : (t.child = l),
            (i.last = l));
      }
      return i.tail !== null
        ? ((t = i.tail),
          (i.rendering = t),
          (i.tail = t.sibling),
          (i.renderingStartTime = Z()),
          (t.sibling = null),
          (n = Q.current),
          U(Q, r ? (n & 1) | 2 : n & 1),
          t)
        : (de(t), null);
    case 22:
    case 23:
      return (
        Bu(),
        (r = t.memoizedState !== null),
        e !== null && (e.memoizedState !== null) !== r && (t.flags |= 8192),
        r && (t.mode & 1) !== 0
          ? (Oe & 1073741824) !== 0 &&
            (de(t), t.subtreeFlags & 6 && (t.flags |= 8192))
          : de(t),
        null
      );
    case 24:
      return null;
    case 25:
      return null;
  }
  throw Error(T(156, t.tag));
}
function Qm(e, t) {
  switch ((xu(t), t.tag)) {
    case 1:
      return (
        Ce(t.type) && Jo(),
        (e = t.flags),
        e & 65536 ? ((t.flags = (e & -65537) | 128), t) : null
      );
    case 3:
      return (
        An(),
        H(Ee),
        H(pe),
        $u(),
        (e = t.flags),
        (e & 65536) !== 0 && (e & 128) === 0
          ? ((t.flags = (e & -65537) | 128), t)
          : null
      );
    case 5:
      return Du(t), null;
    case 13:
      if ((H(Q), (e = t.memoizedState), e !== null && e.dehydrated !== null)) {
        if (t.alternate === null) throw Error(T(340));
        zn();
      }
      return (
        (e = t.flags), e & 65536 ? ((t.flags = (e & -65537) | 128), t) : null
      );
    case 19:
      return H(Q), null;
    case 4:
      return An(), null;
    case 10:
      return Ou(t.type._context), null;
    case 22:
    case 23:
      return Bu(), null;
    case 24:
      return null;
    default:
      return null;
  }
}
var mo = !1,
  fe = !1,
  Gm = typeof WeakSet == "function" ? WeakSet : Set,
  D = null;
function Tn(e, t) {
  var n = e.ref;
  if (n !== null)
    if (typeof n == "function")
      try {
        n(null);
      } catch (r) {
        Y(e, t, r);
      }
    else n.current = null;
}
function ys(e, t, n) {
  try {
    n();
  } catch (r) {
    Y(e, t, r);
  }
}
var fc = !1;
function Km(e, t) {
  if (((ts = Yo), (e = Cf()), Su(e))) {
    if ("selectionStart" in e)
      var n = { start: e.selectionStart, end: e.selectionEnd };
    else
      e: {
        n = ((n = e.ownerDocument) && n.defaultView) || window;
        var r = n.getSelection && n.getSelection();
        if (r && r.rangeCount !== 0) {
          n = r.anchorNode;
          var o = r.anchorOffset,
            i = r.focusNode;
          r = r.focusOffset;
          try {
            n.nodeType, i.nodeType;
          } catch {
            n = null;
            break e;
          }
          var l = 0,
            s = -1,
            u = -1,
            a = 0,
            c = 0,
            f = e,
            p = null;
          t: for (;;) {
            for (
              var y;
              f !== n || (o !== 0 && f.nodeType !== 3) || (s = l + o),
                f !== i || (r !== 0 && f.nodeType !== 3) || (u = l + r),
                f.nodeType === 3 && (l += f.nodeValue.length),
                (y = f.firstChild) !== null;

            )
              (p = f), (f = y);
            for (;;) {
              if (f === e) break t;
              if (
                (p === n && ++a === o && (s = l),
                p === i && ++c === r && (u = l),
                (y = f.nextSibling) !== null)
              )
                break;
              (f = p), (p = f.parentNode);
            }
            f = y;
          }
          n = s === -1 || u === -1 ? null : { start: s, end: u };
        } else n = null;
      }
    n = n || { start: 0, end: 0 };
  } else n = null;
  for (ns = { focusedElem: e, selectionRange: n }, Yo = !1, D = t; D !== null; )
    if (((t = D), (e = t.child), (t.subtreeFlags & 1028) !== 0 && e !== null))
      (e.return = t), (D = e);
    else
      for (; D !== null; ) {
        t = D;
        try {
          var S = t.alternate;
          if ((t.flags & 1024) !== 0)
            switch (t.tag) {
              case 0:
              case 11:
              case 15:
                break;
              case 1:
                if (S !== null) {
                  var m = S.memoizedProps,
                    C = S.memoizedState,
                    h = t.stateNode,
                    d = h.getSnapshotBeforeUpdate(
                      t.elementType === t.type ? m : Ue(t.type, m),
                      C
                    );
                  h.__reactInternalSnapshotBeforeUpdate = d;
                }
                break;
              case 3:
                var v = t.stateNode.containerInfo;
                v.nodeType === 1
                  ? (v.textContent = "")
                  : v.nodeType === 9 &&
                    v.documentElement &&
                    v.removeChild(v.documentElement);
                break;
              case 5:
              case 6:
              case 4:
              case 17:
                break;
              default:
                throw Error(T(163));
            }
        } catch (w) {
          Y(t, t.return, w);
        }
        if (((e = t.sibling), e !== null)) {
          (e.return = t.return), (D = e);
          break;
        }
        D = t.return;
      }
  return (S = fc), (fc = !1), S;
}
function mr(e, t, n) {
  var r = t.updateQueue;
  if (((r = r !== null ? r.lastEffect : null), r !== null)) {
    var o = (r = r.next);
    do {
      if ((o.tag & e) === e) {
        var i = o.destroy;
        (o.destroy = void 0), i !== void 0 && ys(t, n, i);
      }
      o = o.next;
    } while (o !== r);
  }
}
function ki(e, t) {
  if (
    ((t = t.updateQueue), (t = t !== null ? t.lastEffect : null), t !== null)
  ) {
    var n = (t = t.next);
    do {
      if ((n.tag & e) === e) {
        var r = n.create;
        n.destroy = r();
      }
      n = n.next;
    } while (n !== t);
  }
}
function Ss(e) {
  var t = e.ref;
  if (t !== null) {
    var n = e.stateNode;
    switch (e.tag) {
      case 5:
        e = n;
        break;
      default:
        e = n;
    }
    typeof t == "function" ? t(e) : (t.current = e);
  }
}
function wp(e) {
  var t = e.alternate;
  t !== null && ((e.alternate = null), wp(t)),
    (e.child = null),
    (e.deletions = null),
    (e.sibling = null),
    e.tag === 5 &&
      ((t = e.stateNode),
      t !== null &&
        (delete t[Xe], delete t[_r], delete t[is], delete t[$m], delete t[Rm])),
    (e.stateNode = null),
    (e.return = null),
    (e.dependencies = null),
    (e.memoizedProps = null),
    (e.memoizedState = null),
    (e.pendingProps = null),
    (e.stateNode = null),
    (e.updateQueue = null);
}
function xp(e) {
  return e.tag === 5 || e.tag === 3 || e.tag === 4;
}
function pc(e) {
  e: for (;;) {
    for (; e.sibling === null; ) {
      if (e.return === null || xp(e.return)) return null;
      e = e.return;
    }
    for (
      e.sibling.return = e.return, e = e.sibling;
      e.tag !== 5 && e.tag !== 6 && e.tag !== 18;

    ) {
      if (e.flags & 2 || e.child === null || e.tag === 4) continue e;
      (e.child.return = e), (e = e.child);
    }
    if (!(e.flags & 2)) return e.stateNode;
  }
}
function ws(e, t, n) {
  var r = e.tag;
  if (r === 5 || r === 6)
    (e = e.stateNode),
      t
        ? n.nodeType === 8
          ? n.parentNode.insertBefore(e, t)
          : n.insertBefore(e, t)
        : (n.nodeType === 8
            ? ((t = n.parentNode), t.insertBefore(e, n))
            : ((t = n), t.appendChild(e)),
          (n = n._reactRootContainer),
          n != null || t.onclick !== null || (t.onclick = qo));
  else if (r !== 4 && ((e = e.child), e !== null))
    for (ws(e, t, n), e = e.sibling; e !== null; ) ws(e, t, n), (e = e.sibling);
}
function xs(e, t, n) {
  var r = e.tag;
  if (r === 5 || r === 6)
    (e = e.stateNode), t ? n.insertBefore(e, t) : n.appendChild(e);
  else if (r !== 4 && ((e = e.child), e !== null))
    for (xs(e, t, n), e = e.sibling; e !== null; ) xs(e, t, n), (e = e.sibling);
}
var le = null,
  We = !1;
function ft(e, t, n) {
  for (n = n.child; n !== null; ) Ep(e, t, n), (n = n.sibling);
}
function Ep(e, t, n) {
  if (qe && typeof qe.onCommitFiberUnmount == "function")
    try {
      qe.onCommitFiberUnmount(mi, n);
    } catch {}
  switch (n.tag) {
    case 5:
      fe || Tn(n, t);
    case 6:
      var r = le,
        o = We;
      (le = null),
        ft(e, t, n),
        (le = r),
        (We = o),
        le !== null &&
          (We
            ? ((e = le),
              (n = n.stateNode),
              e.nodeType === 8 ? e.parentNode.removeChild(n) : e.removeChild(n))
            : le.removeChild(n.stateNode));
      break;
    case 18:
      le !== null &&
        (We
          ? ((e = le),
            (n = n.stateNode),
            e.nodeType === 8
              ? ll(e.parentNode, n)
              : e.nodeType === 1 && ll(e, n),
            Pr(e))
          : ll(le, n.stateNode));
      break;
    case 4:
      (r = le),
        (o = We),
        (le = n.stateNode.containerInfo),
        (We = !0),
        ft(e, t, n),
        (le = r),
        (We = o);
      break;
    case 0:
    case 11:
    case 14:
    case 15:
      if (
        !fe &&
        ((r = n.updateQueue), r !== null && ((r = r.lastEffect), r !== null))
      ) {
        o = r = r.next;
        do {
          var i = o,
            l = i.destroy;
          (i = i.tag),
            l !== void 0 && ((i & 2) !== 0 || (i & 4) !== 0) && ys(n, t, l),
            (o = o.next);
        } while (o !== r);
      }
      ft(e, t, n);
      break;
    case 1:
      if (
        !fe &&
        (Tn(n, t),
        (r = n.stateNode),
        typeof r.componentWillUnmount == "function")
      )
        try {
          (r.props = n.memoizedProps),
            (r.state = n.memoizedState),
            r.componentWillUnmount();
        } catch (s) {
          Y(n, t, s);
        }
      ft(e, t, n);
      break;
    case 21:
      ft(e, t, n);
      break;
    case 22:
      n.mode & 1
        ? ((fe = (r = fe) || n.memoizedState !== null), ft(e, t, n), (fe = r))
        : ft(e, t, n);
      break;
    default:
      ft(e, t, n);
  }
}
function hc(e) {
  var t = e.updateQueue;
  if (t !== null) {
    e.updateQueue = null;
    var n = e.stateNode;
    n === null && (n = e.stateNode = new Gm()),
      t.forEach(function (r) {
        var o = rv.bind(null, e, r);
        n.has(r) || (n.add(r), r.then(o, o));
      });
  }
}
function Be(e, t) {
  var n = t.deletions;
  if (n !== null)
    for (var r = 0; r < n.length; r++) {
      var o = n[r];
      try {
        var i = e,
          l = t,
          s = l;
        e: for (; s !== null; ) {
          switch (s.tag) {
            case 5:
              (le = s.stateNode), (We = !1);
              break e;
            case 3:
              (le = s.stateNode.containerInfo), (We = !0);
              break e;
            case 4:
              (le = s.stateNode.containerInfo), (We = !0);
              break e;
          }
          s = s.return;
        }
        if (le === null) throw Error(T(160));
        Ep(i, l, o), (le = null), (We = !1);
        var u = o.alternate;
        u !== null && (u.return = null), (o.return = null);
      } catch (a) {
        Y(o, t, a);
      }
    }
  if (t.subtreeFlags & 12854)
    for (t = t.child; t !== null; ) Cp(t, e), (t = t.sibling);
}
function Cp(e, t) {
  var n = e.alternate,
    r = e.flags;
  switch (e.tag) {
    case 0:
    case 11:
    case 14:
    case 15:
      if ((Be(t, e), Ke(e), r & 4)) {
        try {
          mr(3, e, e.return), ki(3, e);
        } catch (m) {
          Y(e, e.return, m);
        }
        try {
          mr(5, e, e.return);
        } catch (m) {
          Y(e, e.return, m);
        }
      }
      break;
    case 1:
      Be(t, e), Ke(e), r & 512 && n !== null && Tn(n, n.return);
      break;
    case 5:
      if (
        (Be(t, e),
        Ke(e),
        r & 512 && n !== null && Tn(n, n.return),
        e.flags & 32)
      ) {
        var o = e.stateNode;
        try {
          Cr(o, "");
        } catch (m) {
          Y(e, e.return, m);
        }
      }
      if (r & 4 && ((o = e.stateNode), o != null)) {
        var i = e.memoizedProps,
          l = n !== null ? n.memoizedProps : i,
          s = e.type,
          u = e.updateQueue;
        if (((e.updateQueue = null), u !== null))
          try {
            s === "input" && i.type === "radio" && i.name != null && Wd(o, i),
              Vl(s, l);
            var a = Vl(s, i);
            for (l = 0; l < u.length; l += 2) {
              var c = u[l],
                f = u[l + 1];
              c === "style"
                ? Kd(o, f)
                : c === "dangerouslySetInnerHTML"
                ? Qd(o, f)
                : c === "children"
                ? Cr(o, f)
                : lu(o, c, f, a);
            }
            switch (s) {
              case "input":
                Al(o, i);
                break;
              case "textarea":
                Hd(o, i);
                break;
              case "select":
                var p = o._wrapperState.wasMultiple;
                o._wrapperState.wasMultiple = !!i.multiple;
                var y = i.value;
                y != null
                  ? Dn(o, !!i.multiple, y, !1)
                  : p !== !!i.multiple &&
                    (i.defaultValue != null
                      ? Dn(o, !!i.multiple, i.defaultValue, !0)
                      : Dn(o, !!i.multiple, i.multiple ? [] : "", !1));
            }
            o[_r] = i;
          } catch (m) {
            Y(e, e.return, m);
          }
      }
      break;
    case 6:
      if ((Be(t, e), Ke(e), r & 4)) {
        if (e.stateNode === null) throw Error(T(162));
        (o = e.stateNode), (i = e.memoizedProps);
        try {
          o.nodeValue = i;
        } catch (m) {
          Y(e, e.return, m);
        }
      }
      break;
    case 3:
      if (
        (Be(t, e), Ke(e), r & 4 && n !== null && n.memoizedState.isDehydrated)
      )
        try {
          Pr(t.containerInfo);
        } catch (m) {
          Y(e, e.return, m);
        }
      break;
    case 4:
      Be(t, e), Ke(e);
      break;
    case 13:
      Be(t, e),
        Ke(e),
        (o = e.child),
        o.flags & 8192 &&
          ((i = o.memoizedState !== null),
          (o.stateNode.isHidden = i),
          !i ||
            (o.alternate !== null && o.alternate.memoizedState !== null) ||
            (ju = Z())),
        r & 4 && hc(e);
      break;
    case 22:
      if (
        ((c = n !== null && n.memoizedState !== null),
        e.mode & 1 ? ((fe = (a = fe) || c), Be(t, e), (fe = a)) : Be(t, e),
        Ke(e),
        r & 8192)
      ) {
        if (
          ((a = e.memoizedState !== null),
          (e.stateNode.isHidden = a) && !c && (e.mode & 1) !== 0)
        )
          for (D = e, c = e.child; c !== null; ) {
            for (f = D = c; D !== null; ) {
              switch (((p = D), (y = p.child), p.tag)) {
                case 0:
                case 11:
                case 14:
                case 15:
                  mr(4, p, p.return);
                  break;
                case 1:
                  Tn(p, p.return);
                  var S = p.stateNode;
                  if (typeof S.componentWillUnmount == "function") {
                    (r = p), (n = p.return);
                    try {
                      (t = r),
                        (S.props = t.memoizedProps),
                        (S.state = t.memoizedState),
                        S.componentWillUnmount();
                    } catch (m) {
                      Y(r, n, m);
                    }
                  }
                  break;
                case 5:
                  Tn(p, p.return);
                  break;
                case 22:
                  if (p.memoizedState !== null) {
                    mc(f);
                    continue;
                  }
              }
              y !== null ? ((y.return = p), (D = y)) : mc(f);
            }
            c = c.sibling;
          }
        e: for (c = null, f = e; ; ) {
          if (f.tag === 5) {
            if (c === null) {
              c = f;
              try {
                (o = f.stateNode),
                  a
                    ? ((i = o.style),
                      typeof i.setProperty == "function"
                        ? i.setProperty("display", "none", "important")
                        : (i.display = "none"))
                    : ((s = f.stateNode),
                      (u = f.memoizedProps.style),
                      (l =
                        u != null && u.hasOwnProperty("display")
                          ? u.display
                          : null),
                      (s.style.display = Gd("display", l)));
              } catch (m) {
                Y(e, e.return, m);
              }
            }
          } else if (f.tag === 6) {
            if (c === null)
              try {
                f.stateNode.nodeValue = a ? "" : f.memoizedProps;
              } catch (m) {
                Y(e, e.return, m);
              }
          } else if (
            ((f.tag !== 22 && f.tag !== 23) ||
              f.memoizedState === null ||
              f === e) &&
            f.child !== null
          ) {
            (f.child.return = f), (f = f.child);
            continue;
          }
          if (f === e) break e;
          for (; f.sibling === null; ) {
            if (f.return === null || f.return === e) break e;
            c === f && (c = null), (f = f.return);
          }
          c === f && (c = null), (f.sibling.return = f.return), (f = f.sibling);
        }
      }
      break;
    case 19:
      Be(t, e), Ke(e), r & 4 && hc(e);
      break;
    case 21:
      break;
    default:
      Be(t, e), Ke(e);
  }
}
function Ke(e) {
  var t = e.flags;
  if (t & 2) {
    try {
      e: {
        for (var n = e.return; n !== null; ) {
          if (xp(n)) {
            var r = n;
            break e;
          }
          n = n.return;
        }
        throw Error(T(160));
      }
      switch (r.tag) {
        case 5:
          var o = r.stateNode;
          r.flags & 32 && (Cr(o, ""), (r.flags &= -33));
          var i = pc(e);
          xs(e, i, o);
          break;
        case 3:
        case 4:
          var l = r.stateNode.containerInfo,
            s = pc(e);
          ws(e, s, l);
          break;
        default:
          throw Error(T(161));
      }
    } catch (u) {
      Y(e, e.return, u);
    }
    e.flags &= -3;
  }
  t & 4096 && (e.flags &= -4097);
}
function Ym(e, t, n) {
  (D = e), kp(e);
}
function kp(e, t, n) {
  for (var r = (e.mode & 1) !== 0; D !== null; ) {
    var o = D,
      i = o.child;
    if (o.tag === 22 && r) {
      var l = o.memoizedState !== null || mo;
      if (!l) {
        var s = o.alternate,
          u = (s !== null && s.memoizedState !== null) || fe;
        s = mo;
        var a = fe;
        if (((mo = l), (fe = u) && !a))
          for (D = o; D !== null; )
            (l = D),
              (u = l.child),
              l.tag === 22 && l.memoizedState !== null
                ? vc(o)
                : u !== null
                ? ((u.return = l), (D = u))
                : vc(o);
        for (; i !== null; ) (D = i), kp(i), (i = i.sibling);
        (D = o), (mo = s), (fe = a);
      }
      gc(e);
    } else
      (o.subtreeFlags & 8772) !== 0 && i !== null
        ? ((i.return = o), (D = i))
        : gc(e);
  }
}
function gc(e) {
  for (; D !== null; ) {
    var t = D;
    if ((t.flags & 8772) !== 0) {
      var n = t.alternate;
      try {
        if ((t.flags & 8772) !== 0)
          switch (t.tag) {
            case 0:
            case 11:
            case 15:
              fe || ki(5, t);
              break;
            case 1:
              var r = t.stateNode;
              if (t.flags & 4 && !fe)
                if (n === null) r.componentDidMount();
                else {
                  var o =
                    t.elementType === t.type
                      ? n.memoizedProps
                      : Ue(t.type, n.memoizedProps);
                  r.componentDidUpdate(
                    o,
                    n.memoizedState,
                    r.__reactInternalSnapshotBeforeUpdate
                  );
                }
              var i = t.updateQueue;
              i !== null && qa(t, i, r);
              break;
            case 3:
              var l = t.updateQueue;
              if (l !== null) {
                if (((n = null), t.child !== null))
                  switch (t.child.tag) {
                    case 5:
                      n = t.child.stateNode;
                      break;
                    case 1:
                      n = t.child.stateNode;
                  }
                qa(t, l, n);
              }
              break;
            case 5:
              var s = t.stateNode;
              if (n === null && t.flags & 4) {
                n = s;
                var u = t.memoizedProps;
                switch (t.type) {
                  case "button":
                  case "input":
                  case "select":
                  case "textarea":
                    u.autoFocus && n.focus();
                    break;
                  case "img":
                    u.src && (n.src = u.src);
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
                  var c = a.memoizedState;
                  if (c !== null) {
                    var f = c.dehydrated;
                    f !== null && Pr(f);
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
              throw Error(T(163));
          }
        fe || (t.flags & 512 && Ss(t));
      } catch (p) {
        Y(t, t.return, p);
      }
    }
    if (t === e) {
      D = null;
      break;
    }
    if (((n = t.sibling), n !== null)) {
      (n.return = t.return), (D = n);
      break;
    }
    D = t.return;
  }
}
function mc(e) {
  for (; D !== null; ) {
    var t = D;
    if (t === e) {
      D = null;
      break;
    }
    var n = t.sibling;
    if (n !== null) {
      (n.return = t.return), (D = n);
      break;
    }
    D = t.return;
  }
}
function vc(e) {
  for (; D !== null; ) {
    var t = D;
    try {
      switch (t.tag) {
        case 0:
        case 11:
        case 15:
          var n = t.return;
          try {
            ki(4, t);
          } catch (u) {
            Y(t, n, u);
          }
          break;
        case 1:
          var r = t.stateNode;
          if (typeof r.componentDidMount == "function") {
            var o = t.return;
            try {
              r.componentDidMount();
            } catch (u) {
              Y(t, o, u);
            }
          }
          var i = t.return;
          try {
            Ss(t);
          } catch (u) {
            Y(t, i, u);
          }
          break;
        case 5:
          var l = t.return;
          try {
            Ss(t);
          } catch (u) {
            Y(t, l, u);
          }
      }
    } catch (u) {
      Y(t, t.return, u);
    }
    if (t === e) {
      D = null;
      break;
    }
    var s = t.sibling;
    if (s !== null) {
      (s.return = t.return), (D = s);
      break;
    }
    D = t.return;
  }
}
var Xm = Math.ceil,
  ai = dt.ReactCurrentDispatcher,
  Fu = dt.ReactCurrentOwner,
  ze = dt.ReactCurrentBatchConfig,
  F = 0,
  oe = null,
  J = null,
  se = 0,
  Oe = 0,
  Pn = _t(0),
  te = 0,
  zr = null,
  Jt = 0,
  Oi = 0,
  zu = 0,
  vr = null,
  we = null,
  ju = 0,
  Un = 1 / 0,
  tt = null,
  ci = !1,
  Es = null,
  Ot = null,
  vo = !1,
  yt = null,
  di = 0,
  yr = 0,
  Cs = null,
  Mo = -1,
  Lo = 0;
function ve() {
  return (F & 6) !== 0 ? Z() : Mo !== -1 ? Mo : (Mo = Z());
}
function Tt(e) {
  return (e.mode & 1) === 0
    ? 1
    : (F & 2) !== 0 && se !== 0
    ? se & -se
    : Nm.transition !== null
    ? (Lo === 0 && (Lo = sf()), Lo)
    : ((e = A),
      e !== 0 || ((e = window.event), (e = e === void 0 ? 16 : hf(e.type))),
      e);
}
function Qe(e, t, n, r) {
  if (50 < yr) throw ((yr = 0), (Cs = null), Error(T(185)));
  Hr(e, n, r),
    ((F & 2) === 0 || e !== oe) &&
      (e === oe && ((F & 2) === 0 && (Oi |= n), te === 4 && mt(e, se)),
      ke(e, r),
      n === 1 &&
        F === 0 &&
        (t.mode & 1) === 0 &&
        ((Un = Z() + 500), xi && Nt()));
}
function ke(e, t) {
  var n = e.callbackNode;
  Ng(e, t);
  var r = Ko(e, e === oe ? se : 0);
  if (r === 0)
    n !== null && Ta(n), (e.callbackNode = null), (e.callbackPriority = 0);
  else if (((t = r & -r), e.callbackPriority !== t)) {
    if ((n != null && Ta(n), t === 1))
      e.tag === 0 ? _m(yc.bind(null, e)) : Nf(yc.bind(null, e)),
        Im(function () {
          (F & 6) === 0 && Nt();
        }),
        (n = null);
    else {
      switch (uf(r)) {
        case 1:
          n = du;
          break;
        case 4:
          n = of;
          break;
        case 16:
          n = Go;
          break;
        case 536870912:
          n = lf;
          break;
        default:
          n = Go;
      }
      n = _p(n, Op.bind(null, e));
    }
    (e.callbackPriority = t), (e.callbackNode = n);
  }
}
function Op(e, t) {
  if (((Mo = -1), (Lo = 0), (F & 6) !== 0)) throw Error(T(327));
  var n = e.callbackNode;
  if (bn() && e.callbackNode !== n) return null;
  var r = Ko(e, e === oe ? se : 0);
  if (r === 0) return null;
  if ((r & 30) !== 0 || (r & e.expiredLanes) !== 0 || t) t = fi(e, r);
  else {
    t = r;
    var o = F;
    F |= 2;
    var i = Pp();
    (oe !== e || se !== t) && ((tt = null), (Un = Z() + 500), Vt(e, t));
    do
      try {
        Jm();
        break;
      } catch (s) {
        Tp(e, s);
      }
    while (1);
    ku(),
      (ai.current = i),
      (F = o),
      J !== null ? (t = 0) : ((oe = null), (se = 0), (t = te));
  }
  if (t !== 0) {
    if (
      (t === 2 && ((o = Xl(e)), o !== 0 && ((r = o), (t = ks(e, o)))), t === 1)
    )
      throw ((n = zr), Vt(e, 0), mt(e, r), ke(e, Z()), n);
    if (t === 6) mt(e, r);
    else {
      if (
        ((o = e.current.alternate),
        (r & 30) === 0 &&
          !Zm(o) &&
          ((t = fi(e, r)),
          t === 2 && ((i = Xl(e)), i !== 0 && ((r = i), (t = ks(e, i)))),
          t === 1))
      )
        throw ((n = zr), Vt(e, 0), mt(e, r), ke(e, Z()), n);
      switch (((e.finishedWork = o), (e.finishedLanes = r), t)) {
        case 0:
        case 1:
          throw Error(T(345));
        case 2:
          jt(e, we, tt);
          break;
        case 3:
          if (
            (mt(e, r), (r & 130023424) === r && ((t = ju + 500 - Z()), 10 < t))
          ) {
            if (Ko(e, 0) !== 0) break;
            if (((o = e.suspendedLanes), (o & r) !== r)) {
              ve(), (e.pingedLanes |= e.suspendedLanes & o);
              break;
            }
            e.timeoutHandle = os(jt.bind(null, e, we, tt), t);
            break;
          }
          jt(e, we, tt);
          break;
        case 4:
          if ((mt(e, r), (r & 4194240) === r)) break;
          for (t = e.eventTimes, o = -1; 0 < r; ) {
            var l = 31 - Ve(r);
            (i = 1 << l), (l = t[l]), l > o && (o = l), (r &= ~i);
          }
          if (
            ((r = o),
            (r = Z() - r),
            (r =
              (120 > r
                ? 120
                : 480 > r
                ? 480
                : 1080 > r
                ? 1080
                : 1920 > r
                ? 1920
                : 3e3 > r
                ? 3e3
                : 4320 > r
                ? 4320
                : 1960 * Xm(r / 1960)) - r),
            10 < r)
          ) {
            e.timeoutHandle = os(jt.bind(null, e, we, tt), r);
            break;
          }
          jt(e, we, tt);
          break;
        case 5:
          jt(e, we, tt);
          break;
        default:
          throw Error(T(329));
      }
    }
  }
  return ke(e, Z()), e.callbackNode === n ? Op.bind(null, e) : null;
}
function ks(e, t) {
  var n = vr;
  return (
    e.current.memoizedState.isDehydrated && (Vt(e, t).flags |= 256),
    (e = fi(e, t)),
    e !== 2 && ((t = we), (we = n), t !== null && Os(t)),
    e
  );
}
function Os(e) {
  we === null ? (we = e) : we.push.apply(we, e);
}
function Zm(e) {
  for (var t = e; ; ) {
    if (t.flags & 16384) {
      var n = t.updateQueue;
      if (n !== null && ((n = n.stores), n !== null))
        for (var r = 0; r < n.length; r++) {
          var o = n[r],
            i = o.getSnapshot;
          o = o.value;
          try {
            if (!Ge(i(), o)) return !1;
          } catch {
            return !1;
          }
        }
    }
    if (((n = t.child), t.subtreeFlags & 16384 && n !== null))
      (n.return = t), (t = n);
    else {
      if (t === e) break;
      for (; t.sibling === null; ) {
        if (t.return === null || t.return === e) return !0;
        t = t.return;
      }
      (t.sibling.return = t.return), (t = t.sibling);
    }
  }
  return !0;
}
function mt(e, t) {
  for (
    t &= ~zu,
      t &= ~Oi,
      e.suspendedLanes |= t,
      e.pingedLanes &= ~t,
      e = e.expirationTimes;
    0 < t;

  ) {
    var n = 31 - Ve(t),
      r = 1 << n;
    (e[n] = -1), (t &= ~r);
  }
}
function yc(e) {
  if ((F & 6) !== 0) throw Error(T(327));
  bn();
  var t = Ko(e, 0);
  if ((t & 1) === 0) return ke(e, Z()), null;
  var n = fi(e, t);
  if (e.tag !== 0 && n === 2) {
    var r = Xl(e);
    r !== 0 && ((t = r), (n = ks(e, r)));
  }
  if (n === 1) throw ((n = zr), Vt(e, 0), mt(e, t), ke(e, Z()), n);
  if (n === 6) throw Error(T(345));
  return (
    (e.finishedWork = e.current.alternate),
    (e.finishedLanes = t),
    jt(e, we, tt),
    ke(e, Z()),
    null
  );
}
function Au(e, t) {
  var n = F;
  F |= 1;
  try {
    return e(t);
  } finally {
    (F = n), F === 0 && ((Un = Z() + 500), xi && Nt());
  }
}
function en(e) {
  yt !== null && yt.tag === 0 && (F & 6) === 0 && bn();
  var t = F;
  F |= 1;
  var n = ze.transition,
    r = A;
  try {
    if (((ze.transition = null), (A = 1), e)) return e();
  } finally {
    (A = r), (ze.transition = n), (F = t), (F & 6) === 0 && Nt();
  }
}
function Bu() {
  (Oe = Pn.current), H(Pn);
}
function Vt(e, t) {
  (e.finishedWork = null), (e.finishedLanes = 0);
  var n = e.timeoutHandle;
  if ((n !== -1 && ((e.timeoutHandle = -1), Pm(n)), J !== null))
    for (n = J.return; n !== null; ) {
      var r = n;
      switch ((xu(r), r.tag)) {
        case 1:
          (r = r.type.childContextTypes), r != null && Jo();
          break;
        case 3:
          An(), H(Ee), H(pe), $u();
          break;
        case 5:
          Du(r);
          break;
        case 4:
          An();
          break;
        case 13:
          H(Q);
          break;
        case 19:
          H(Q);
          break;
        case 10:
          Ou(r.type._context);
          break;
        case 22:
        case 23:
          Bu();
      }
      n = n.return;
    }
  if (
    ((oe = e),
    (J = e = Pt(e.current, null)),
    (se = Oe = t),
    (te = 0),
    (zr = null),
    (zu = Oi = Jt = 0),
    (we = vr = null),
    Wt !== null)
  ) {
    for (t = 0; t < Wt.length; t++)
      if (((n = Wt[t]), (r = n.interleaved), r !== null)) {
        n.interleaved = null;
        var o = r.next,
          i = n.pending;
        if (i !== null) {
          var l = i.next;
          (i.next = o), (r.next = l);
        }
        n.pending = r;
      }
    Wt = null;
  }
  return e;
}
function Tp(e, t) {
  do {
    var n = J;
    try {
      if ((ku(), (_o.current = ui), si)) {
        for (var r = G.memoizedState; r !== null; ) {
          var o = r.queue;
          o !== null && (o.pending = null), (r = r.next);
        }
        si = !1;
      }
      if (
        ((qt = 0),
        (re = ee = G = null),
        (gr = !1),
        (Mr = 0),
        (Fu.current = null),
        n === null || n.return === null)
      ) {
        (te = 1), (zr = t), (J = null);
        break;
      }
      e: {
        var i = e,
          l = n.return,
          s = n,
          u = t;
        if (
          ((t = se),
          (s.flags |= 32768),
          u !== null && typeof u == "object" && typeof u.then == "function")
        ) {
          var a = u,
            c = s,
            f = c.tag;
          if ((c.mode & 1) === 0 && (f === 0 || f === 11 || f === 15)) {
            var p = c.alternate;
            p
              ? ((c.updateQueue = p.updateQueue),
                (c.memoizedState = p.memoizedState),
                (c.lanes = p.lanes))
              : ((c.updateQueue = null), (c.memoizedState = null));
          }
          var y = ic(l);
          if (y !== null) {
            (y.flags &= -257),
              lc(y, l, s, i, t),
              y.mode & 1 && oc(i, a, t),
              (t = y),
              (u = a);
            var S = t.updateQueue;
            if (S === null) {
              var m = new Set();
              m.add(u), (t.updateQueue = m);
            } else S.add(u);
            break e;
          } else {
            if ((t & 1) === 0) {
              oc(i, a, t), Uu();
              break e;
            }
            u = Error(T(426));
          }
        } else if (V && s.mode & 1) {
          var C = ic(l);
          if (C !== null) {
            (C.flags & 65536) === 0 && (C.flags |= 256),
              lc(C, l, s, i, t),
              Eu(Bn(u, s));
            break e;
          }
        }
        (i = u = Bn(u, s)),
          te !== 4 && (te = 2),
          vr === null ? (vr = [i]) : vr.push(i),
          (i = l);
        do {
          switch (i.tag) {
            case 3:
              (i.flags |= 65536), (t &= -t), (i.lanes |= t);
              var h = ap(i, u, t);
              Za(i, h);
              break e;
            case 1:
              s = u;
              var d = i.type,
                v = i.stateNode;
              if (
                (i.flags & 128) === 0 &&
                (typeof d.getDerivedStateFromError == "function" ||
                  (v !== null &&
                    typeof v.componentDidCatch == "function" &&
                    (Ot === null || !Ot.has(v))))
              ) {
                (i.flags |= 65536), (t &= -t), (i.lanes |= t);
                var w = cp(i, s, t);
                Za(i, w);
                break e;
              }
          }
          i = i.return;
        } while (i !== null);
      }
      Dp(n);
    } catch (E) {
      (t = E), J === n && n !== null && (J = n = n.return);
      continue;
    }
    break;
  } while (1);
}
function Pp() {
  var e = ai.current;
  return (ai.current = ui), e === null ? ui : e;
}
function Uu() {
  (te === 0 || te === 3 || te === 2) && (te = 4),
    oe === null ||
      ((Jt & 268435455) === 0 && (Oi & 268435455) === 0) ||
      mt(oe, se);
}
function fi(e, t) {
  var n = F;
  F |= 2;
  var r = Pp();
  (oe !== e || se !== t) && ((tt = null), Vt(e, t));
  do
    try {
      qm();
      break;
    } catch (o) {
      Tp(e, o);
    }
  while (1);
  if ((ku(), (F = n), (ai.current = r), J !== null)) throw Error(T(261));
  return (oe = null), (se = 0), te;
}
function qm() {
  for (; J !== null; ) Ip(J);
}
function Jm() {
  for (; J !== null && !kg(); ) Ip(J);
}
function Ip(e) {
  var t = Rp(e.alternate, e, Oe);
  (e.memoizedProps = e.pendingProps),
    t === null ? Dp(e) : (J = t),
    (Fu.current = null);
}
function Dp(e) {
  var t = e;
  do {
    var n = t.alternate;
    if (((e = t.return), (t.flags & 32768) === 0)) {
      if (((n = Vm(n, t, Oe)), n !== null)) {
        J = n;
        return;
      }
    } else {
      if (((n = Qm(n, t)), n !== null)) {
        (n.flags &= 32767), (J = n);
        return;
      }
      if (e !== null)
        (e.flags |= 32768), (e.subtreeFlags = 0), (e.deletions = null);
      else {
        (te = 6), (J = null);
        return;
      }
    }
    if (((t = t.sibling), t !== null)) {
      J = t;
      return;
    }
    J = t = e;
  } while (t !== null);
  te === 0 && (te = 5);
}
function jt(e, t, n) {
  var r = A,
    o = ze.transition;
  try {
    (ze.transition = null), (A = 1), ev(e, t, n, r);
  } finally {
    (ze.transition = o), (A = r);
  }
  return null;
}
function ev(e, t, n, r) {
  do bn();
  while (yt !== null);
  if ((F & 6) !== 0) throw Error(T(327));
  n = e.finishedWork;
  var o = e.finishedLanes;
  if (n === null) return null;
  if (((e.finishedWork = null), (e.finishedLanes = 0), n === e.current))
    throw Error(T(177));
  (e.callbackNode = null), (e.callbackPriority = 0);
  var i = n.lanes | n.childLanes;
  if (
    (bg(e, i),
    e === oe && ((J = oe = null), (se = 0)),
    ((n.subtreeFlags & 2064) === 0 && (n.flags & 2064) === 0) ||
      vo ||
      ((vo = !0),
      _p(Go, function () {
        return bn(), null;
      })),
    (i = (n.flags & 15990) !== 0),
    (n.subtreeFlags & 15990) !== 0 || i)
  ) {
    (i = ze.transition), (ze.transition = null);
    var l = A;
    A = 1;
    var s = F;
    (F |= 4),
      (Fu.current = null),
      Km(e, n),
      Cp(n, e),
      wm(ns),
      (Yo = !!ts),
      (ns = ts = null),
      (e.current = n),
      Ym(n),
      Og(),
      (F = s),
      (A = l),
      (ze.transition = i);
  } else e.current = n;
  if (
    (vo && ((vo = !1), (yt = e), (di = o)),
    (i = e.pendingLanes),
    i === 0 && (Ot = null),
    Ig(n.stateNode),
    ke(e, Z()),
    t !== null)
  )
    for (r = e.onRecoverableError, n = 0; n < t.length; n++)
      (o = t[n]), r(o.value, { componentStack: o.stack, digest: o.digest });
  if (ci) throw ((ci = !1), (e = Es), (Es = null), e);
  return (
    (di & 1) !== 0 && e.tag !== 0 && bn(),
    (i = e.pendingLanes),
    (i & 1) !== 0 ? (e === Cs ? yr++ : ((yr = 0), (Cs = e))) : (yr = 0),
    Nt(),
    null
  );
}
function bn() {
  if (yt !== null) {
    var e = uf(di),
      t = ze.transition,
      n = A;
    try {
      if (((ze.transition = null), (A = 16 > e ? 16 : e), yt === null))
        var r = !1;
      else {
        if (((e = yt), (yt = null), (di = 0), (F & 6) !== 0))
          throw Error(T(331));
        var o = F;
        for (F |= 4, D = e.current; D !== null; ) {
          var i = D,
            l = i.child;
          if ((D.flags & 16) !== 0) {
            var s = i.deletions;
            if (s !== null) {
              for (var u = 0; u < s.length; u++) {
                var a = s[u];
                for (D = a; D !== null; ) {
                  var c = D;
                  switch (c.tag) {
                    case 0:
                    case 11:
                    case 15:
                      mr(8, c, i);
                  }
                  var f = c.child;
                  if (f !== null) (f.return = c), (D = f);
                  else
                    for (; D !== null; ) {
                      c = D;
                      var p = c.sibling,
                        y = c.return;
                      if ((wp(c), c === a)) {
                        D = null;
                        break;
                      }
                      if (p !== null) {
                        (p.return = y), (D = p);
                        break;
                      }
                      D = y;
                    }
                }
              }
              var S = i.alternate;
              if (S !== null) {
                var m = S.child;
                if (m !== null) {
                  S.child = null;
                  do {
                    var C = m.sibling;
                    (m.sibling = null), (m = C);
                  } while (m !== null);
                }
              }
              D = i;
            }
          }
          if ((i.subtreeFlags & 2064) !== 0 && l !== null)
            (l.return = i), (D = l);
          else
            e: for (; D !== null; ) {
              if (((i = D), (i.flags & 2048) !== 0))
                switch (i.tag) {
                  case 0:
                  case 11:
                  case 15:
                    mr(9, i, i.return);
                }
              var h = i.sibling;
              if (h !== null) {
                (h.return = i.return), (D = h);
                break e;
              }
              D = i.return;
            }
        }
        var d = e.current;
        for (D = d; D !== null; ) {
          l = D;
          var v = l.child;
          if ((l.subtreeFlags & 2064) !== 0 && v !== null)
            (v.return = l), (D = v);
          else
            e: for (l = d; D !== null; ) {
              if (((s = D), (s.flags & 2048) !== 0))
                try {
                  switch (s.tag) {
                    case 0:
                    case 11:
                    case 15:
                      ki(9, s);
                  }
                } catch (E) {
                  Y(s, s.return, E);
                }
              if (s === l) {
                D = null;
                break e;
              }
              var w = s.sibling;
              if (w !== null) {
                (w.return = s.return), (D = w);
                break e;
              }
              D = s.return;
            }
        }
        if (
          ((F = o), Nt(), qe && typeof qe.onPostCommitFiberRoot == "function")
        )
          try {
            qe.onPostCommitFiberRoot(mi, e);
          } catch {}
        r = !0;
      }
      return r;
    } finally {
      (A = n), (ze.transition = t);
    }
  }
  return !1;
}
function Sc(e, t, n) {
  (t = Bn(n, t)),
    (t = ap(e, t, 1)),
    (e = kt(e, t, 1)),
    (t = ve()),
    e !== null && (Hr(e, 1, t), ke(e, t));
}
function Y(e, t, n) {
  if (e.tag === 3) Sc(e, e, n);
  else
    for (; t !== null; ) {
      if (t.tag === 3) {
        Sc(t, e, n);
        break;
      } else if (t.tag === 1) {
        var r = t.stateNode;
        if (
          typeof t.type.getDerivedStateFromError == "function" ||
          (typeof r.componentDidCatch == "function" &&
            (Ot === null || !Ot.has(r)))
        ) {
          (e = Bn(n, e)),
            (e = cp(t, e, 1)),
            (t = kt(t, e, 1)),
            (e = ve()),
            t !== null && (Hr(t, 1, e), ke(t, e));
          break;
        }
      }
      t = t.return;
    }
}
function tv(e, t, n) {
  var r = e.pingCache;
  r !== null && r.delete(t),
    (t = ve()),
    (e.pingedLanes |= e.suspendedLanes & n),
    oe === e &&
      (se & n) === n &&
      (te === 4 || (te === 3 && (se & 130023424) === se && 500 > Z() - ju)
        ? Vt(e, 0)
        : (zu |= n)),
    ke(e, t);
}
function $p(e, t) {
  t === 0 &&
    ((e.mode & 1) === 0
      ? (t = 1)
      : ((t = lo), (lo <<= 1), (lo & 130023424) === 0 && (lo = 4194304)));
  var n = ve();
  (e = ut(e, t)), e !== null && (Hr(e, t, n), ke(e, n));
}
function nv(e) {
  var t = e.memoizedState,
    n = 0;
  t !== null && (n = t.retryLane), $p(e, n);
}
function rv(e, t) {
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
      throw Error(T(314));
  }
  r !== null && r.delete(t), $p(e, n);
}
var Rp;
Rp = function (e, t, n) {
  if (e !== null)
    if (e.memoizedProps !== t.pendingProps || Ee.current) xe = !0;
    else {
      if ((e.lanes & n) === 0 && (t.flags & 128) === 0)
        return (xe = !1), Hm(e, t, n);
      xe = (e.flags & 131072) !== 0;
    }
  else (xe = !1), V && (t.flags & 1048576) !== 0 && bf(t, ni, t.index);
  switch (((t.lanes = 0), t.tag)) {
    case 2:
      var r = t.type;
      bo(e, t), (e = t.pendingProps);
      var o = Fn(t, pe.current);
      Nn(t, n), (o = _u(null, t, r, e, o, n));
      var i = Nu();
      return (
        (t.flags |= 1),
        typeof o == "object" &&
        o !== null &&
        typeof o.render == "function" &&
        o.$$typeof === void 0
          ? ((t.tag = 1),
            (t.memoizedState = null),
            (t.updateQueue = null),
            Ce(r) ? ((i = !0), ei(t)) : (i = !1),
            (t.memoizedState =
              o.state !== null && o.state !== void 0 ? o.state : null),
            Pu(t),
            (o.updater = Ei),
            (t.stateNode = o),
            (o._reactInternals = t),
            ds(t, r, e, n),
            (t = hs(null, t, r, !0, i, n)))
          : ((t.tag = 0), V && i && wu(t), ge(null, t, o, n), (t = t.child)),
        t
      );
    case 16:
      r = t.elementType;
      e: {
        switch (
          (bo(e, t),
          (e = t.pendingProps),
          (o = r._init),
          (r = o(r._payload)),
          (t.type = r),
          (o = t.tag = iv(r)),
          (e = Ue(r, e)),
          o)
        ) {
          case 0:
            t = ps(null, t, r, e, n);
            break e;
          case 1:
            t = ac(null, t, r, e, n);
            break e;
          case 11:
            t = sc(null, t, r, e, n);
            break e;
          case 14:
            t = uc(null, t, r, Ue(r.type, e), n);
            break e;
        }
        throw Error(T(306, r, ""));
      }
      return t;
    case 0:
      return (
        (r = t.type),
        (o = t.pendingProps),
        (o = t.elementType === r ? o : Ue(r, o)),
        ps(e, t, r, o, n)
      );
    case 1:
      return (
        (r = t.type),
        (o = t.pendingProps),
        (o = t.elementType === r ? o : Ue(r, o)),
        ac(e, t, r, o, n)
      );
    case 3:
      e: {
        if ((hp(t), e === null)) throw Error(T(387));
        (r = t.pendingProps),
          (i = t.memoizedState),
          (o = i.element),
          zf(e, t),
          ii(t, r, null, n);
        var l = t.memoizedState;
        if (((r = l.element), i.isDehydrated))
          if (
            ((i = {
              element: r,
              isDehydrated: !1,
              cache: l.cache,
              pendingSuspenseBoundaries: l.pendingSuspenseBoundaries,
              transitions: l.transitions,
            }),
            (t.updateQueue.baseState = i),
            (t.memoizedState = i),
            t.flags & 256)
          ) {
            (o = Bn(Error(T(423)), t)), (t = cc(e, t, r, n, o));
            break e;
          } else if (r !== o) {
            (o = Bn(Error(T(424)), t)), (t = cc(e, t, r, n, o));
            break e;
          } else
            for (
              Te = Ct(t.stateNode.containerInfo.firstChild),
                Pe = t,
                V = !0,
                He = null,
                n = Uf(t, null, r, n),
                t.child = n;
              n;

            )
              (n.flags = (n.flags & -3) | 4096), (n = n.sibling);
        else {
          if ((zn(), r === o)) {
            t = at(e, t, n);
            break e;
          }
          ge(e, t, r, n);
        }
        t = t.child;
      }
      return t;
    case 5:
      return (
        Wf(t),
        e === null && us(t),
        (r = t.type),
        (o = t.pendingProps),
        (i = e !== null ? e.memoizedProps : null),
        (l = o.children),
        rs(r, o) ? (l = null) : i !== null && rs(r, i) && (t.flags |= 32),
        pp(e, t),
        ge(e, t, l, n),
        t.child
      );
    case 6:
      return e === null && us(t), null;
    case 13:
      return gp(e, t, n);
    case 4:
      return (
        Iu(t, t.stateNode.containerInfo),
        (r = t.pendingProps),
        e === null ? (t.child = jn(t, null, r, n)) : ge(e, t, r, n),
        t.child
      );
    case 11:
      return (
        (r = t.type),
        (o = t.pendingProps),
        (o = t.elementType === r ? o : Ue(r, o)),
        sc(e, t, r, o, n)
      );
    case 7:
      return ge(e, t, t.pendingProps, n), t.child;
    case 8:
      return ge(e, t, t.pendingProps.children, n), t.child;
    case 12:
      return ge(e, t, t.pendingProps.children, n), t.child;
    case 10:
      e: {
        if (
          ((r = t.type._context),
          (o = t.pendingProps),
          (i = t.memoizedProps),
          (l = o.value),
          U(ri, r._currentValue),
          (r._currentValue = l),
          i !== null)
        )
          if (Ge(i.value, l)) {
            if (i.children === o.children && !Ee.current) {
              t = at(e, t, n);
              break e;
            }
          } else
            for (i = t.child, i !== null && (i.return = t); i !== null; ) {
              var s = i.dependencies;
              if (s !== null) {
                l = i.child;
                for (var u = s.firstContext; u !== null; ) {
                  if (u.context === r) {
                    if (i.tag === 1) {
                      (u = it(-1, n & -n)), (u.tag = 2);
                      var a = i.updateQueue;
                      if (a !== null) {
                        a = a.shared;
                        var c = a.pending;
                        c === null
                          ? (u.next = u)
                          : ((u.next = c.next), (c.next = u)),
                          (a.pending = u);
                      }
                    }
                    (i.lanes |= n),
                      (u = i.alternate),
                      u !== null && (u.lanes |= n),
                      as(i.return, n, t),
                      (s.lanes |= n);
                    break;
                  }
                  u = u.next;
                }
              } else if (i.tag === 10) l = i.type === t.type ? null : i.child;
              else if (i.tag === 18) {
                if (((l = i.return), l === null)) throw Error(T(341));
                (l.lanes |= n),
                  (s = l.alternate),
                  s !== null && (s.lanes |= n),
                  as(l, n, t),
                  (l = i.sibling);
              } else l = i.child;
              if (l !== null) l.return = i;
              else
                for (l = i; l !== null; ) {
                  if (l === t) {
                    l = null;
                    break;
                  }
                  if (((i = l.sibling), i !== null)) {
                    (i.return = l.return), (l = i);
                    break;
                  }
                  l = l.return;
                }
              i = l;
            }
        ge(e, t, o.children, n), (t = t.child);
      }
      return t;
    case 9:
      return (
        (o = t.type),
        (r = t.pendingProps.children),
        Nn(t, n),
        (o = je(o)),
        (r = r(o)),
        (t.flags |= 1),
        ge(e, t, r, n),
        t.child
      );
    case 14:
      return (
        (r = t.type),
        (o = Ue(r, t.pendingProps)),
        (o = Ue(r.type, o)),
        uc(e, t, r, o, n)
      );
    case 15:
      return dp(e, t, t.type, t.pendingProps, n);
    case 17:
      return (
        (r = t.type),
        (o = t.pendingProps),
        (o = t.elementType === r ? o : Ue(r, o)),
        bo(e, t),
        (t.tag = 1),
        Ce(r) ? ((e = !0), ei(t)) : (e = !1),
        Nn(t, n),
        Af(t, r, o),
        ds(t, r, o, n),
        hs(null, t, r, !0, e, n)
      );
    case 19:
      return mp(e, t, n);
    case 22:
      return fp(e, t, n);
  }
  throw Error(T(156, t.tag));
};
function _p(e, t) {
  return rf(e, t);
}
function ov(e, t, n, r) {
  (this.tag = e),
    (this.key = n),
    (this.sibling =
      this.child =
      this.return =
      this.stateNode =
      this.type =
      this.elementType =
        null),
    (this.index = 0),
    (this.ref = null),
    (this.pendingProps = t),
    (this.dependencies =
      this.memoizedState =
      this.updateQueue =
      this.memoizedProps =
        null),
    (this.mode = r),
    (this.subtreeFlags = this.flags = 0),
    (this.deletions = null),
    (this.childLanes = this.lanes = 0),
    (this.alternate = null);
}
function Fe(e, t, n, r) {
  return new ov(e, t, n, r);
}
function Wu(e) {
  return (e = e.prototype), !(!e || !e.isReactComponent);
}
function iv(e) {
  if (typeof e == "function") return Wu(e) ? 1 : 0;
  if (e != null) {
    if (((e = e.$$typeof), e === uu)) return 11;
    if (e === au) return 14;
  }
  return 2;
}
function Pt(e, t) {
  var n = e.alternate;
  return (
    n === null
      ? ((n = Fe(e.tag, t, e.key, e.mode)),
        (n.elementType = e.elementType),
        (n.type = e.type),
        (n.stateNode = e.stateNode),
        (n.alternate = e),
        (e.alternate = n))
      : ((n.pendingProps = t),
        (n.type = e.type),
        (n.flags = 0),
        (n.subtreeFlags = 0),
        (n.deletions = null)),
    (n.flags = e.flags & 14680064),
    (n.childLanes = e.childLanes),
    (n.lanes = e.lanes),
    (n.child = e.child),
    (n.memoizedProps = e.memoizedProps),
    (n.memoizedState = e.memoizedState),
    (n.updateQueue = e.updateQueue),
    (t = e.dependencies),
    (n.dependencies =
      t === null ? null : { lanes: t.lanes, firstContext: t.firstContext }),
    (n.sibling = e.sibling),
    (n.index = e.index),
    (n.ref = e.ref),
    n
  );
}
function Fo(e, t, n, r, o, i) {
  var l = 2;
  if (((r = e), typeof e == "function")) Wu(e) && (l = 1);
  else if (typeof e == "string") l = 5;
  else
    e: switch (e) {
      case vn:
        return Qt(n.children, o, i, t);
      case su:
        (l = 8), (o |= 8);
        break;
      case Ml:
        return (
          (e = Fe(12, n, t, o | 2)), (e.elementType = Ml), (e.lanes = i), e
        );
      case Ll:
        return (e = Fe(13, n, t, o)), (e.elementType = Ll), (e.lanes = i), e;
      case Fl:
        return (e = Fe(19, n, t, o)), (e.elementType = Fl), (e.lanes = i), e;
      case Ad:
        return Ti(n, o, i, t);
      default:
        if (typeof e == "object" && e !== null)
          switch (e.$$typeof) {
            case zd:
              l = 10;
              break e;
            case jd:
              l = 9;
              break e;
            case uu:
              l = 11;
              break e;
            case au:
              l = 14;
              break e;
            case pt:
              (l = 16), (r = null);
              break e;
          }
        throw Error(T(130, e == null ? e : typeof e, ""));
    }
  return (
    (t = Fe(l, n, t, o)), (t.elementType = e), (t.type = r), (t.lanes = i), t
  );
}
function Qt(e, t, n, r) {
  return (e = Fe(7, e, r, t)), (e.lanes = n), e;
}
function Ti(e, t, n, r) {
  return (
    (e = Fe(22, e, r, t)),
    (e.elementType = Ad),
    (e.lanes = n),
    (e.stateNode = { isHidden: !1 }),
    e
  );
}
function hl(e, t, n) {
  return (e = Fe(6, e, null, t)), (e.lanes = n), e;
}
function gl(e, t, n) {
  return (
    (t = Fe(4, e.children !== null ? e.children : [], e.key, t)),
    (t.lanes = n),
    (t.stateNode = {
      containerInfo: e.containerInfo,
      pendingChildren: null,
      implementation: e.implementation,
    }),
    t
  );
}
function lv(e, t, n, r, o) {
  (this.tag = t),
    (this.containerInfo = e),
    (this.finishedWork =
      this.pingCache =
      this.current =
      this.pendingChildren =
        null),
    (this.timeoutHandle = -1),
    (this.callbackNode = this.pendingContext = this.context = null),
    (this.callbackPriority = 0),
    (this.eventTimes = Yi(0)),
    (this.expirationTimes = Yi(-1)),
    (this.entangledLanes =
      this.finishedLanes =
      this.mutableReadLanes =
      this.expiredLanes =
      this.pingedLanes =
      this.suspendedLanes =
      this.pendingLanes =
        0),
    (this.entanglements = Yi(0)),
    (this.identifierPrefix = r),
    (this.onRecoverableError = o),
    (this.mutableSourceEagerHydrationData = null);
}
function Hu(e, t, n, r, o, i, l, s, u) {
  return (
    (e = new lv(e, t, n, s, u)),
    t === 1 ? ((t = 1), i === !0 && (t |= 8)) : (t = 0),
    (i = Fe(3, null, null, t)),
    (e.current = i),
    (i.stateNode = e),
    (i.memoizedState = {
      element: r,
      isDehydrated: n,
      cache: null,
      transitions: null,
      pendingSuspenseBoundaries: null,
    }),
    Pu(i),
    e
  );
}
function sv(e, t, n) {
  var r = 3 < arguments.length && arguments[3] !== void 0 ? arguments[3] : null;
  return {
    $$typeof: mn,
    key: r == null ? null : "" + r,
    children: e,
    containerInfo: t,
    implementation: n,
  };
}
function Np(e) {
  if (!e) return $t;
  e = e._reactInternals;
  e: {
    if (ln(e) !== e || e.tag !== 1) throw Error(T(170));
    var t = e;
    do {
      switch (t.tag) {
        case 3:
          t = t.stateNode.context;
          break e;
        case 1:
          if (Ce(t.type)) {
            t = t.stateNode.__reactInternalMemoizedMergedChildContext;
            break e;
          }
      }
      t = t.return;
    } while (t !== null);
    throw Error(T(171));
  }
  if (e.tag === 1) {
    var n = e.type;
    if (Ce(n)) return _f(e, n, t);
  }
  return t;
}
function bp(e, t, n, r, o, i, l, s, u) {
  return (
    (e = Hu(n, r, !0, e, o, i, l, s, u)),
    (e.context = Np(null)),
    (n = e.current),
    (r = ve()),
    (o = Tt(n)),
    (i = it(r, o)),
    (i.callback = t != null ? t : null),
    kt(n, i, o),
    (e.current.lanes = o),
    Hr(e, o, r),
    ke(e, r),
    e
  );
}
function Pi(e, t, n, r) {
  var o = t.current,
    i = ve(),
    l = Tt(o);
  return (
    (n = Np(n)),
    t.context === null ? (t.context = n) : (t.pendingContext = n),
    (t = it(i, l)),
    (t.payload = { element: e }),
    (r = r === void 0 ? null : r),
    r !== null && (t.callback = r),
    (e = kt(o, t, l)),
    e !== null && (Qe(e, o, l, i), Ro(e, o, l)),
    l
  );
}
function pi(e) {
  if (((e = e.current), !e.child)) return null;
  switch (e.child.tag) {
    case 5:
      return e.child.stateNode;
    default:
      return e.child.stateNode;
  }
}
function wc(e, t) {
  if (((e = e.memoizedState), e !== null && e.dehydrated !== null)) {
    var n = e.retryLane;
    e.retryLane = n !== 0 && n < t ? n : t;
  }
}
function Vu(e, t) {
  wc(e, t), (e = e.alternate) && wc(e, t);
}
function uv() {
  return null;
}
var Mp =
  typeof reportError == "function"
    ? reportError
    : function (e) {
        console.error(e);
      };
function Qu(e) {
  this._internalRoot = e;
}
Ii.prototype.render = Qu.prototype.render = function (e) {
  var t = this._internalRoot;
  if (t === null) throw Error(T(409));
  Pi(e, t, null, null);
};
Ii.prototype.unmount = Qu.prototype.unmount = function () {
  var e = this._internalRoot;
  if (e !== null) {
    this._internalRoot = null;
    var t = e.containerInfo;
    en(function () {
      Pi(null, e, null, null);
    }),
      (t[st] = null);
  }
};
function Ii(e) {
  this._internalRoot = e;
}
Ii.prototype.unstable_scheduleHydration = function (e) {
  if (e) {
    var t = df();
    e = { blockedOn: null, target: e, priority: t };
    for (var n = 0; n < gt.length && t !== 0 && t < gt[n].priority; n++);
    gt.splice(n, 0, e), n === 0 && pf(e);
  }
};
function Gu(e) {
  return !(!e || (e.nodeType !== 1 && e.nodeType !== 9 && e.nodeType !== 11));
}
function Di(e) {
  return !(
    !e ||
    (e.nodeType !== 1 &&
      e.nodeType !== 9 &&
      e.nodeType !== 11 &&
      (e.nodeType !== 8 || e.nodeValue !== " react-mount-point-unstable "))
  );
}
function xc() {}
function av(e, t, n, r, o) {
  if (o) {
    if (typeof r == "function") {
      var i = r;
      r = function () {
        var a = pi(l);
        i.call(a);
      };
    }
    var l = bp(t, r, e, 0, null, !1, !1, "", xc);
    return (
      (e._reactRootContainer = l),
      (e[st] = l.current),
      $r(e.nodeType === 8 ? e.parentNode : e),
      en(),
      l
    );
  }
  for (; (o = e.lastChild); ) e.removeChild(o);
  if (typeof r == "function") {
    var s = r;
    r = function () {
      var a = pi(u);
      s.call(a);
    };
  }
  var u = Hu(e, 0, !1, null, null, !1, !1, "", xc);
  return (
    (e._reactRootContainer = u),
    (e[st] = u.current),
    $r(e.nodeType === 8 ? e.parentNode : e),
    en(function () {
      Pi(t, u, n, r);
    }),
    u
  );
}
function $i(e, t, n, r, o) {
  var i = n._reactRootContainer;
  if (i) {
    var l = i;
    if (typeof o == "function") {
      var s = o;
      o = function () {
        var u = pi(l);
        s.call(u);
      };
    }
    Pi(t, l, e, o);
  } else l = av(n, t, e, o, r);
  return pi(l);
}
af = function (e) {
  switch (e.tag) {
    case 3:
      var t = e.stateNode;
      if (t.current.memoizedState.isDehydrated) {
        var n = sr(t.pendingLanes);
        n !== 0 &&
          (fu(t, n | 1), ke(t, Z()), (F & 6) === 0 && ((Un = Z() + 500), Nt()));
      }
      break;
    case 13:
      en(function () {
        var r = ut(e, 1);
        if (r !== null) {
          var o = ve();
          Qe(r, e, 1, o);
        }
      }),
        Vu(e, 1);
  }
};
pu = function (e) {
  if (e.tag === 13) {
    var t = ut(e, 134217728);
    if (t !== null) {
      var n = ve();
      Qe(t, e, 134217728, n);
    }
    Vu(e, 134217728);
  }
};
cf = function (e) {
  if (e.tag === 13) {
    var t = Tt(e),
      n = ut(e, t);
    if (n !== null) {
      var r = ve();
      Qe(n, e, t, r);
    }
    Vu(e, t);
  }
};
df = function () {
  return A;
};
ff = function (e, t) {
  var n = A;
  try {
    return (A = e), t();
  } finally {
    A = n;
  }
};
Gl = function (e, t, n) {
  switch (t) {
    case "input":
      if ((Al(e, n), (t = n.name), n.type === "radio" && t != null)) {
        for (n = e; n.parentNode; ) n = n.parentNode;
        for (
          n = n.querySelectorAll(
            "input[name=" + JSON.stringify("" + t) + '][type="radio"]'
          ),
            t = 0;
          t < n.length;
          t++
        ) {
          var r = n[t];
          if (r !== e && r.form === e.form) {
            var o = wi(r);
            if (!o) throw Error(T(90));
            Ud(r), Al(r, o);
          }
        }
      }
      break;
    case "textarea":
      Hd(e, n);
      break;
    case "select":
      (t = n.value), t != null && Dn(e, !!n.multiple, t, !1);
  }
};
Zd = Au;
qd = en;
var cv = { usingClientEntryPoint: !1, Events: [Qr, xn, wi, Yd, Xd, Au] },
  tr = {
    findFiberByHostInstance: Ut,
    bundleType: 0,
    version: "18.2.0",
    rendererPackageName: "react-dom",
  },
  dv = {
    bundleType: tr.bundleType,
    version: tr.version,
    rendererPackageName: tr.rendererPackageName,
    rendererConfig: tr.rendererConfig,
    overrideHookState: null,
    overrideHookStateDeletePath: null,
    overrideHookStateRenamePath: null,
    overrideProps: null,
    overridePropsDeletePath: null,
    overridePropsRenamePath: null,
    setErrorHandler: null,
    setSuspenseHandler: null,
    scheduleUpdate: null,
    currentDispatcherRef: dt.ReactCurrentDispatcher,
    findHostInstanceByFiber: function (e) {
      return (e = tf(e)), e === null ? null : e.stateNode;
    },
    findFiberByHostInstance: tr.findFiberByHostInstance || uv,
    findHostInstancesForRefresh: null,
    scheduleRefresh: null,
    scheduleRoot: null,
    setRefreshHandler: null,
    getCurrentFiber: null,
    reconcilerVersion: "18.2.0-next-9e3b772b8-20220608",
  };
if (typeof __REACT_DEVTOOLS_GLOBAL_HOOK__ != "undefined") {
  var yo = __REACT_DEVTOOLS_GLOBAL_HOOK__;
  if (!yo.isDisabled && yo.supportsFiber)
    try {
      (mi = yo.inject(dv)), (qe = yo);
    } catch {}
}
$e.__SECRET_INTERNALS_DO_NOT_USE_OR_YOU_WILL_BE_FIRED = cv;
$e.createPortal = function (e, t) {
  var n = 2 < arguments.length && arguments[2] !== void 0 ? arguments[2] : null;
  if (!Gu(t)) throw Error(T(200));
  return sv(e, t, null, n);
};
$e.createRoot = function (e, t) {
  if (!Gu(e)) throw Error(T(299));
  var n = !1,
    r = "",
    o = Mp;
  return (
    t != null &&
      (t.unstable_strictMode === !0 && (n = !0),
      t.identifierPrefix !== void 0 && (r = t.identifierPrefix),
      t.onRecoverableError !== void 0 && (o = t.onRecoverableError)),
    (t = Hu(e, 1, !1, null, null, n, !1, r, o)),
    (e[st] = t.current),
    $r(e.nodeType === 8 ? e.parentNode : e),
    new Qu(t)
  );
};
$e.findDOMNode = function (e) {
  if (e == null) return null;
  if (e.nodeType === 1) return e;
  var t = e._reactInternals;
  if (t === void 0)
    throw typeof e.render == "function"
      ? Error(T(188))
      : ((e = Object.keys(e).join(",")), Error(T(268, e)));
  return (e = tf(t)), (e = e === null ? null : e.stateNode), e;
};
$e.flushSync = function (e) {
  return en(e);
};
$e.hydrate = function (e, t, n) {
  if (!Di(t)) throw Error(T(200));
  return $i(null, e, t, !0, n);
};
$e.hydrateRoot = function (e, t, n) {
  if (!Gu(e)) throw Error(T(405));
  var r = (n != null && n.hydratedSources) || null,
    o = !1,
    i = "",
    l = Mp;
  if (
    (n != null &&
      (n.unstable_strictMode === !0 && (o = !0),
      n.identifierPrefix !== void 0 && (i = n.identifierPrefix),
      n.onRecoverableError !== void 0 && (l = n.onRecoverableError)),
    (t = bp(t, null, e, 1, n != null ? n : null, o, !1, i, l)),
    (e[st] = t.current),
    $r(e),
    r)
  )
    for (e = 0; e < r.length; e++)
      (n = r[e]),
        (o = n._getVersion),
        (o = o(n._source)),
        t.mutableSourceEagerHydrationData == null
          ? (t.mutableSourceEagerHydrationData = [n, o])
          : t.mutableSourceEagerHydrationData.push(n, o);
  return new Ii(t);
};
$e.render = function (e, t, n) {
  if (!Di(t)) throw Error(T(200));
  return $i(null, e, t, !1, n);
};
$e.unmountComponentAtNode = function (e) {
  if (!Di(e)) throw Error(T(40));
  return e._reactRootContainer
    ? (en(function () {
        $i(null, null, e, !1, function () {
          (e._reactRootContainer = null), (e[st] = null);
        });
      }),
      !0)
    : !1;
};
$e.unstable_batchedUpdates = Au;
$e.unstable_renderSubtreeIntoContainer = function (e, t, n, r) {
  if (!Di(n)) throw Error(T(200));
  if (e == null || e._reactInternals === void 0) throw Error(T(38));
  return $i(e, t, n, !1, r);
};
$e.version = "18.2.0-next-9e3b772b8-20220608";
function Lp() {
  if (
    !(
      typeof __REACT_DEVTOOLS_GLOBAL_HOOK__ == "undefined" ||
      typeof __REACT_DEVTOOLS_GLOBAL_HOOK__.checkDCE != "function"
    )
  )
    try {
      __REACT_DEVTOOLS_GLOBAL_HOOK__.checkDCE(Lp);
    } catch (e) {
      console.error(e);
    }
}
Lp(), (Ur.exports = $e);
var fv = Ur.exports,
  Ec = Ur.exports;
(Nl.createRoot = Ec.createRoot), (Nl.hydrateRoot = Ec.hydrateRoot);
/**
 * @remix-run/router v1.0.2
 *
 * Copyright (c) Remix Software Inc.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE.md file in the root directory of this source tree.
 *
 * @license MIT
 */ function Ts() {
  return (
    (Ts = Object.assign
      ? Object.assign.bind()
      : function (e) {
          for (var t = 1; t < arguments.length; t++) {
            var n = arguments[t];
            for (var r in n)
              Object.prototype.hasOwnProperty.call(n, r) && (e[r] = n[r]);
          }
          return e;
        }),
    Ts.apply(this, arguments)
  );
}
var St;
(function (e) {
  (e.Pop = "POP"), (e.Push = "PUSH"), (e.Replace = "REPLACE");
})(St || (St = {}));
const Cc = "popstate";
function pv(e) {
  e === void 0 && (e = {});
  function t(o, i) {
    let {
      pathname: l = "/",
      search: s = "",
      hash: u = "",
    } = Kr(o.location.hash.substr(1));
    return Ps(
      "",
      { pathname: l, search: s, hash: u },
      (i.state && i.state.usr) || null,
      (i.state && i.state.key) || "default"
    );
  }
  function n(o, i) {
    let l = o.document.querySelector("base"),
      s = "";
    if (l && l.getAttribute("href")) {
      let u = o.location.href,
        a = u.indexOf("#");
      s = a === -1 ? u : u.slice(0, a);
    }
    return s + "#" + (typeof i == "string" ? i : mv(i));
  }
  function r(o, i) {
    hv(
      o.pathname.charAt(0) === "/",
      "relative pathnames are not supported in hash history.push(" +
        JSON.stringify(i) +
        ")"
    );
  }
  return vv(t, n, r, e);
}
function hv(e, t) {
  if (!e) {
    typeof console != "undefined" && console.warn(t);
    try {
      throw new Error(t);
    } catch {}
  }
}
function gv() {
  return Math.random().toString(36).substr(2, 8);
}
function kc(e) {
  return { usr: e.state, key: e.key };
}
function Ps(e, t, n, r) {
  return (
    n === void 0 && (n = null),
    Ts(
      { pathname: typeof e == "string" ? e : e.pathname, search: "", hash: "" },
      typeof t == "string" ? Kr(t) : t,
      { state: n, key: (t && t.key) || r || gv() }
    )
  );
}
function mv(e) {
  let { pathname: t = "/", search: n = "", hash: r = "" } = e;
  return (
    n && n !== "?" && (t += n.charAt(0) === "?" ? n : "?" + n),
    r && r !== "#" && (t += r.charAt(0) === "#" ? r : "#" + r),
    t
  );
}
function Kr(e) {
  let t = {};
  if (e) {
    let n = e.indexOf("#");
    n >= 0 && ((t.hash = e.substr(n)), (e = e.substr(0, n)));
    let r = e.indexOf("?");
    r >= 0 && ((t.search = e.substr(r)), (e = e.substr(0, r))),
      e && (t.pathname = e);
  }
  return t;
}
function vv(e, t, n, r) {
  r === void 0 && (r = {});
  let { window: o = document.defaultView, v5Compat: i = !1 } = r,
    l = o.history,
    s = St.Pop,
    u = null;
  function a() {
    (s = St.Pop), u && u({ action: s, location: p.location });
  }
  function c(y, S) {
    s = St.Push;
    let m = Ps(p.location, y, S);
    n && n(m, y);
    let C = kc(m),
      h = p.createHref(m);
    try {
      l.pushState(C, "", h);
    } catch {
      o.location.assign(h);
    }
    i && u && u({ action: s, location: m });
  }
  function f(y, S) {
    s = St.Replace;
    let m = Ps(p.location, y, S);
    n && n(m, y);
    let C = kc(m),
      h = p.createHref(m);
    l.replaceState(C, "", h), i && u && u({ action: s, location: m });
  }
  let p = {
    get action() {
      return s;
    },
    get location() {
      return e(o, l);
    },
    listen(y) {
      if (u) throw new Error("A history only accepts one active listener");
      return (
        o.addEventListener(Cc, a),
        (u = y),
        () => {
          o.removeEventListener(Cc, a), (u = null);
        }
      );
    },
    createHref(y) {
      return t(o, y);
    },
    push: c,
    replace: f,
    go(y) {
      return l.go(y);
    },
  };
  return p;
}
var Oc;
(function (e) {
  (e.data = "data"),
    (e.deferred = "deferred"),
    (e.redirect = "redirect"),
    (e.error = "error");
})(Oc || (Oc = {}));
function yv(e, t, n) {
  n === void 0 && (n = "/");
  let r = typeof t == "string" ? Kr(t) : t,
    o = zp(r.pathname || "/", n);
  if (o == null) return null;
  let i = Fp(e);
  Sv(i);
  let l = null;
  for (let s = 0; l == null && s < i.length; ++s) l = Iv(i[s], o);
  return l;
}
function Fp(e, t, n, r) {
  return (
    t === void 0 && (t = []),
    n === void 0 && (n = []),
    r === void 0 && (r = ""),
    e.forEach((o, i) => {
      let l = {
        relativePath: o.path || "",
        caseSensitive: o.caseSensitive === !0,
        childrenIndex: i,
        route: o,
      };
      l.relativePath.startsWith("/") &&
        (De(
          l.relativePath.startsWith(r),
          'Absolute route path "' +
            l.relativePath +
            '" nested under path ' +
            ('"' + r + '" is not valid. An absolute child route path ') +
            "must start with the combined path of all its parent routes."
        ),
        (l.relativePath = l.relativePath.slice(r.length)));
      let s = Mn([r, l.relativePath]),
        u = n.concat(l);
      o.children &&
        o.children.length > 0 &&
        (De(
          o.index !== !0,
          "Index routes must not have child routes. Please remove " +
            ('all child routes from route path "' + s + '".')
        ),
        Fp(o.children, t, u, s)),
        !(o.path == null && !o.index) &&
          t.push({ path: s, score: Tv(s, o.index), routesMeta: u });
    }),
    t
  );
}
function Sv(e) {
  e.sort((t, n) =>
    t.score !== n.score
      ? n.score - t.score
      : Pv(
          t.routesMeta.map((r) => r.childrenIndex),
          n.routesMeta.map((r) => r.childrenIndex)
        )
  );
}
const wv = /^:\w+$/,
  xv = 3,
  Ev = 2,
  Cv = 1,
  kv = 10,
  Ov = -2,
  Tc = (e) => e === "*";
function Tv(e, t) {
  let n = e.split("/"),
    r = n.length;
  return (
    n.some(Tc) && (r += Ov),
    t && (r += Ev),
    n
      .filter((o) => !Tc(o))
      .reduce((o, i) => o + (wv.test(i) ? xv : i === "" ? Cv : kv), r)
  );
}
function Pv(e, t) {
  return e.length === t.length && e.slice(0, -1).every((r, o) => r === t[o])
    ? e[e.length - 1] - t[t.length - 1]
    : 0;
}
function Iv(e, t) {
  let { routesMeta: n } = e,
    r = {},
    o = "/",
    i = [];
  for (let l = 0; l < n.length; ++l) {
    let s = n[l],
      u = l === n.length - 1,
      a = o === "/" ? t : t.slice(o.length) || "/",
      c = Dv(
        { path: s.relativePath, caseSensitive: s.caseSensitive, end: u },
        a
      );
    if (!c) return null;
    Object.assign(r, c.params);
    let f = s.route;
    i.push({
      params: r,
      pathname: Mn([o, c.pathname]),
      pathnameBase: _v(Mn([o, c.pathnameBase])),
      route: f,
    }),
      c.pathnameBase !== "/" && (o = Mn([o, c.pathnameBase]));
  }
  return i;
}
function Dv(e, t) {
  typeof e == "string" && (e = { path: e, caseSensitive: !1, end: !0 });
  let [n, r] = $v(e.path, e.caseSensitive, e.end),
    o = t.match(n);
  if (!o) return null;
  let i = o[0],
    l = i.replace(/(.)\/+$/, "$1"),
    s = o.slice(1);
  return {
    params: r.reduce((a, c, f) => {
      if (c === "*") {
        let p = s[f] || "";
        l = i.slice(0, i.length - p.length).replace(/(.)\/+$/, "$1");
      }
      return (a[c] = Rv(s[f] || "", c)), a;
    }, {}),
    pathname: i,
    pathnameBase: l,
    pattern: e,
  };
}
function $v(e, t, n) {
  t === void 0 && (t = !1),
    n === void 0 && (n = !0),
    jp(
      e === "*" || !e.endsWith("*") || e.endsWith("/*"),
      'Route path "' +
        e +
        '" will be treated as if it were ' +
        ('"' + e.replace(/\*$/, "/*") + '" because the `*` character must ') +
        "always follow a `/` in the pattern. To get rid of this warning, " +
        ('please change the route path to "' + e.replace(/\*$/, "/*") + '".')
    );
  let r = [],
    o =
      "^" +
      e
        .replace(/\/*\*?$/, "")
        .replace(/^\/*/, "/")
        .replace(/[\\.*+^$?{}|()[\]]/g, "\\$&")
        .replace(/:(\w+)/g, (l, s) => (r.push(s), "([^\\/]+)"));
  return (
    e.endsWith("*")
      ? (r.push("*"),
        (o += e === "*" || e === "/*" ? "(.*)$" : "(?:\\/(.+)|\\/*)$"))
      : n
      ? (o += "\\/*$")
      : e !== "" && e !== "/" && (o += "(?:(?=\\/|$))"),
    [new RegExp(o, t ? void 0 : "i"), r]
  );
}
function Rv(e, t) {
  try {
    return decodeURIComponent(e);
  } catch (n) {
    return (
      jp(
        !1,
        'The value for the URL param "' +
          t +
          '" will not be decoded because' +
          (' the string "' +
            e +
            '" is a malformed URL segment. This is probably') +
          (" due to a bad percent encoding (" + n + ").")
      ),
      e
    );
  }
}
function zp(e, t) {
  if (t === "/") return e;
  if (!e.toLowerCase().startsWith(t.toLowerCase())) return null;
  let n = t.endsWith("/") ? t.length - 1 : t.length,
    r = e.charAt(n);
  return r && r !== "/" ? null : e.slice(n) || "/";
}
function De(e, t) {
  if (e === !1 || e === null || typeof e == "undefined") throw new Error(t);
}
function jp(e, t) {
  if (!e) {
    typeof console != "undefined" && console.warn(t);
    try {
      throw new Error(t);
    } catch {}
  }
}
const Mn = (e) => e.join("/").replace(/\/\/+/g, "/"),
  _v = (e) => e.replace(/\/+$/, "").replace(/^\/*/, "/");
class Nv {
  constructor(t, n, r) {
    (this.status = t), (this.statusText = n || ""), (this.data = r);
  }
}
function bv(e) {
  return e instanceof Nv;
}
/**
 * React Router v6.4.2
 *
 * Copyright (c) Remix Software Inc.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE.md file in the root directory of this source tree.
 *
 * @license MIT
 */ function Is() {
  return (
    (Is = Object.assign
      ? Object.assign.bind()
      : function (e) {
          for (var t = 1; t < arguments.length; t++) {
            var n = arguments[t];
            for (var r in n)
              Object.prototype.hasOwnProperty.call(n, r) && (e[r] = n[r]);
          }
          return e;
        }),
    Is.apply(this, arguments)
  );
}
function Mv(e, t) {
  return (e === t && (e !== 0 || 1 / e === 1 / t)) || (e !== e && t !== t);
}
const Lv = typeof Object.is == "function" ? Object.is : Mv,
  { useState: Fv, useEffect: zv, useLayoutEffect: jv, useDebugValue: Av } = Wo;
function Bv(e, t, n) {
  const r = t(),
    [{ inst: o }, i] = Fv({ inst: { value: r, getSnapshot: t } });
  return (
    jv(() => {
      (o.value = r), (o.getSnapshot = t), ml(o) && i({ inst: o });
    }, [e, r, t]),
    zv(
      () => (
        ml(o) && i({ inst: o }),
        e(() => {
          ml(o) && i({ inst: o });
        })
      ),
      [e]
    ),
    Av(r),
    r
  );
}
function ml(e) {
  const t = e.getSnapshot,
    n = e.value;
  try {
    const r = t();
    return !Lv(n, r);
  } catch {
    return !0;
  }
}
function Uv(e, t, n) {
  return t();
}
const Wv =
    typeof window != "undefined" &&
    typeof window.document != "undefined" &&
    typeof window.document.createElement != "undefined",
  Hv = !Wv,
  Vv = Hv ? Uv : Bv;
"useSyncExternalStore" in Wo && ((e) => e.useSyncExternalStore)(Wo);
const Qv = g.exports.createContext(null),
  Gv = g.exports.createContext(null),
  Ap = g.exports.createContext(null),
  Kv = g.exports.createContext(null),
  Ri = g.exports.createContext(null),
  Ku = g.exports.createContext({ outlet: null, matches: [] }),
  Bp = g.exports.createContext(null);
function Yu() {
  return g.exports.useContext(Ri) != null;
}
function Yv() {
  return Yu() || De(!1), g.exports.useContext(Ri).location;
}
function Xv(e, t) {
  Yu() || De(!1);
  let n = g.exports.useContext(Ap),
    { matches: r } = g.exports.useContext(Ku),
    o = r[r.length - 1],
    i = o ? o.params : {};
  o && o.pathname;
  let l = o ? o.pathnameBase : "/";
  o && o.route;
  let s = Yv(),
    u;
  if (t) {
    var a;
    let S = typeof t == "string" ? Kr(t) : t;
    l === "/" ||
      ((a = S.pathname) == null ? void 0 : a.startsWith(l)) ||
      De(!1),
      (u = S);
  } else u = s;
  let c = u.pathname || "/",
    f = l === "/" ? c : c.slice(l.length) || "/",
    p = yv(e, { pathname: f }),
    y = ey(
      p &&
        p.map((S) =>
          Object.assign({}, S, {
            params: Object.assign({}, i, S.params),
            pathname: Mn([l, S.pathname]),
            pathnameBase: S.pathnameBase === "/" ? l : Mn([l, S.pathnameBase]),
          })
        ),
      r,
      n || void 0
    );
  return t
    ? g.exports.createElement(
        Ri.Provider,
        {
          value: {
            location: Is(
              {
                pathname: "/",
                search: "",
                hash: "",
                state: null,
                key: "default",
              },
              u
            ),
            navigationType: St.Pop,
          },
        },
        y
      )
    : y;
}
function Zv() {
  let e = ny(),
    t = bv(e)
      ? e.status + " " + e.statusText
      : e instanceof Error
      ? e.message
      : JSON.stringify(e),
    n = e instanceof Error ? e.stack : null,
    r = "rgba(200,200,200, 0.5)",
    o = { padding: "0.5rem", backgroundColor: r },
    i = { padding: "2px 4px", backgroundColor: r };
  return g.exports.createElement(
    g.exports.Fragment,
    null,
    g.exports.createElement("h2", null, "Unhandled Thrown Error!"),
    g.exports.createElement("h3", { style: { fontStyle: "italic" } }, t),
    n ? g.exports.createElement("pre", { style: o }, n) : null,
    g.exports.createElement("p", null, "\u{1F4BF} Hey developer \u{1F44B}"),
    g.exports.createElement(
      "p",
      null,
      "You can provide a way better UX than this when your app throws errors by providing your own\xA0",
      g.exports.createElement("code", { style: i }, "errorElement"),
      " props on\xA0",
      g.exports.createElement("code", { style: i }, "<Route>")
    )
  );
}
class qv extends g.exports.Component {
  constructor(t) {
    super(t), (this.state = { location: t.location, error: t.error });
  }
  static getDerivedStateFromError(t) {
    return { error: t };
  }
  static getDerivedStateFromProps(t, n) {
    return n.location !== t.location
      ? { error: t.error, location: t.location }
      : { error: t.error || n.error, location: n.location };
  }
  componentDidCatch(t, n) {
    console.error(
      "React Router caught the following error during render",
      t,
      n
    );
  }
  render() {
    return this.state.error
      ? g.exports.createElement(Bp.Provider, {
          value: this.state.error,
          children: this.props.component,
        })
      : this.props.children;
  }
}
function Jv(e) {
  let { routeContext: t, match: n, children: r } = e,
    o = g.exports.useContext(Qv);
  return (
    o && n.route.errorElement && (o._deepestRenderedBoundaryId = n.route.id),
    g.exports.createElement(Ku.Provider, { value: t }, r)
  );
}
function ey(e, t, n) {
  if ((t === void 0 && (t = []), e == null))
    if (n != null && n.errors) e = n.matches;
    else return null;
  let r = e,
    o = n == null ? void 0 : n.errors;
  if (o != null) {
    let i = r.findIndex(
      (l) => l.route.id && (o == null ? void 0 : o[l.route.id])
    );
    i >= 0 || De(!1), (r = r.slice(0, Math.min(r.length, i + 1)));
  }
  return r.reduceRight((i, l, s) => {
    let u = l.route.id ? (o == null ? void 0 : o[l.route.id]) : null,
      a = n ? l.route.errorElement || g.exports.createElement(Zv, null) : null,
      c = () =>
        g.exports.createElement(
          Jv,
          {
            match: l,
            routeContext: { outlet: i, matches: t.concat(r.slice(0, s + 1)) },
          },
          u ? a : l.route.element !== void 0 ? l.route.element : i
        );
    return n && (l.route.errorElement || s === 0)
      ? g.exports.createElement(qv, {
          location: n.location,
          component: a,
          error: u,
          children: c(),
        })
      : c();
  }, null);
}
var Pc;
(function (e) {
  e.UseRevalidator = "useRevalidator";
})(Pc || (Pc = {}));
var Ds;
(function (e) {
  (e.UseLoaderData = "useLoaderData"),
    (e.UseActionData = "useActionData"),
    (e.UseRouteError = "useRouteError"),
    (e.UseNavigation = "useNavigation"),
    (e.UseRouteLoaderData = "useRouteLoaderData"),
    (e.UseMatches = "useMatches"),
    (e.UseRevalidator = "useRevalidator");
})(Ds || (Ds = {}));
function ty(e) {
  let t = g.exports.useContext(Ap);
  return t || De(!1), t;
}
function ny() {
  var e;
  let t = g.exports.useContext(Bp),
    n = ty(Ds.UseRouteError),
    r = g.exports.useContext(Ku),
    o = r.matches[r.matches.length - 1];
  return (
    t ||
    (r || De(!1),
    o.route.id || De(!1),
    (e = n.errors) == null ? void 0 : e[o.route.id])
  );
}
function $s(e) {
  De(!1);
}
function ry(e) {
  let {
    basename: t = "/",
    children: n = null,
    location: r,
    navigationType: o = St.Pop,
    navigator: i,
    static: l = !1,
  } = e;
  Yu() && De(!1);
  let s = t.replace(/^\/*/, "/"),
    u = g.exports.useMemo(
      () => ({ basename: s, navigator: i, static: l }),
      [s, i, l]
    );
  typeof r == "string" && (r = Kr(r));
  let {
      pathname: a = "/",
      search: c = "",
      hash: f = "",
      state: p = null,
      key: y = "default",
    } = r,
    S = g.exports.useMemo(() => {
      let m = zp(a, s);
      return m == null
        ? null
        : { pathname: m, search: c, hash: f, state: p, key: y };
    }, [s, a, c, f, p, y]);
  return S == null
    ? null
    : g.exports.createElement(
        Kv.Provider,
        { value: u },
        g.exports.createElement(Ri.Provider, {
          children: n,
          value: { location: S, navigationType: o },
        })
      );
}
function oy(e) {
  let { children: t, location: n } = e,
    r = g.exports.useContext(Gv),
    o = r && !t ? r.router.routes : Rs(t);
  return Xv(o, n);
}
var Ic;
(function (e) {
  (e[(e.pending = 0)] = "pending"),
    (e[(e.success = 1)] = "success"),
    (e[(e.error = 2)] = "error");
})(Ic || (Ic = {}));
new Promise(() => {});
function Rs(e, t) {
  t === void 0 && (t = []);
  let n = [];
  return (
    g.exports.Children.forEach(e, (r, o) => {
      if (!g.exports.isValidElement(r)) return;
      if (r.type === g.exports.Fragment) {
        n.push.apply(n, Rs(r.props.children, t));
        return;
      }
      r.type !== $s && De(!1), !r.props.index || !r.props.children || De(!1);
      let i = [...t, o],
        l = {
          id: r.props.id || i.join("-"),
          caseSensitive: r.props.caseSensitive,
          element: r.props.element,
          index: r.props.index,
          path: r.props.path,
          loader: r.props.loader,
          action: r.props.action,
          errorElement: r.props.errorElement,
          hasErrorBoundary: r.props.errorElement != null,
          shouldRevalidate: r.props.shouldRevalidate,
          handle: r.props.handle,
        };
      r.props.children && (l.children = Rs(r.props.children, i)), n.push(l);
    }),
    n
  );
}
/**
 * React Router DOM v6.4.2
 *
 * Copyright (c) Remix Software Inc.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE.md file in the root directory of this source tree.
 *
 * @license MIT
 */ function iy(e) {
  let { basename: t, children: n, window: r } = e,
    o = g.exports.useRef();
  o.current == null && (o.current = pv({ window: r, v5Compat: !0 }));
  let i = o.current,
    [l, s] = g.exports.useState({ action: i.action, location: i.location });
  return (
    g.exports.useLayoutEffect(() => i.listen(s), [i]),
    g.exports.createElement(ry, {
      basename: t,
      children: n,
      location: l.location,
      navigationType: l.action,
      navigator: i,
    })
  );
}
var Dc;
(function (e) {
  (e.UseScrollRestoration = "useScrollRestoration"),
    (e.UseSubmitImpl = "useSubmitImpl"),
    (e.UseFetcher = "useFetcher");
})(Dc || (Dc = {}));
var $c;
(function (e) {
  (e.UseFetchers = "useFetchers"),
    (e.UseScrollRestoration = "useScrollRestoration");
})($c || ($c = {}));
const ly = () => !window.invokeNative,
  sy = () => {},
  Up = (e, t) => {
    const n = g.exports.useRef(sy);
    g.exports.useEffect(() => {
      n.current = t;
    }, [t]),
      g.exports.useEffect(() => {
        const r = (o) => {
          const { action: i, data: l } = o.data;
          n.current && i === e && n.current(l);
        };
        return (
          window.addEventListener("message", r),
          () => window.removeEventListener("message", r)
        );
      }, [e]);
  };
var _i = { exports: {} },
  Ni = {};
/**
 * @license React
 * react-jsx-runtime.production.min.js
 *
 * Copyright (c) Facebook, Inc. and its affiliates.
 *
 * This source code is licensed under the MIT license found in the
 * LICENSE file in the root directory of this source tree.
 */ var uy = g.exports,
  ay = Symbol.for("react.element"),
  cy = Symbol.for("react.fragment"),
  dy = Object.prototype.hasOwnProperty,
  fy = uy.__SECRET_INTERNALS_DO_NOT_USE_OR_YOU_WILL_BE_FIRED.ReactCurrentOwner,
  py = { key: !0, ref: !0, __self: !0, __source: !0 };
function Wp(e, t, n) {
  var r,
    o = {},
    i = null,
    l = null;
  n !== void 0 && (i = "" + n),
    t.key !== void 0 && (i = "" + t.key),
    t.ref !== void 0 && (l = t.ref);
  for (r in t) dy.call(t, r) && !py.hasOwnProperty(r) && (o[r] = t[r]);
  if (e && e.defaultProps)
    for (r in ((t = e.defaultProps), t)) o[r] === void 0 && (o[r] = t[r]);
  return {
    $$typeof: ay,
    type: e,
    key: i,
    ref: l,
    props: o,
    _owner: fy.current,
  };
}
Ni.Fragment = cy;
Ni.jsx = Wp;
Ni.jsxs = Wp;
_i.exports = Ni;
const P = _i.exports.jsx,
  j = _i.exports.jsxs,
  hy = _i.exports.Fragment,
  gy = ({ children: e }) => {
    const [t, n] = g.exports.useState(!1);
    return Up("openChest", n), t ? P("div", { children: e }) : P(hy, {});
  };
async function Bt(e, t, n) {
  const r = {
    method: "post",
    headers: { "Content-Type": "application/json; charset=UTF-8" },
    body: JSON.stringify(t),
  };
  if (ly() && n) return n;
  const o = window.GetParentResourceName
    ? window.GetParentResourceName()
    : "nui-frame-app";
  return await (await fetch(`https://${o}/${e}`, r)).json();
}
const Hp = g.exports.createContext({}),
  cn = 30,
  my = ({ children: e }) => {
    const [t, n] = g.exports.useState(1),
      [r, o] = g.exports.useState(),
      [i, l] = g.exports.useState(!0),
      [s, u] = g.exports.useState({ weight: 0, maxWeight: 0 }),
      [a, c] = g.exports.useState({ weight: 0, maxWeight: 0 }),
      [f, p] = g.exports.useState({ sections: [] }),
      [y, S] = g.exports.useState({ sections: [] });
    Up("requestChest", () => {
      m();
    }),
      g.exports.useEffect(() => {
        (async () => {
          l(!0), await m(), l(!1);
        })();
      }, []);
    const m = async () => {
        const h = await Bt("Profile");
        o(h);
        const {
            inventario: d,
            invPeso: v,
            invMaxpeso: w,
            chest: E,
            chestPeso: x,
            chestMaxpeso: k,
          } = await Bt("requestInventoryAndChest"),
          O = [],
          _ = [];
        u({ weight: v, maxWeight: w }),
          c({ weight: x, maxWeight: k }),
          d.map((q, ae) => {
            d[ae - 1], d[ae + 1];
          }),
          E.map((q, ae) => {
            d[ae - 1], d[ae + 1];
          }),
          d.map((q) => {
            _[q.slot - 1] = q;
          }),
          E.map((q) => {
            O[q.slot - 1] = q;
          });
        const R = _.splice(0, cn),
          z = O.splice(0, cn);
        p({
          sections: [
            {
              sectionId: "inventory",
              itemsList: [
                ...R,
                ...Array(R.length < cn ? cn - R.length : 0).fill(null),
              ],
            },
          ],
        }),
          S({
            sections: [
              {
                sectionId: "chest",
                itemsList: [
                  ...z,
                  ...Array(z.length < cn ? cn - z.length : 0).fill(null),
                ],
              },
            ],
          });
      },
      C = async (h, d, v, w, E, x) => {
        const k = v === "inventory" ? f.sections[0] : y.sections[0],
          O = w === "inventory" ? f.sections[0] : y.sections[0];
        if (!k || !O) return;
        const _ = k.itemsList[h];
        if ((console.log(), !(!_ || _.amount < E))) {
          if (v === "chest" && w === "inventory") {
            await Bt("takeItem", {
              slot: h + 1,
              target: d + 1,
              amount: E,
              dragSectionId: v,
              item: _.item,
            });
            return;
          }
          if (v === "inventory" && w === "chest") {
            await Bt("storeItem", {
              slot: h + 1,
              target: d + 1,
              amount: E,
              dragSectionId: v,
              item: _.item,
            });
            return;
          }
          await Bt("updateSlot", {
            slot: h + 1,
            target: d + 1,
            amount: E,
            dragSectionId: v,
            hoverSectionId: w,
          }),
            p({ ...f }),
            S({ ...y });
        }
      };
    return P(Hp.Provider, {
      value: {
        profile: r,
        loading: i,
        inventory: f,
        chest: y,
        inventoryWeight: s,
        chestWeight: a,
        moveItem: C,
        quantity: t,
        setQuantity: n,
      },
      children: e,
    });
  };
const Yr = () => g.exports.useContext(Hp);
var B = "colors",
  he = "sizes",
  $ = "space",
  vy = {
    gap: $,
    gridGap: $,
    columnGap: $,
    gridColumnGap: $,
    rowGap: $,
    gridRowGap: $,
    inset: $,
    insetBlock: $,
    insetBlockEnd: $,
    insetBlockStart: $,
    insetInline: $,
    insetInlineEnd: $,
    insetInlineStart: $,
    margin: $,
    marginTop: $,
    marginRight: $,
    marginBottom: $,
    marginLeft: $,
    marginBlock: $,
    marginBlockEnd: $,
    marginBlockStart: $,
    marginInline: $,
    marginInlineEnd: $,
    marginInlineStart: $,
    padding: $,
    paddingTop: $,
    paddingRight: $,
    paddingBottom: $,
    paddingLeft: $,
    paddingBlock: $,
    paddingBlockEnd: $,
    paddingBlockStart: $,
    paddingInline: $,
    paddingInlineEnd: $,
    paddingInlineStart: $,
    top: $,
    right: $,
    bottom: $,
    left: $,
    scrollMargin: $,
    scrollMarginTop: $,
    scrollMarginRight: $,
    scrollMarginBottom: $,
    scrollMarginLeft: $,
    scrollMarginX: $,
    scrollMarginY: $,
    scrollMarginBlock: $,
    scrollMarginBlockEnd: $,
    scrollMarginBlockStart: $,
    scrollMarginInline: $,
    scrollMarginInlineEnd: $,
    scrollMarginInlineStart: $,
    scrollPadding: $,
    scrollPaddingTop: $,
    scrollPaddingRight: $,
    scrollPaddingBottom: $,
    scrollPaddingLeft: $,
    scrollPaddingX: $,
    scrollPaddingY: $,
    scrollPaddingBlock: $,
    scrollPaddingBlockEnd: $,
    scrollPaddingBlockStart: $,
    scrollPaddingInline: $,
    scrollPaddingInlineEnd: $,
    scrollPaddingInlineStart: $,
    fontSize: "fontSizes",
    background: B,
    backgroundColor: B,
    backgroundImage: B,
    borderImage: B,
    border: B,
    borderBlock: B,
    borderBlockEnd: B,
    borderBlockStart: B,
    borderBottom: B,
    borderBottomColor: B,
    borderColor: B,
    borderInline: B,
    borderInlineEnd: B,
    borderInlineStart: B,
    borderLeft: B,
    borderLeftColor: B,
    borderRight: B,
    borderRightColor: B,
    borderTop: B,
    borderTopColor: B,
    caretColor: B,
    color: B,
    columnRuleColor: B,
    fill: B,
    outline: B,
    outlineColor: B,
    stroke: B,
    textDecorationColor: B,
    fontFamily: "fonts",
    fontWeight: "fontWeights",
    lineHeight: "lineHeights",
    letterSpacing: "letterSpacings",
    blockSize: he,
    minBlockSize: he,
    maxBlockSize: he,
    inlineSize: he,
    minInlineSize: he,
    maxInlineSize: he,
    width: he,
    minWidth: he,
    maxWidth: he,
    height: he,
    minHeight: he,
    maxHeight: he,
    flexBasis: he,
    gridTemplateColumns: he,
    gridTemplateRows: he,
    borderWidth: "borderWidths",
    borderTopWidth: "borderWidths",
    borderRightWidth: "borderWidths",
    borderBottomWidth: "borderWidths",
    borderLeftWidth: "borderWidths",
    borderStyle: "borderStyles",
    borderTopStyle: "borderStyles",
    borderRightStyle: "borderStyles",
    borderBottomStyle: "borderStyles",
    borderLeftStyle: "borderStyles",
    borderRadius: "radii",
    borderTopLeftRadius: "radii",
    borderTopRightRadius: "radii",
    borderBottomRightRadius: "radii",
    borderBottomLeftRadius: "radii",
    boxShadow: "shadows",
    textShadow: "shadows",
    transition: "transitions",
    zIndex: "zIndices",
  },
  yy = (e, t) =>
    typeof t == "function" ? { "()": Function.prototype.toString.call(t) } : t,
  Qn = () => {
    const e = Object.create(null);
    return (t, n, ...r) => {
      const o = ((i) => JSON.stringify(i, yy))(t);
      return o in e ? e[o] : (e[o] = n(t, ...r));
    };
  },
  Gt = Symbol.for("sxs.internal"),
  Xu = (e, t) =>
    Object.defineProperties(e, Object.getOwnPropertyDescriptors(t)),
  Rc = (e) => {
    for (const t in e) return !0;
    return !1;
  },
  { hasOwnProperty: Sy } = Object.prototype,
  _s = (e) =>
    e.includes("-") ? e : e.replace(/[A-Z]/g, (t) => "-" + t.toLowerCase()),
  wy = /\s+(?![^()]*\))/,
  dn = (e) => (t) => e(...(typeof t == "string" ? String(t).split(wy) : [t])),
  _c = {
    appearance: (e) => ({ WebkitAppearance: e, appearance: e }),
    backfaceVisibility: (e) => ({
      WebkitBackfaceVisibility: e,
      backfaceVisibility: e,
    }),
    backdropFilter: (e) => ({ WebkitBackdropFilter: e, backdropFilter: e }),
    backgroundClip: (e) => ({ WebkitBackgroundClip: e, backgroundClip: e }),
    boxDecorationBreak: (e) => ({
      WebkitBoxDecorationBreak: e,
      boxDecorationBreak: e,
    }),
    clipPath: (e) => ({ WebkitClipPath: e, clipPath: e }),
    content: (e) => ({
      content:
        e.includes('"') ||
        e.includes("'") ||
        /^([A-Za-z]+\([^]*|[^]*-quote|inherit|initial|none|normal|revert|unset)$/.test(
          e
        )
          ? e
          : `"${e}"`,
    }),
    hyphens: (e) => ({ WebkitHyphens: e, hyphens: e }),
    maskImage: (e) => ({ WebkitMaskImage: e, maskImage: e }),
    maskSize: (e) => ({ WebkitMaskSize: e, maskSize: e }),
    tabSize: (e) => ({ MozTabSize: e, tabSize: e }),
    textSizeAdjust: (e) => ({ WebkitTextSizeAdjust: e, textSizeAdjust: e }),
    userSelect: (e) => ({ WebkitUserSelect: e, userSelect: e }),
    marginBlock: dn((e, t) => ({
      marginBlockStart: e,
      marginBlockEnd: t || e,
    })),
    marginInline: dn((e, t) => ({
      marginInlineStart: e,
      marginInlineEnd: t || e,
    })),
    maxSize: dn((e, t) => ({ maxBlockSize: e, maxInlineSize: t || e })),
    minSize: dn((e, t) => ({ minBlockSize: e, minInlineSize: t || e })),
    paddingBlock: dn((e, t) => ({
      paddingBlockStart: e,
      paddingBlockEnd: t || e,
    })),
    paddingInline: dn((e, t) => ({
      paddingInlineStart: e,
      paddingInlineEnd: t || e,
    })),
  },
  vl = /([\d.]+)([^]*)/,
  xy = (e, t) =>
    e.length
      ? e.reduce(
          (n, r) => (
            n.push(
              ...t.map((o) =>
                o.includes("&")
                  ? o.replace(
                      /&/g,
                      /[ +>|~]/.test(r) && /&.*&/.test(o) ? `:is(${r})` : r
                    )
                  : r + " " + o
              )
            ),
            n
          ),
          []
        )
      : t,
  Ey = (e, t) =>
    e in Cy && typeof t == "string"
      ? t.replace(
          /^((?:[^]*[^\w-])?)(fit-content|stretch)((?:[^\w-][^]*)?)$/,
          (n, r, o, i) =>
            r +
            (o === "stretch"
              ? `-moz-available${i};${_s(e)}:${r}-webkit-fill-available`
              : `-moz-fit-content${i};${_s(e)}:${r}fit-content`) +
            i
        )
      : String(t),
  Cy = {
    blockSize: 1,
    height: 1,
    inlineSize: 1,
    maxBlockSize: 1,
    maxHeight: 1,
    maxInlineSize: 1,
    maxWidth: 1,
    minBlockSize: 1,
    minHeight: 1,
    minInlineSize: 1,
    minWidth: 1,
    width: 1,
  },
  ct = (e) => (e ? e + "-" : ""),
  Vp = (e, t, n) =>
    e.replace(
      /([+-])?((?:\d+(?:\.\d*)?|\.\d+)(?:[Ee][+-]?\d+)?)?(\$|--)([$\w-]+)/g,
      (r, o, i, l, s) =>
        (l == "$") == !!i
          ? r
          : (o || l == "--" ? "calc(" : "") +
            "var(--" +
            (l === "$"
              ? ct(t) + (s.includes("$") ? "" : ct(n)) + s.replace(/\$/g, "-")
              : s) +
            ")" +
            (o || l == "--" ? "*" + (o || "") + (i || "1") + ")" : "")
    ),
  ky = /\s*,\s*(?![^()]*\))/,
  Oy = Object.prototype.toString,
  In = (e, t, n, r, o) => {
    let i, l, s;
    const u = (a, c, f) => {
      let p, y;
      const S = (m) => {
        for (p in m) {
          const d = p.charCodeAt(0) === 64,
            v = d && Array.isArray(m[p]) ? m[p] : [m[p]];
          for (y of v) {
            const w = /[A-Z]/.test((h = p))
                ? h
                : h.replace(/-[^]/g, (x) => x[1].toUpperCase()),
              E =
                typeof y == "object" &&
                y &&
                y.toString === Oy &&
                (!r.utils[w] || !c.length);
            if (w in r.utils && !E) {
              const x = r.utils[w];
              if (x !== l) {
                (l = x), S(x(y)), (l = null);
                continue;
              }
            } else if (w in _c) {
              const x = _c[w];
              if (x !== s) {
                (s = x), S(x(y)), (s = null);
                continue;
              }
            }
            if (
              (d &&
                ((C =
                  p.slice(1) in r.media ? "@media " + r.media[p.slice(1)] : p),
                (p = C.replace(
                  /\(\s*([\w-]+)\s*(=|<|<=|>|>=)\s*([\w-]+)\s*(?:(<|<=|>|>=)\s*([\w-]+)\s*)?\)/g,
                  (x, k, O, _, R, z) => {
                    const q = vl.test(k),
                      ae = 0.0625 * (q ? -1 : 1),
                      [bt, qr] = q ? [_, k] : [k, _];
                    return (
                      "(" +
                      (O[0] === "="
                        ? ""
                        : (O[0] === ">") === q
                        ? "max-"
                        : "min-") +
                      bt +
                      ":" +
                      (O[0] !== "=" && O.length === 1
                        ? qr.replace(
                            vl,
                            (Gn, Mt, I) =>
                              Number(Mt) + ae * (O === ">" ? 1 : -1) + I
                          )
                        : qr) +
                      (R
                        ? ") and (" +
                          (R[0] === ">" ? "min-" : "max-") +
                          bt +
                          ":" +
                          (R.length === 1
                            ? z.replace(
                                vl,
                                (Gn, Mt, I) =>
                                  Number(Mt) + ae * (R === ">" ? -1 : 1) + I
                              )
                            : z)
                        : "") +
                      ")"
                    );
                  }
                ))),
              E)
            ) {
              const x = d ? f.concat(p) : [...f],
                k = d ? [...c] : xy(c, p.split(ky));
              i !== void 0 && o(Nc(...i)), (i = void 0), u(y, k, x);
            } else
              i === void 0 && (i = [[], c, f]),
                (p =
                  d || p.charCodeAt(0) !== 36
                    ? p
                    : `--${ct(r.prefix)}${p.slice(1).replace(/\$/g, "-")}`),
                (y = E
                  ? y
                  : typeof y == "number"
                  ? y && w in Ty
                    ? String(y) + "px"
                    : String(y)
                  : Vp(Ey(w, y == null ? "" : y), r.prefix, r.themeMap[w])),
                i[0].push(`${d ? `${p} ` : `${_s(p)}:`}${y}`);
          }
        }
        var C, h;
      };
      S(a), i !== void 0 && o(Nc(...i)), (i = void 0);
    };
    u(e, t, n);
  },
  Nc = (e, t, n) =>
    `${n.map((r) => `${r}{`).join("")}${
      t.length ? `${t.join(",")}{` : ""
    }${e.join(";")}${t.length ? "}" : ""}${Array(
      n.length ? n.length + 1 : 0
    ).join("}")}`,
  Ty = {
    animationDelay: 1,
    animationDuration: 1,
    backgroundSize: 1,
    blockSize: 1,
    border: 1,
    borderBlock: 1,
    borderBlockEnd: 1,
    borderBlockEndWidth: 1,
    borderBlockStart: 1,
    borderBlockStartWidth: 1,
    borderBlockWidth: 1,
    borderBottom: 1,
    borderBottomLeftRadius: 1,
    borderBottomRightRadius: 1,
    borderBottomWidth: 1,
    borderEndEndRadius: 1,
    borderEndStartRadius: 1,
    borderInlineEnd: 1,
    borderInlineEndWidth: 1,
    borderInlineStart: 1,
    borderInlineStartWidth: 1,
    borderInlineWidth: 1,
    borderLeft: 1,
    borderLeftWidth: 1,
    borderRadius: 1,
    borderRight: 1,
    borderRightWidth: 1,
    borderSpacing: 1,
    borderStartEndRadius: 1,
    borderStartStartRadius: 1,
    borderTop: 1,
    borderTopLeftRadius: 1,
    borderTopRightRadius: 1,
    borderTopWidth: 1,
    borderWidth: 1,
    bottom: 1,
    columnGap: 1,
    columnRule: 1,
    columnRuleWidth: 1,
    columnWidth: 1,
    containIntrinsicSize: 1,
    flexBasis: 1,
    fontSize: 1,
    gap: 1,
    gridAutoColumns: 1,
    gridAutoRows: 1,
    gridTemplateColumns: 1,
    gridTemplateRows: 1,
    height: 1,
    inlineSize: 1,
    inset: 1,
    insetBlock: 1,
    insetBlockEnd: 1,
    insetBlockStart: 1,
    insetInline: 1,
    insetInlineEnd: 1,
    insetInlineStart: 1,
    left: 1,
    letterSpacing: 1,
    margin: 1,
    marginBlock: 1,
    marginBlockEnd: 1,
    marginBlockStart: 1,
    marginBottom: 1,
    marginInline: 1,
    marginInlineEnd: 1,
    marginInlineStart: 1,
    marginLeft: 1,
    marginRight: 1,
    marginTop: 1,
    maxBlockSize: 1,
    maxHeight: 1,
    maxInlineSize: 1,
    maxWidth: 1,
    minBlockSize: 1,
    minHeight: 1,
    minInlineSize: 1,
    minWidth: 1,
    offsetDistance: 1,
    offsetRotate: 1,
    outline: 1,
    outlineOffset: 1,
    outlineWidth: 1,
    overflowClipMargin: 1,
    padding: 1,
    paddingBlock: 1,
    paddingBlockEnd: 1,
    paddingBlockStart: 1,
    paddingBottom: 1,
    paddingInline: 1,
    paddingInlineEnd: 1,
    paddingInlineStart: 1,
    paddingLeft: 1,
    paddingRight: 1,
    paddingTop: 1,
    perspective: 1,
    right: 1,
    rowGap: 1,
    scrollMargin: 1,
    scrollMarginBlock: 1,
    scrollMarginBlockEnd: 1,
    scrollMarginBlockStart: 1,
    scrollMarginBottom: 1,
    scrollMarginInline: 1,
    scrollMarginInlineEnd: 1,
    scrollMarginInlineStart: 1,
    scrollMarginLeft: 1,
    scrollMarginRight: 1,
    scrollMarginTop: 1,
    scrollPadding: 1,
    scrollPaddingBlock: 1,
    scrollPaddingBlockEnd: 1,
    scrollPaddingBlockStart: 1,
    scrollPaddingBottom: 1,
    scrollPaddingInline: 1,
    scrollPaddingInlineEnd: 1,
    scrollPaddingInlineStart: 1,
    scrollPaddingLeft: 1,
    scrollPaddingRight: 1,
    scrollPaddingTop: 1,
    shapeMargin: 1,
    textDecoration: 1,
    textDecorationThickness: 1,
    textIndent: 1,
    textUnderlineOffset: 1,
    top: 1,
    transitionDelay: 1,
    transitionDuration: 1,
    verticalAlign: 1,
    width: 1,
    wordSpacing: 1,
  },
  bc = (e) => String.fromCharCode(e + (e > 25 ? 39 : 97)),
  Kt = (e) =>
    ((t) => {
      let n,
        r = "";
      for (n = Math.abs(t); n > 52; n = (n / 52) | 0) r = bc(n % 52) + r;
      return bc(n % 52) + r;
    })(
      ((t, n) => {
        let r = n.length;
        for (; r; ) t = (33 * t) ^ n.charCodeAt(--r);
        return t;
      })(5381, JSON.stringify(e)) >>> 0
    ),
  ar = [
    "themed",
    "global",
    "styled",
    "onevar",
    "resonevar",
    "allvar",
    "inline",
  ],
  Py = (e) => {
    if (e.href && !e.href.startsWith(location.origin)) return !1;
    try {
      return !!e.cssRules;
    } catch {
      return !1;
    }
  },
  Iy = (e) => {
    let t;
    const n = () => {
        const { cssRules: o } = t.sheet;
        return [].map
          .call(o, (i, l) => {
            const { cssText: s } = i;
            let u = "";
            if (s.startsWith("--sxs")) return "";
            if (o[l - 1] && (u = o[l - 1].cssText).startsWith("--sxs")) {
              if (!i.cssRules.length) return "";
              for (const a in t.rules)
                if (t.rules[a].group === i)
                  return `--sxs{--sxs:${[...t.rules[a].cache].join(" ")}}${s}`;
              return i.cssRules.length ? `${u}${s}` : "";
            }
            return s;
          })
          .join("");
      },
      r = () => {
        if (t) {
          const { rules: s, sheet: u } = t;
          if (!u.deleteRule) {
            for (; Object(Object(u.cssRules)[0]).type === 3; )
              u.cssRules.splice(0, 1);
            u.cssRules = [];
          }
          for (const a in s) delete s[a];
        }
        const o = Object(e).styleSheets || [];
        for (const s of o)
          if (Py(s)) {
            for (let u = 0, a = s.cssRules; a[u]; ++u) {
              const c = Object(a[u]);
              if (c.type !== 1) continue;
              const f = Object(a[u + 1]);
              if (f.type !== 4) continue;
              ++u;
              const { cssText: p } = c;
              if (!p.startsWith("--sxs")) continue;
              const y = p.slice(14, -3).trim().split(/\s+/),
                S = ar[y[0]];
              S &&
                (t || (t = { sheet: s, reset: r, rules: {}, toString: n }),
                (t.rules[S] = { group: f, index: u, cache: new Set(y) }));
            }
            if (t) break;
          }
        if (!t) {
          const s = (u, a) => ({
            type: a,
            cssRules: [],
            insertRule(c, f) {
              this.cssRules.splice(
                f,
                0,
                s(
                  c,
                  { import: 3, undefined: 1 }[
                    (c.toLowerCase().match(/^@([a-z]+)/) || [])[1]
                  ] || 4
                )
              );
            },
            get cssText() {
              return u === "@media{}"
                ? `@media{${[].map
                    .call(this.cssRules, (c) => c.cssText)
                    .join("")}}`
                : u;
            },
          });
          t = {
            sheet: e
              ? (e.head || e).appendChild(document.createElement("style")).sheet
              : s("", "text/css"),
            rules: {},
            reset: r,
            toString: n,
          };
        }
        const { sheet: i, rules: l } = t;
        for (let s = ar.length - 1; s >= 0; --s) {
          const u = ar[s];
          if (!l[u]) {
            const a = ar[s + 1],
              c = l[a] ? l[a].index : i.cssRules.length;
            i.insertRule("@media{}", c),
              i.insertRule(`--sxs{--sxs:${s}}`, c),
              (l[u] = {
                group: i.cssRules[c + 1],
                index: c,
                cache: new Set([s]),
              });
          }
          Dy(l[u]);
        }
      };
    return r(), t;
  },
  Dy = (e) => {
    const t = e.group;
    let n = t.cssRules.length;
    e.apply = (r) => {
      try {
        t.insertRule(r, n), ++n;
      } catch {}
    };
  },
  nr = Symbol(),
  $y = Qn(),
  Mc = (e, t) =>
    $y(e, () => (...n) => {
      let r = { type: null, composers: new Set() };
      for (const o of n)
        if (o != null)
          if (o[Gt]) {
            r.type == null && (r.type = o[Gt].type);
            for (const i of o[Gt].composers) r.composers.add(i);
          } else
            o.constructor !== Object || o.$$typeof
              ? r.type == null && (r.type = o)
              : r.composers.add(Ry(o, e));
      return (
        r.type == null && (r.type = "span"),
        r.composers.size || r.composers.add(["PJLV", {}, [], [], {}, []]),
        _y(e, r, t)
      );
    }),
  Ry = ({ variants: e, compoundVariants: t, defaultVariants: n, ...r }, o) => {
    const i = `${ct(o.prefix)}c-${Kt(r)}`,
      l = [],
      s = [],
      u = Object.create(null),
      a = [];
    for (const p in n) u[p] = String(n[p]);
    if (typeof e == "object" && e)
      for (const p in e) {
        (c = u), (f = p), Sy.call(c, f) || (u[p] = "undefined");
        const y = e[p];
        for (const S in y) {
          const m = { [p]: String(S) };
          String(S) === "undefined" && a.push(p);
          const C = y[S],
            h = [m, C, !Rc(C)];
          l.push(h);
        }
      }
    var c, f;
    if (typeof t == "object" && t)
      for (const p of t) {
        let { css: y, ...S } = p;
        y = (typeof y == "object" && y) || {};
        for (const C in S) S[C] = String(S[C]);
        const m = [S, y, !Rc(y)];
        s.push(m);
      }
    return [i, r, l, s, u, a];
  },
  _y = (e, t, n) => {
    const [r, o, i, l] = Ny(t.composers),
      s =
        typeof t.type == "function" || t.type.$$typeof
          ? ((f) => {
              function p() {
                for (let y = 0; y < p[nr].length; y++) {
                  const [S, m] = p[nr][y];
                  f.rules[S].apply(m);
                }
                return (p[nr] = []), null;
              }
              return (
                (p[nr] = []),
                (p.rules = {}),
                ar.forEach(
                  (y) => (p.rules[y] = { apply: (S) => p[nr].push([y, S]) })
                ),
                p
              );
            })(n)
          : null,
      u = (s || n).rules,
      a = `.${r}${o.length > 1 ? `:where(.${o.slice(1).join(".")})` : ""}`,
      c = (f) => {
        f = (typeof f == "object" && f) || by;
        const { css: p, ...y } = f,
          S = {};
        for (const h in i)
          if ((delete y[h], h in f)) {
            let d = f[h];
            typeof d == "object" && d
              ? (S[h] = { "@initial": i[h], ...d })
              : ((d = String(d)),
                (S[h] = d !== "undefined" || l.has(h) ? d : i[h]));
          } else S[h] = i[h];
        const m = new Set([...o]);
        for (const [h, d, v, w] of t.composers) {
          n.rules.styled.cache.has(h) ||
            (n.rules.styled.cache.add(h),
            In(d, [`.${h}`], [], e, (k) => {
              u.styled.apply(k);
            }));
          const E = Lc(v, S, e.media),
            x = Lc(w, S, e.media, !0);
          for (const k of E)
            if (k !== void 0)
              for (const [O, _, R] of k) {
                const z = `${h}-${Kt(_)}-${O}`;
                m.add(z);
                const q = (R ? n.rules.resonevar : n.rules.onevar).cache,
                  ae = R ? u.resonevar : u.onevar;
                q.has(z) ||
                  (q.add(z),
                  In(_, [`.${z}`], [], e, (bt) => {
                    ae.apply(bt);
                  }));
              }
          for (const k of x)
            if (k !== void 0)
              for (const [O, _] of k) {
                const R = `${h}-${Kt(_)}-${O}`;
                m.add(R),
                  n.rules.allvar.cache.has(R) ||
                    (n.rules.allvar.cache.add(R),
                    In(_, [`.${R}`], [], e, (z) => {
                      u.allvar.apply(z);
                    }));
              }
        }
        if (typeof p == "object" && p) {
          const h = `${r}-i${Kt(p)}-css`;
          m.add(h),
            n.rules.inline.cache.has(h) ||
              (n.rules.inline.cache.add(h),
              In(p, [`.${h}`], [], e, (d) => {
                u.inline.apply(d);
              }));
        }
        for (const h of String(f.className || "")
          .trim()
          .split(/\s+/))
          h && m.add(h);
        const C = (y.className = [...m].join(" "));
        return {
          type: t.type,
          className: C,
          selector: a,
          props: y,
          toString: () => C,
          deferredInjector: s,
        };
      };
    return Xu(c, {
      className: r,
      selector: a,
      [Gt]: t,
      toString: () => (n.rules.styled.cache.has(r) || c(), r),
    });
  },
  Ny = (e) => {
    let t = "";
    const n = [],
      r = {},
      o = [];
    for (const [i, , , , l, s] of e) {
      t === "" && (t = i), n.push(i), o.push(...s);
      for (const u in l) {
        const a = l[u];
        (r[u] === void 0 || a !== "undefined" || s.includes(a)) && (r[u] = a);
      }
    }
    return [t, n, r, new Set(o)];
  },
  Lc = (e, t, n, r) => {
    const o = [];
    e: for (let [i, l, s] of e) {
      if (s) continue;
      let u,
        a = 0,
        c = !1;
      for (u in i) {
        const f = i[u];
        let p = t[u];
        if (p !== f) {
          if (typeof p != "object" || !p) continue e;
          {
            let y,
              S,
              m = 0;
            for (const C in p) {
              if (f === String(p[C])) {
                if (C !== "@initial") {
                  const h = C.slice(1);
                  (S = S || []).push(
                    h in n ? n[h] : C.replace(/^@media ?/, "")
                  ),
                    (c = !0);
                }
                (a += m), (y = !0);
              }
              ++m;
            }
            if ((S && S.length && (l = { ["@media " + S.join(", ")]: l }), !y))
              continue e;
          }
        }
      }
      (o[a] = o[a] || []).push([r ? "cv" : `${u}-${i[u]}`, l, c]);
    }
    return o;
  },
  by = {},
  My = Qn(),
  Ly = (e, t) =>
    My(e, () => (...n) => {
      const r = () => {
        for (let o of n) {
          o = (typeof o == "object" && o) || {};
          let i = Kt(o);
          if (!t.rules.global.cache.has(i)) {
            if ((t.rules.global.cache.add(i), "@import" in o)) {
              let l =
                [].indexOf.call(t.sheet.cssRules, t.rules.themed.group) - 1;
              for (let s of [].concat(o["@import"]))
                (s = s.includes('"') || s.includes("'") ? s : `"${s}"`),
                  t.sheet.insertRule(`@import ${s};`, l++);
              delete o["@import"];
            }
            In(o, [], [], e, (l) => {
              t.rules.global.apply(l);
            });
          }
        }
        return "";
      };
      return Xu(r, { toString: r });
    }),
  Fy = Qn(),
  zy = (e, t) =>
    Fy(e, () => (n) => {
      const r = `${ct(e.prefix)}k-${Kt(n)}`,
        o = () => {
          if (!t.rules.global.cache.has(r)) {
            t.rules.global.cache.add(r);
            const i = [];
            In(n, [], [], e, (s) => i.push(s));
            const l = `@keyframes ${r}{${i.join("")}}`;
            t.rules.global.apply(l);
          }
          return r;
        };
      return Xu(o, {
        get name() {
          return o();
        },
        toString: o,
      });
    }),
  jy = class {
    constructor(e, t, n, r) {
      (this.token = e == null ? "" : String(e)),
        (this.value = t == null ? "" : String(t)),
        (this.scale = n == null ? "" : String(n)),
        (this.prefix = r == null ? "" : String(r));
    }
    get computedValue() {
      return "var(" + this.variable + ")";
    }
    get variable() {
      return "--" + ct(this.prefix) + ct(this.scale) + this.token;
    }
    toString() {
      return this.computedValue;
    }
  },
  Ay = Qn(),
  By = (e, t) =>
    Ay(e, () => (n, r) => {
      r = (typeof n == "object" && n) || Object(r);
      const o = `.${(n =
          (n = typeof n == "string" ? n : "") || `${ct(e.prefix)}t-${Kt(r)}`)}`,
        i = {},
        l = [];
      for (const u in r) {
        i[u] = {};
        for (const a in r[u]) {
          const c = `--${ct(e.prefix)}${u}-${a}`,
            f = Vp(String(r[u][a]), e.prefix, u);
          (i[u][a] = new jy(a, f, u, e.prefix)), l.push(`${c}:${f}`);
        }
      }
      const s = () => {
        if (l.length && !t.rules.themed.cache.has(n)) {
          t.rules.themed.cache.add(n);
          const u = `${r === e.theme ? ":root," : ""}.${n}{${l.join(";")}}`;
          t.rules.themed.apply(u);
        }
        return n;
      };
      return {
        ...i,
        get className() {
          return s();
        },
        selector: o,
        toString: s,
      };
    }),
  Uy = Qn(),
  Fc,
  Wy = Qn(),
  Qp = (e) => {
    const t = ((n) => {
      let r = !1;
      const o = Uy(n, (i) => {
        r = !0;
        const l =
            "prefix" in (i = (typeof i == "object" && i) || {})
              ? String(i.prefix)
              : "",
          s = (typeof i.media == "object" && i.media) || {},
          u =
            typeof i.root == "object"
              ? i.root || null
              : globalThis.document || null,
          a = (typeof i.theme == "object" && i.theme) || {},
          c = {
            prefix: l,
            media: s,
            theme: a,
            themeMap: (typeof i.themeMap == "object" && i.themeMap) || {
              ...vy,
            },
            utils: (typeof i.utils == "object" && i.utils) || {},
          },
          f = Iy(u),
          p = {
            css: Mc(c, f),
            globalCss: Ly(c, f),
            keyframes: zy(c, f),
            createTheme: By(c, f),
            reset() {
              f.reset(), p.theme.toString();
            },
            theme: {},
            sheet: f,
            config: c,
            prefix: l,
            getCssText: f.toString,
            toString: f.toString,
          };
        return String((p.theme = p.createTheme(a))), p;
      });
      return r || o.reset(), o;
    })(e);
    return (
      (t.styled = (({ config: n, sheet: r }) =>
        Wy(n, () => {
          const o = Mc(n, r);
          return (...i) => {
            const l = o(...i),
              s = l[Gt].type,
              u = me.forwardRef((a, c) => {
                const f = (a && a.as) || s,
                  { props: p, deferredInjector: y } = l(a);
                return (
                  delete p.as,
                  (p.ref = c),
                  y
                    ? me.createElement(
                        me.Fragment,
                        null,
                        me.createElement(f, p),
                        me.createElement(y, null)
                      )
                    : me.createElement(f, p)
                );
              });
            return (
              (u.className = l.className),
              (u.displayName = `Styled.${s.displayName || s.name || s}`),
              (u.selector = l.selector),
              (u.toString = () => l.selector),
              (u[Gt] = l[Gt]),
              u
            );
          };
        }))(t)),
      t
    );
  },
  Zu = () => Fc || (Fc = Qp()),
  Gp = (...e) => Zu().keyframes(...e),
  Xr = (...e) => Zu().css(...e),
  qu = (...e) => Zu().styled(...e);
const { styled: _e, globalCss: Hy } = Qp({
    theme: {
      colors: {
        darkblue: "#101015",
        purple: "#5763d0",
        graywhite: "#FFFFFF05",
      },
    },
  }),
  Vy = Hy({
    "*": {
      margin: 0,
      padding: 0,
      fontFamily: "DM Sans",
      boxSizing: "border-box",
    },
    a: { textDecoration: "none" },
    body: {
      userSelect: "none",
      overflow: "hidden",
      color: "#ffffff",
      "-webkit-font-smoothing": "antialiased",
    },
    "html, body": { overflow: "hidden" },
  }),
  Kp = g.exports.createContext({ dragDropManager: void 0 });
function Ne(e) {
  return (
    "Minified Redux error #" +
    e +
    "; visit https://redux.js.org/Errors?code=" +
    e +
    " for the full message or use the non-minified dev environment for full errors. "
  );
}
var zc = (function () {
    return (typeof Symbol == "function" && Symbol.observable) || "@@observable";
  })(),
  yl = function () {
    return Math.random().toString(36).substring(7).split("").join(".");
  },
  jc = {
    INIT: "@@redux/INIT" + yl(),
    REPLACE: "@@redux/REPLACE" + yl(),
    PROBE_UNKNOWN_ACTION: function () {
      return "@@redux/PROBE_UNKNOWN_ACTION" + yl();
    },
  };
function Qy(e) {
  if (typeof e != "object" || e === null) return !1;
  for (var t = e; Object.getPrototypeOf(t) !== null; )
    t = Object.getPrototypeOf(t);
  return Object.getPrototypeOf(e) === t;
}
function Yp(e, t, n) {
  var r;
  if (
    (typeof t == "function" && typeof n == "function") ||
    (typeof n == "function" && typeof arguments[3] == "function")
  )
    throw new Error(Ne(0));
  if (
    (typeof t == "function" &&
      typeof n == "undefined" &&
      ((n = t), (t = void 0)),
    typeof n != "undefined")
  ) {
    if (typeof n != "function") throw new Error(Ne(1));
    return n(Yp)(e, t);
  }
  if (typeof e != "function") throw new Error(Ne(2));
  var o = e,
    i = t,
    l = [],
    s = l,
    u = !1;
  function a() {
    s === l && (s = l.slice());
  }
  function c() {
    if (u) throw new Error(Ne(3));
    return i;
  }
  function f(m) {
    if (typeof m != "function") throw new Error(Ne(4));
    if (u) throw new Error(Ne(5));
    var C = !0;
    return (
      a(),
      s.push(m),
      function () {
        if (!!C) {
          if (u) throw new Error(Ne(6));
          (C = !1), a();
          var d = s.indexOf(m);
          s.splice(d, 1), (l = null);
        }
      }
    );
  }
  function p(m) {
    if (!Qy(m)) throw new Error(Ne(7));
    if (typeof m.type == "undefined") throw new Error(Ne(8));
    if (u) throw new Error(Ne(9));
    try {
      (u = !0), (i = o(i, m));
    } finally {
      u = !1;
    }
    for (var C = (l = s), h = 0; h < C.length; h++) {
      var d = C[h];
      d();
    }
    return m;
  }
  function y(m) {
    if (typeof m != "function") throw new Error(Ne(10));
    (o = m), p({ type: jc.REPLACE });
  }
  function S() {
    var m,
      C = f;
    return (
      (m = {
        subscribe: function (d) {
          if (typeof d != "object" || d === null) throw new Error(Ne(11));
          function v() {
            d.next && d.next(c());
          }
          v();
          var w = C(v);
          return { unsubscribe: w };
        },
      }),
      (m[zc] = function () {
        return this;
      }),
      m
    );
  }
  return (
    p({ type: jc.INIT }),
    (r = { dispatch: p, subscribe: f, getState: c, replaceReducer: y }),
    (r[zc] = S),
    r
  );
}
function N(e, t, ...n) {
  if (Gy() && t === void 0)
    throw new Error("invariant requires an error message argument");
  if (!e) {
    let r;
    if (t === void 0)
      r = new Error(
        "Minified exception occurred; use the non-minified dev environment for the full error message and additional helpful warnings."
      );
    else {
      let o = 0;
      (r = new Error(
        t.replace(/%s/g, function () {
          return n[o++];
        })
      )),
        (r.name = "Invariant Violation");
    }
    throw ((r.framesToPop = 1), r);
  }
}
function Gy() {
  return typeof process != "undefined" && process.env.NODE_ENV === "production";
}
function Ky(e, t, n) {
  return t.split(".").reduce((r, o) => (r && r[o] ? r[o] : n || null), e);
}
function Yy(e, t) {
  return e.filter((n) => n !== t);
}
function Xp(e) {
  return typeof e == "object";
}
function Xy(e, t) {
  const n = new Map(),
    r = (i) => {
      n.set(i, n.has(i) ? n.get(i) + 1 : 1);
    };
  e.forEach(r), t.forEach(r);
  const o = [];
  return (
    n.forEach((i, l) => {
      i === 1 && o.push(l);
    }),
    o
  );
}
function Zy(e, t) {
  return e.filter((n) => t.indexOf(n) > -1);
}
const Ju = "dnd-core/INIT_COORDS",
  bi = "dnd-core/BEGIN_DRAG",
  ea = "dnd-core/PUBLISH_DRAG_SOURCE",
  Mi = "dnd-core/HOVER",
  Li = "dnd-core/DROP",
  Fi = "dnd-core/END_DRAG";
function Ac(e, t) {
  return {
    type: Ju,
    payload: { sourceClientOffset: t || null, clientOffset: e || null },
  };
}
const qy = {
  type: Ju,
  payload: { clientOffset: null, sourceClientOffset: null },
};
function Jy(e) {
  return function (n = [], r = { publishSource: !0 }) {
    const {
        publishSource: o = !0,
        clientOffset: i,
        getSourceClientOffset: l,
      } = r,
      s = e.getMonitor(),
      u = e.getRegistry();
    e.dispatch(Ac(i)), e0(n, s, u);
    const a = r0(n, s);
    if (a == null) {
      e.dispatch(qy);
      return;
    }
    let c = null;
    if (i) {
      if (!l) throw new Error("getSourceClientOffset must be defined");
      t0(l), (c = l(a));
    }
    e.dispatch(Ac(i, c));
    const p = u.getSource(a).beginDrag(s, a);
    if (p == null) return;
    n0(p), u.pinSource(a);
    const y = u.getSourceType(a);
    return {
      type: bi,
      payload: {
        itemType: y,
        item: p,
        sourceId: a,
        clientOffset: i || null,
        sourceClientOffset: c || null,
        isSourcePublic: !!o,
      },
    };
  };
}
function e0(e, t, n) {
  N(!t.isDragging(), "Cannot call beginDrag while dragging."),
    e.forEach(function (r) {
      N(n.getSource(r), "Expected sourceIds to be registered.");
    });
}
function t0(e) {
  N(
    typeof e == "function",
    "When clientOffset is provided, getSourceClientOffset must be a function."
  );
}
function n0(e) {
  N(Xp(e), "Item must be an object.");
}
function r0(e, t) {
  let n = null;
  for (let r = e.length - 1; r >= 0; r--)
    if (t.canDragSource(e[r])) {
      n = e[r];
      break;
    }
  return n;
}
function o0(e, t, n) {
  return (
    t in e
      ? Object.defineProperty(e, t, {
          value: n,
          enumerable: !0,
          configurable: !0,
          writable: !0,
        })
      : (e[t] = n),
    e
  );
}
function i0(e) {
  for (var t = 1; t < arguments.length; t++) {
    var n = arguments[t] != null ? arguments[t] : {},
      r = Object.keys(n);
    typeof Object.getOwnPropertySymbols == "function" &&
      (r = r.concat(
        Object.getOwnPropertySymbols(n).filter(function (o) {
          return Object.getOwnPropertyDescriptor(n, o).enumerable;
        })
      )),
      r.forEach(function (o) {
        o0(e, o, n[o]);
      });
  }
  return e;
}
function l0(e) {
  return function (n = {}) {
    const r = e.getMonitor(),
      o = e.getRegistry();
    s0(r),
      c0(r).forEach((l, s) => {
        const u = u0(l, s, o, r),
          a = { type: Li, payload: { dropResult: i0({}, n, u) } };
        e.dispatch(a);
      });
  };
}
function s0(e) {
  N(e.isDragging(), "Cannot call drop while not dragging."),
    N(!e.didDrop(), "Cannot call drop twice during one drag operation.");
}
function u0(e, t, n, r) {
  const o = n.getTarget(e);
  let i = o ? o.drop(r, e) : void 0;
  return (
    a0(i), typeof i == "undefined" && (i = t === 0 ? {} : r.getDropResult()), i
  );
}
function a0(e) {
  N(
    typeof e == "undefined" || Xp(e),
    "Drop result must either be an object or undefined."
  );
}
function c0(e) {
  const t = e.getTargetIds().filter(e.canDropOnTarget, e);
  return t.reverse(), t;
}
function d0(e) {
  return function () {
    const n = e.getMonitor(),
      r = e.getRegistry();
    f0(n);
    const o = n.getSourceId();
    return (
      o != null && (r.getSource(o, !0).endDrag(n, o), r.unpinSource()),
      { type: Fi }
    );
  };
}
function f0(e) {
  N(e.isDragging(), "Cannot call endDrag while not dragging.");
}
function Ns(e, t) {
  return t === null
    ? e === null
    : Array.isArray(e)
    ? e.some((n) => n === t)
    : e === t;
}
function p0(e) {
  return function (n, { clientOffset: r } = {}) {
    h0(n);
    const o = n.slice(0),
      i = e.getMonitor(),
      l = e.getRegistry(),
      s = i.getItemType();
    return (
      m0(o, l, s),
      g0(o, i, l),
      v0(o, i, l),
      { type: Mi, payload: { targetIds: o, clientOffset: r || null } }
    );
  };
}
function h0(e) {
  N(Array.isArray(e), "Expected targetIds to be an array.");
}
function g0(e, t, n) {
  N(t.isDragging(), "Cannot call hover while not dragging."),
    N(!t.didDrop(), "Cannot call hover after drop.");
  for (let r = 0; r < e.length; r++) {
    const o = e[r];
    N(
      e.lastIndexOf(o) === r,
      "Expected targetIds to be unique in the passed array."
    );
    const i = n.getTarget(o);
    N(i, "Expected targetIds to be registered.");
  }
}
function m0(e, t, n) {
  for (let r = e.length - 1; r >= 0; r--) {
    const o = e[r],
      i = t.getTargetType(o);
    Ns(i, n) || e.splice(r, 1);
  }
}
function v0(e, t, n) {
  e.forEach(function (r) {
    n.getTarget(r).hover(t, r);
  });
}
function y0(e) {
  return function () {
    if (e.getMonitor().isDragging()) return { type: ea };
  };
}
function S0(e) {
  return {
    beginDrag: Jy(e),
    publishDragSource: y0(e),
    hover: p0(e),
    drop: l0(e),
    endDrag: d0(e),
  };
}
class w0 {
  receiveBackend(t) {
    this.backend = t;
  }
  getMonitor() {
    return this.monitor;
  }
  getBackend() {
    return this.backend;
  }
  getRegistry() {
    return this.monitor.registry;
  }
  getActions() {
    const t = this,
      { dispatch: n } = this.store;
    function r(i) {
      return (...l) => {
        const s = i.apply(t, l);
        typeof s != "undefined" && n(s);
      };
    }
    const o = S0(this);
    return Object.keys(o).reduce((i, l) => {
      const s = o[l];
      return (i[l] = r(s)), i;
    }, {});
  }
  dispatch(t) {
    this.store.dispatch(t);
  }
  constructor(t, n) {
    (this.isSetUp = !1),
      (this.handleRefCountChange = () => {
        const r = this.store.getState().refCount > 0;
        this.backend &&
          (r && !this.isSetUp
            ? (this.backend.setup(), (this.isSetUp = !0))
            : !r &&
              this.isSetUp &&
              (this.backend.teardown(), (this.isSetUp = !1)));
      }),
      (this.store = t),
      (this.monitor = n),
      t.subscribe(this.handleRefCountChange);
  }
}
function x0(e, t) {
  return { x: e.x + t.x, y: e.y + t.y };
}
function Zp(e, t) {
  return { x: e.x - t.x, y: e.y - t.y };
}
function E0(e) {
  const {
    clientOffset: t,
    initialClientOffset: n,
    initialSourceClientOffset: r,
  } = e;
  return !t || !n || !r ? null : Zp(x0(t, r), n);
}
function C0(e) {
  const { clientOffset: t, initialClientOffset: n } = e;
  return !t || !n ? null : Zp(t, n);
}
const Sr = [],
  ta = [];
Sr.__IS_NONE__ = !0;
ta.__IS_ALL__ = !0;
function k0(e, t) {
  return e === Sr
    ? !1
    : e === ta || typeof t == "undefined"
    ? !0
    : Zy(t, e).length > 0;
}
class O0 {
  subscribeToStateChange(t, n = {}) {
    const { handlerIds: r } = n;
    N(typeof t == "function", "listener must be a function."),
      N(
        typeof r == "undefined" || Array.isArray(r),
        "handlerIds, when specified, must be an array of strings."
      );
    let o = this.store.getState().stateId;
    const i = () => {
      const l = this.store.getState(),
        s = l.stateId;
      try {
        s === o || (s === o + 1 && !k0(l.dirtyHandlerIds, r)) || t();
      } finally {
        o = s;
      }
    };
    return this.store.subscribe(i);
  }
  subscribeToOffsetChange(t) {
    N(typeof t == "function", "listener must be a function.");
    let n = this.store.getState().dragOffset;
    const r = () => {
      const o = this.store.getState().dragOffset;
      o !== n && ((n = o), t());
    };
    return this.store.subscribe(r);
  }
  canDragSource(t) {
    if (!t) return !1;
    const n = this.registry.getSource(t);
    return (
      N(n, `Expected to find a valid source. sourceId=${t}`),
      this.isDragging() ? !1 : n.canDrag(this, t)
    );
  }
  canDropOnTarget(t) {
    if (!t) return !1;
    const n = this.registry.getTarget(t);
    if (
      (N(n, `Expected to find a valid target. targetId=${t}`),
      !this.isDragging() || this.didDrop())
    )
      return !1;
    const r = this.registry.getTargetType(t),
      o = this.getItemType();
    return Ns(r, o) && n.canDrop(this, t);
  }
  isDragging() {
    return Boolean(this.getItemType());
  }
  isDraggingSource(t) {
    if (!t) return !1;
    const n = this.registry.getSource(t, !0);
    if (
      (N(n, `Expected to find a valid source. sourceId=${t}`),
      !this.isDragging() || !this.isSourcePublic())
    )
      return !1;
    const r = this.registry.getSourceType(t),
      o = this.getItemType();
    return r !== o ? !1 : n.isDragging(this, t);
  }
  isOverTarget(t, n = { shallow: !1 }) {
    if (!t) return !1;
    const { shallow: r } = n;
    if (!this.isDragging()) return !1;
    const o = this.registry.getTargetType(t),
      i = this.getItemType();
    if (i && !Ns(o, i)) return !1;
    const l = this.getTargetIds();
    if (!l.length) return !1;
    const s = l.indexOf(t);
    return r ? s === l.length - 1 : s > -1;
  }
  getItemType() {
    return this.store.getState().dragOperation.itemType;
  }
  getItem() {
    return this.store.getState().dragOperation.item;
  }
  getSourceId() {
    return this.store.getState().dragOperation.sourceId;
  }
  getTargetIds() {
    return this.store.getState().dragOperation.targetIds;
  }
  getDropResult() {
    return this.store.getState().dragOperation.dropResult;
  }
  didDrop() {
    return this.store.getState().dragOperation.didDrop;
  }
  isSourcePublic() {
    return Boolean(this.store.getState().dragOperation.isSourcePublic);
  }
  getInitialClientOffset() {
    return this.store.getState().dragOffset.initialClientOffset;
  }
  getInitialSourceClientOffset() {
    return this.store.getState().dragOffset.initialSourceClientOffset;
  }
  getClientOffset() {
    return this.store.getState().dragOffset.clientOffset;
  }
  getSourceClientOffset() {
    return E0(this.store.getState().dragOffset);
  }
  getDifferenceFromInitialOffset() {
    return C0(this.store.getState().dragOffset);
  }
  constructor(t, n) {
    (this.store = t), (this.registry = n);
  }
}
const Bc = typeof global != "undefined" ? global : self,
  qp = Bc.MutationObserver || Bc.WebKitMutationObserver;
function Jp(e) {
  return function () {
    const n = setTimeout(o, 0),
      r = setInterval(o, 50);
    function o() {
      clearTimeout(n), clearInterval(r), e();
    }
  };
}
function T0(e) {
  let t = 1;
  const n = new qp(e),
    r = document.createTextNode("");
  return (
    n.observe(r, { characterData: !0 }),
    function () {
      (t = -t), (r.data = t);
    }
  );
}
const P0 = typeof qp == "function" ? T0 : Jp;
class I0 {
  enqueueTask(t) {
    const { queue: n, requestFlush: r } = this;
    n.length || (r(), (this.flushing = !0)), (n[n.length] = t);
  }
  constructor() {
    (this.queue = []),
      (this.pendingErrors = []),
      (this.flushing = !1),
      (this.index = 0),
      (this.capacity = 1024),
      (this.flush = () => {
        const { queue: t } = this;
        for (; this.index < t.length; ) {
          const n = this.index;
          if ((this.index++, t[n].call(), this.index > this.capacity)) {
            for (let r = 0, o = t.length - this.index; r < o; r++)
              t[r] = t[r + this.index];
            (t.length -= this.index), (this.index = 0);
          }
        }
        (t.length = 0), (this.index = 0), (this.flushing = !1);
      }),
      (this.registerPendingError = (t) => {
        this.pendingErrors.push(t), this.requestErrorThrow();
      }),
      (this.requestFlush = P0(this.flush)),
      (this.requestErrorThrow = Jp(() => {
        if (this.pendingErrors.length) throw this.pendingErrors.shift();
      }));
  }
}
class D0 {
  call() {
    try {
      this.task && this.task();
    } catch (t) {
      this.onError(t);
    } finally {
      (this.task = null), this.release(this);
    }
  }
  constructor(t, n) {
    (this.onError = t), (this.release = n), (this.task = null);
  }
}
class $0 {
  create(t) {
    const n = this.freeTasks,
      r = n.length ? n.pop() : new D0(this.onError, (o) => (n[n.length] = o));
    return (r.task = t), r;
  }
  constructor(t) {
    (this.onError = t), (this.freeTasks = []);
  }
}
const eh = new I0(),
  R0 = new $0(eh.registerPendingError);
function _0(e) {
  eh.enqueueTask(R0.create(e));
}
const na = "dnd-core/ADD_SOURCE",
  ra = "dnd-core/ADD_TARGET",
  oa = "dnd-core/REMOVE_SOURCE",
  zi = "dnd-core/REMOVE_TARGET";
function N0(e) {
  return { type: na, payload: { sourceId: e } };
}
function b0(e) {
  return { type: ra, payload: { targetId: e } };
}
function M0(e) {
  return { type: oa, payload: { sourceId: e } };
}
function L0(e) {
  return { type: zi, payload: { targetId: e } };
}
function F0(e) {
  N(typeof e.canDrag == "function", "Expected canDrag to be a function."),
    N(typeof e.beginDrag == "function", "Expected beginDrag to be a function."),
    N(typeof e.endDrag == "function", "Expected endDrag to be a function.");
}
function z0(e) {
  N(typeof e.canDrop == "function", "Expected canDrop to be a function."),
    N(typeof e.hover == "function", "Expected hover to be a function."),
    N(typeof e.drop == "function", "Expected beginDrag to be a function.");
}
function bs(e, t) {
  if (t && Array.isArray(e)) {
    e.forEach((n) => bs(n, !1));
    return;
  }
  N(
    typeof e == "string" || typeof e == "symbol",
    t
      ? "Type can only be a string, a symbol, or an array of either."
      : "Type can only be a string or a symbol."
  );
}
var Le;
(function (e) {
  (e.SOURCE = "SOURCE"), (e.TARGET = "TARGET");
})(Le || (Le = {}));
let j0 = 0;
function A0() {
  return j0++;
}
function B0(e) {
  const t = A0().toString();
  switch (e) {
    case Le.SOURCE:
      return `S${t}`;
    case Le.TARGET:
      return `T${t}`;
    default:
      throw new Error(`Unknown Handler Role: ${e}`);
  }
}
function Uc(e) {
  switch (e[0]) {
    case "S":
      return Le.SOURCE;
    case "T":
      return Le.TARGET;
    default:
      throw new Error(`Cannot parse handler ID: ${e}`);
  }
}
function Wc(e, t) {
  const n = e.entries();
  let r = !1;
  do {
    const {
      done: o,
      value: [, i],
    } = n.next();
    if (i === t) return !0;
    r = !!o;
  } while (!r);
  return !1;
}
class U0 {
  addSource(t, n) {
    bs(t), F0(n);
    const r = this.addHandler(Le.SOURCE, t, n);
    return this.store.dispatch(N0(r)), r;
  }
  addTarget(t, n) {
    bs(t, !0), z0(n);
    const r = this.addHandler(Le.TARGET, t, n);
    return this.store.dispatch(b0(r)), r;
  }
  containsHandler(t) {
    return Wc(this.dragSources, t) || Wc(this.dropTargets, t);
  }
  getSource(t, n = !1) {
    return (
      N(this.isSourceId(t), "Expected a valid source ID."),
      n && t === this.pinnedSourceId
        ? this.pinnedSource
        : this.dragSources.get(t)
    );
  }
  getTarget(t) {
    return (
      N(this.isTargetId(t), "Expected a valid target ID."),
      this.dropTargets.get(t)
    );
  }
  getSourceType(t) {
    return (
      N(this.isSourceId(t), "Expected a valid source ID."), this.types.get(t)
    );
  }
  getTargetType(t) {
    return (
      N(this.isTargetId(t), "Expected a valid target ID."), this.types.get(t)
    );
  }
  isSourceId(t) {
    return Uc(t) === Le.SOURCE;
  }
  isTargetId(t) {
    return Uc(t) === Le.TARGET;
  }
  removeSource(t) {
    N(this.getSource(t), "Expected an existing source."),
      this.store.dispatch(M0(t)),
      _0(() => {
        this.dragSources.delete(t), this.types.delete(t);
      });
  }
  removeTarget(t) {
    N(this.getTarget(t), "Expected an existing target."),
      this.store.dispatch(L0(t)),
      this.dropTargets.delete(t),
      this.types.delete(t);
  }
  pinSource(t) {
    const n = this.getSource(t);
    N(n, "Expected an existing source."),
      (this.pinnedSourceId = t),
      (this.pinnedSource = n);
  }
  unpinSource() {
    N(this.pinnedSource, "No source is pinned at the time."),
      (this.pinnedSourceId = null),
      (this.pinnedSource = null);
  }
  addHandler(t, n, r) {
    const o = B0(t);
    return (
      this.types.set(o, n),
      t === Le.SOURCE
        ? this.dragSources.set(o, r)
        : t === Le.TARGET && this.dropTargets.set(o, r),
      o
    );
  }
  constructor(t) {
    (this.types = new Map()),
      (this.dragSources = new Map()),
      (this.dropTargets = new Map()),
      (this.pinnedSourceId = null),
      (this.pinnedSource = null),
      (this.store = t);
  }
}
const W0 = (e, t) => e === t;
function H0(e, t) {
  return !e && !t ? !0 : !e || !t ? !1 : e.x === t.x && e.y === t.y;
}
function V0(e, t, n = W0) {
  if (e.length !== t.length) return !1;
  for (let r = 0; r < e.length; ++r) if (!n(e[r], t[r])) return !1;
  return !0;
}
function Q0(e = Sr, t) {
  switch (t.type) {
    case Mi:
      break;
    case na:
    case ra:
    case zi:
    case oa:
      return Sr;
    case bi:
    case ea:
    case Fi:
    case Li:
    default:
      return ta;
  }
  const { targetIds: n = [], prevTargetIds: r = [] } = t.payload,
    o = Xy(n, r);
  if (!(o.length > 0 || !V0(n, r))) return Sr;
  const l = r[r.length - 1],
    s = n[n.length - 1];
  return l !== s && (l && o.push(l), s && o.push(s)), o;
}
function G0(e, t, n) {
  return (
    t in e
      ? Object.defineProperty(e, t, {
          value: n,
          enumerable: !0,
          configurable: !0,
          writable: !0,
        })
      : (e[t] = n),
    e
  );
}
function K0(e) {
  for (var t = 1; t < arguments.length; t++) {
    var n = arguments[t] != null ? arguments[t] : {},
      r = Object.keys(n);
    typeof Object.getOwnPropertySymbols == "function" &&
      (r = r.concat(
        Object.getOwnPropertySymbols(n).filter(function (o) {
          return Object.getOwnPropertyDescriptor(n, o).enumerable;
        })
      )),
      r.forEach(function (o) {
        G0(e, o, n[o]);
      });
  }
  return e;
}
const Hc = {
  initialSourceClientOffset: null,
  initialClientOffset: null,
  clientOffset: null,
};
function Y0(e = Hc, t) {
  const { payload: n } = t;
  switch (t.type) {
    case Ju:
    case bi:
      return {
        initialSourceClientOffset: n.sourceClientOffset,
        initialClientOffset: n.clientOffset,
        clientOffset: n.clientOffset,
      };
    case Mi:
      return H0(e.clientOffset, n.clientOffset)
        ? e
        : K0({}, e, { clientOffset: n.clientOffset });
    case Fi:
    case Li:
      return Hc;
    default:
      return e;
  }
}
function X0(e, t, n) {
  return (
    t in e
      ? Object.defineProperty(e, t, {
          value: n,
          enumerable: !0,
          configurable: !0,
          writable: !0,
        })
      : (e[t] = n),
    e
  );
}
function fn(e) {
  for (var t = 1; t < arguments.length; t++) {
    var n = arguments[t] != null ? arguments[t] : {},
      r = Object.keys(n);
    typeof Object.getOwnPropertySymbols == "function" &&
      (r = r.concat(
        Object.getOwnPropertySymbols(n).filter(function (o) {
          return Object.getOwnPropertyDescriptor(n, o).enumerable;
        })
      )),
      r.forEach(function (o) {
        X0(e, o, n[o]);
      });
  }
  return e;
}
const Z0 = {
  itemType: null,
  item: null,
  sourceId: null,
  targetIds: [],
  dropResult: null,
  didDrop: !1,
  isSourcePublic: null,
};
function q0(e = Z0, t) {
  const { payload: n } = t;
  switch (t.type) {
    case bi:
      return fn({}, e, {
        itemType: n.itemType,
        item: n.item,
        sourceId: n.sourceId,
        isSourcePublic: n.isSourcePublic,
        dropResult: null,
        didDrop: !1,
      });
    case ea:
      return fn({}, e, { isSourcePublic: !0 });
    case Mi:
      return fn({}, e, { targetIds: n.targetIds });
    case zi:
      return e.targetIds.indexOf(n.targetId) === -1
        ? e
        : fn({}, e, { targetIds: Yy(e.targetIds, n.targetId) });
    case Li:
      return fn({}, e, {
        dropResult: n.dropResult,
        didDrop: !0,
        targetIds: [],
      });
    case Fi:
      return fn({}, e, {
        itemType: null,
        item: null,
        sourceId: null,
        dropResult: null,
        didDrop: !1,
        isSourcePublic: null,
        targetIds: [],
      });
    default:
      return e;
  }
}
function J0(e = 0, t) {
  switch (t.type) {
    case na:
    case ra:
      return e + 1;
    case oa:
    case zi:
      return e - 1;
    default:
      return e;
  }
}
function e1(e = 0) {
  return e + 1;
}
function t1(e, t, n) {
  return (
    t in e
      ? Object.defineProperty(e, t, {
          value: n,
          enumerable: !0,
          configurable: !0,
          writable: !0,
        })
      : (e[t] = n),
    e
  );
}
function n1(e) {
  for (var t = 1; t < arguments.length; t++) {
    var n = arguments[t] != null ? arguments[t] : {},
      r = Object.keys(n);
    typeof Object.getOwnPropertySymbols == "function" &&
      (r = r.concat(
        Object.getOwnPropertySymbols(n).filter(function (o) {
          return Object.getOwnPropertyDescriptor(n, o).enumerable;
        })
      )),
      r.forEach(function (o) {
        t1(e, o, n[o]);
      });
  }
  return e;
}
function r1(e = {}, t) {
  return {
    dirtyHandlerIds: Q0(e.dirtyHandlerIds, {
      type: t.type,
      payload: n1({}, t.payload, {
        prevTargetIds: Ky(e, "dragOperation.targetIds", []),
      }),
    }),
    dragOffset: Y0(e.dragOffset, t),
    refCount: J0(e.refCount, t),
    dragOperation: q0(e.dragOperation, t),
    stateId: e1(e.stateId),
  };
}
function o1(e, t = void 0, n = {}, r = !1) {
  const o = i1(r),
    i = new O0(o, new U0(o)),
    l = new w0(o, i),
    s = e(l, t, n);
  return l.receiveBackend(s), l;
}
function i1(e) {
  const t = typeof window != "undefined" && window.__REDUX_DEVTOOLS_EXTENSION__;
  return Yp(r1, e && t && t({ name: "dnd-core", instanceId: "dnd-core" }));
}
function l1(e, t) {
  if (e == null) return {};
  var n = s1(e, t),
    r,
    o;
  if (Object.getOwnPropertySymbols) {
    var i = Object.getOwnPropertySymbols(e);
    for (o = 0; o < i.length; o++)
      (r = i[o]),
        !(t.indexOf(r) >= 0) &&
          (!Object.prototype.propertyIsEnumerable.call(e, r) || (n[r] = e[r]));
  }
  return n;
}
function s1(e, t) {
  if (e == null) return {};
  var n = {},
    r = Object.keys(e),
    o,
    i;
  for (i = 0; i < r.length; i++)
    (o = r[i]), !(t.indexOf(o) >= 0) && (n[o] = e[o]);
  return n;
}
let Vc = 0;
const zo = Symbol.for("__REACT_DND_CONTEXT_INSTANCE__");
var u1 = g.exports.memo(function (t) {
  var { children: n } = t,
    r = l1(t, ["children"]);
  const [o, i] = a1(r);
  return (
    g.exports.useEffect(() => {
      if (i) {
        const l = th();
        return (
          ++Vc,
          () => {
            --Vc === 0 && (l[zo] = null);
          }
        );
      }
    }, []),
    P(Kp.Provider, { value: o, children: n })
  );
});
function a1(e) {
  if ("manager" in e) return [{ dragDropManager: e.manager }, !1];
  const t = c1(e.backend, e.context, e.options, e.debugMode),
    n = !e.context;
  return [t, n];
}
function c1(e, t = th(), n, r) {
  const o = t;
  return o[zo] || (o[zo] = { dragDropManager: o1(e, t, n, r) }), o[zo];
}
function th() {
  return typeof global != "undefined" ? global : window;
}
var d1 = function e(t, n) {
  if (t === n) return !0;
  if (t && n && typeof t == "object" && typeof n == "object") {
    if (t.constructor !== n.constructor) return !1;
    var r, o, i;
    if (Array.isArray(t)) {
      if (((r = t.length), r != n.length)) return !1;
      for (o = r; o-- !== 0; ) if (!e(t[o], n[o])) return !1;
      return !0;
    }
    if (t.constructor === RegExp)
      return t.source === n.source && t.flags === n.flags;
    if (t.valueOf !== Object.prototype.valueOf)
      return t.valueOf() === n.valueOf();
    if (t.toString !== Object.prototype.toString)
      return t.toString() === n.toString();
    if (((i = Object.keys(t)), (r = i.length), r !== Object.keys(n).length))
      return !1;
    for (o = r; o-- !== 0; )
      if (!Object.prototype.hasOwnProperty.call(n, i[o])) return !1;
    for (o = r; o-- !== 0; ) {
      var l = i[o];
      if (!e(t[l], n[l])) return !1;
    }
    return !0;
  }
  return t !== t && n !== n;
};
const tn =
  typeof window != "undefined"
    ? g.exports.useLayoutEffect
    : g.exports.useEffect;
function nh(e, t, n) {
  const [r, o] = g.exports.useState(() => t(e)),
    i = g.exports.useCallback(() => {
      const l = t(e);
      d1(r, l) || (o(l), n && n());
    }, [r, e, n]);
  return tn(i), [r, i];
}
function f1(e, t, n) {
  const [r, o] = nh(e, t, n);
  return (
    tn(
      function () {
        const l = e.getHandlerId();
        if (l != null) return e.subscribeToStateChange(o, { handlerIds: [l] });
      },
      [e, o]
    ),
    r
  );
}
function rh(e, t, n) {
  return f1(t, e || (() => ({})), () => n.reconnect());
}
function oh(e, t) {
  const n = [...(t || [])];
  return (
    t == null && typeof e != "function" && n.push(e),
    g.exports.useMemo(() => (typeof e == "function" ? e() : e), n)
  );
}
function p1(e) {
  return g.exports.useMemo(() => e.hooks.dragSource(), [e]);
}
function h1(e) {
  return g.exports.useMemo(() => e.hooks.dragPreview(), [e]);
}
let Sl = !1,
  wl = !1;
class g1 {
  receiveHandlerId(t) {
    this.sourceId = t;
  }
  getHandlerId() {
    return this.sourceId;
  }
  canDrag() {
    N(
      !Sl,
      "You may not call monitor.canDrag() inside your canDrag() implementation. Read more: http://react-dnd.github.io/react-dnd/docs/api/drag-source-monitor"
    );
    try {
      return (Sl = !0), this.internalMonitor.canDragSource(this.sourceId);
    } finally {
      Sl = !1;
    }
  }
  isDragging() {
    if (!this.sourceId) return !1;
    N(
      !wl,
      "You may not call monitor.isDragging() inside your isDragging() implementation. Read more: http://react-dnd.github.io/react-dnd/docs/api/drag-source-monitor"
    );
    try {
      return (wl = !0), this.internalMonitor.isDraggingSource(this.sourceId);
    } finally {
      wl = !1;
    }
  }
  subscribeToStateChange(t, n) {
    return this.internalMonitor.subscribeToStateChange(t, n);
  }
  isDraggingSource(t) {
    return this.internalMonitor.isDraggingSource(t);
  }
  isOverTarget(t, n) {
    return this.internalMonitor.isOverTarget(t, n);
  }
  getTargetIds() {
    return this.internalMonitor.getTargetIds();
  }
  isSourcePublic() {
    return this.internalMonitor.isSourcePublic();
  }
  getSourceId() {
    return this.internalMonitor.getSourceId();
  }
  subscribeToOffsetChange(t) {
    return this.internalMonitor.subscribeToOffsetChange(t);
  }
  canDragSource(t) {
    return this.internalMonitor.canDragSource(t);
  }
  canDropOnTarget(t) {
    return this.internalMonitor.canDropOnTarget(t);
  }
  getItemType() {
    return this.internalMonitor.getItemType();
  }
  getItem() {
    return this.internalMonitor.getItem();
  }
  getDropResult() {
    return this.internalMonitor.getDropResult();
  }
  didDrop() {
    return this.internalMonitor.didDrop();
  }
  getInitialClientOffset() {
    return this.internalMonitor.getInitialClientOffset();
  }
  getInitialSourceClientOffset() {
    return this.internalMonitor.getInitialSourceClientOffset();
  }
  getSourceClientOffset() {
    return this.internalMonitor.getSourceClientOffset();
  }
  getClientOffset() {
    return this.internalMonitor.getClientOffset();
  }
  getDifferenceFromInitialOffset() {
    return this.internalMonitor.getDifferenceFromInitialOffset();
  }
  constructor(t) {
    (this.sourceId = null), (this.internalMonitor = t.getMonitor());
  }
}
let xl = !1;
class m1 {
  receiveHandlerId(t) {
    this.targetId = t;
  }
  getHandlerId() {
    return this.targetId;
  }
  subscribeToStateChange(t, n) {
    return this.internalMonitor.subscribeToStateChange(t, n);
  }
  canDrop() {
    if (!this.targetId) return !1;
    N(
      !xl,
      "You may not call monitor.canDrop() inside your canDrop() implementation. Read more: http://react-dnd.github.io/react-dnd/docs/api/drop-target-monitor"
    );
    try {
      return (xl = !0), this.internalMonitor.canDropOnTarget(this.targetId);
    } finally {
      xl = !1;
    }
  }
  isOver(t) {
    return this.targetId
      ? this.internalMonitor.isOverTarget(this.targetId, t)
      : !1;
  }
  getItemType() {
    return this.internalMonitor.getItemType();
  }
  getItem() {
    return this.internalMonitor.getItem();
  }
  getDropResult() {
    return this.internalMonitor.getDropResult();
  }
  didDrop() {
    return this.internalMonitor.didDrop();
  }
  getInitialClientOffset() {
    return this.internalMonitor.getInitialClientOffset();
  }
  getInitialSourceClientOffset() {
    return this.internalMonitor.getInitialSourceClientOffset();
  }
  getSourceClientOffset() {
    return this.internalMonitor.getSourceClientOffset();
  }
  getClientOffset() {
    return this.internalMonitor.getClientOffset();
  }
  getDifferenceFromInitialOffset() {
    return this.internalMonitor.getDifferenceFromInitialOffset();
  }
  constructor(t) {
    (this.targetId = null), (this.internalMonitor = t.getMonitor());
  }
}
function v1(e, t, n) {
  const r = n.getRegistry(),
    o = r.addTarget(e, t);
  return [o, () => r.removeTarget(o)];
}
function y1(e, t, n) {
  const r = n.getRegistry(),
    o = r.addSource(e, t);
  return [o, () => r.removeSource(o)];
}
function Ms(e, t, n, r) {
  let o = n ? n.call(r, e, t) : void 0;
  if (o !== void 0) return !!o;
  if (e === t) return !0;
  if (typeof e != "object" || !e || typeof t != "object" || !t) return !1;
  const i = Object.keys(e),
    l = Object.keys(t);
  if (i.length !== l.length) return !1;
  const s = Object.prototype.hasOwnProperty.bind(t);
  for (let u = 0; u < i.length; u++) {
    const a = i[u];
    if (!s(a)) return !1;
    const c = e[a],
      f = t[a];
    if (
      ((o = n ? n.call(r, c, f, a) : void 0),
      o === !1 || (o === void 0 && c !== f))
    )
      return !1;
  }
  return !0;
}
function Ls(e) {
  return (
    e !== null &&
    typeof e == "object" &&
    Object.prototype.hasOwnProperty.call(e, "current")
  );
}
function S1(e) {
  if (typeof e.type == "string") return;
  const t = e.type.displayName || e.type.name || "the component";
  throw new Error(
    `Only native element nodes can now be passed to React DnD connectors.You can either wrap ${t} into a <div>, or turn it into a drag source or a drop target itself.`
  );
}
function w1(e) {
  return (t = null, n = null) => {
    if (!g.exports.isValidElement(t)) {
      const i = t;
      return e(i, n), i;
    }
    const r = t;
    return S1(r), x1(r, n ? (i) => e(i, n) : e);
  };
}
function ih(e) {
  const t = {};
  return (
    Object.keys(e).forEach((n) => {
      const r = e[n];
      if (n.endsWith("Ref")) t[n] = e[n];
      else {
        const o = w1(r);
        t[n] = () => o;
      }
    }),
    t
  );
}
function Qc(e, t) {
  typeof e == "function" ? e(t) : (e.current = t);
}
function x1(e, t) {
  const n = e.ref;
  return (
    N(
      typeof n != "string",
      "Cannot connect React DnD to an element with an existing string ref. Please convert it to use a callback ref instead, or wrap it into a <span> or <div>. Read more: https://reactjs.org/docs/refs-and-the-dom.html#callback-refs"
    ),
    n
      ? g.exports.cloneElement(e, {
          ref: (r) => {
            Qc(n, r), Qc(t, r);
          },
        })
      : g.exports.cloneElement(e, { ref: t })
  );
}
class E1 {
  receiveHandlerId(t) {
    this.handlerId !== t && ((this.handlerId = t), this.reconnect());
  }
  get connectTarget() {
    return this.dragSource;
  }
  get dragSourceOptions() {
    return this.dragSourceOptionsInternal;
  }
  set dragSourceOptions(t) {
    this.dragSourceOptionsInternal = t;
  }
  get dragPreviewOptions() {
    return this.dragPreviewOptionsInternal;
  }
  set dragPreviewOptions(t) {
    this.dragPreviewOptionsInternal = t;
  }
  reconnect() {
    const t = this.reconnectDragSource();
    this.reconnectDragPreview(t);
  }
  reconnectDragSource() {
    const t = this.dragSource,
      n =
        this.didHandlerIdChange() ||
        this.didConnectedDragSourceChange() ||
        this.didDragSourceOptionsChange();
    return (
      n && this.disconnectDragSource(),
      this.handlerId
        ? t
          ? (n &&
              ((this.lastConnectedHandlerId = this.handlerId),
              (this.lastConnectedDragSource = t),
              (this.lastConnectedDragSourceOptions = this.dragSourceOptions),
              (this.dragSourceUnsubscribe = this.backend.connectDragSource(
                this.handlerId,
                t,
                this.dragSourceOptions
              ))),
            n)
          : ((this.lastConnectedDragSource = t), n)
        : n
    );
  }
  reconnectDragPreview(t = !1) {
    const n = this.dragPreview,
      r =
        t ||
        this.didHandlerIdChange() ||
        this.didConnectedDragPreviewChange() ||
        this.didDragPreviewOptionsChange();
    if ((r && this.disconnectDragPreview(), !!this.handlerId)) {
      if (!n) {
        this.lastConnectedDragPreview = n;
        return;
      }
      r &&
        ((this.lastConnectedHandlerId = this.handlerId),
        (this.lastConnectedDragPreview = n),
        (this.lastConnectedDragPreviewOptions = this.dragPreviewOptions),
        (this.dragPreviewUnsubscribe = this.backend.connectDragPreview(
          this.handlerId,
          n,
          this.dragPreviewOptions
        )));
    }
  }
  didHandlerIdChange() {
    return this.lastConnectedHandlerId !== this.handlerId;
  }
  didConnectedDragSourceChange() {
    return this.lastConnectedDragSource !== this.dragSource;
  }
  didConnectedDragPreviewChange() {
    return this.lastConnectedDragPreview !== this.dragPreview;
  }
  didDragSourceOptionsChange() {
    return !Ms(this.lastConnectedDragSourceOptions, this.dragSourceOptions);
  }
  didDragPreviewOptionsChange() {
    return !Ms(this.lastConnectedDragPreviewOptions, this.dragPreviewOptions);
  }
  disconnectDragSource() {
    this.dragSourceUnsubscribe &&
      (this.dragSourceUnsubscribe(), (this.dragSourceUnsubscribe = void 0));
  }
  disconnectDragPreview() {
    this.dragPreviewUnsubscribe &&
      (this.dragPreviewUnsubscribe(),
      (this.dragPreviewUnsubscribe = void 0),
      (this.dragPreviewNode = null),
      (this.dragPreviewRef = null));
  }
  get dragSource() {
    return (
      this.dragSourceNode || (this.dragSourceRef && this.dragSourceRef.current)
    );
  }
  get dragPreview() {
    return (
      this.dragPreviewNode ||
      (this.dragPreviewRef && this.dragPreviewRef.current)
    );
  }
  clearDragSource() {
    (this.dragSourceNode = null), (this.dragSourceRef = null);
  }
  clearDragPreview() {
    (this.dragPreviewNode = null), (this.dragPreviewRef = null);
  }
  constructor(t) {
    (this.hooks = ih({
      dragSource: (n, r) => {
        this.clearDragSource(),
          (this.dragSourceOptions = r || null),
          Ls(n) ? (this.dragSourceRef = n) : (this.dragSourceNode = n),
          this.reconnectDragSource();
      },
      dragPreview: (n, r) => {
        this.clearDragPreview(),
          (this.dragPreviewOptions = r || null),
          Ls(n) ? (this.dragPreviewRef = n) : (this.dragPreviewNode = n),
          this.reconnectDragPreview();
      },
    })),
      (this.handlerId = null),
      (this.dragSourceRef = null),
      (this.dragSourceOptionsInternal = null),
      (this.dragPreviewRef = null),
      (this.dragPreviewOptionsInternal = null),
      (this.lastConnectedHandlerId = null),
      (this.lastConnectedDragSource = null),
      (this.lastConnectedDragSourceOptions = null),
      (this.lastConnectedDragPreview = null),
      (this.lastConnectedDragPreviewOptions = null),
      (this.backend = t);
  }
}
class C1 {
  get connectTarget() {
    return this.dropTarget;
  }
  reconnect() {
    const t =
      this.didHandlerIdChange() ||
      this.didDropTargetChange() ||
      this.didOptionsChange();
    t && this.disconnectDropTarget();
    const n = this.dropTarget;
    if (!!this.handlerId) {
      if (!n) {
        this.lastConnectedDropTarget = n;
        return;
      }
      t &&
        ((this.lastConnectedHandlerId = this.handlerId),
        (this.lastConnectedDropTarget = n),
        (this.lastConnectedDropTargetOptions = this.dropTargetOptions),
        (this.unsubscribeDropTarget = this.backend.connectDropTarget(
          this.handlerId,
          n,
          this.dropTargetOptions
        )));
    }
  }
  receiveHandlerId(t) {
    t !== this.handlerId && ((this.handlerId = t), this.reconnect());
  }
  get dropTargetOptions() {
    return this.dropTargetOptionsInternal;
  }
  set dropTargetOptions(t) {
    this.dropTargetOptionsInternal = t;
  }
  didHandlerIdChange() {
    return this.lastConnectedHandlerId !== this.handlerId;
  }
  didDropTargetChange() {
    return this.lastConnectedDropTarget !== this.dropTarget;
  }
  didOptionsChange() {
    return !Ms(this.lastConnectedDropTargetOptions, this.dropTargetOptions);
  }
  disconnectDropTarget() {
    this.unsubscribeDropTarget &&
      (this.unsubscribeDropTarget(), (this.unsubscribeDropTarget = void 0));
  }
  get dropTarget() {
    return (
      this.dropTargetNode || (this.dropTargetRef && this.dropTargetRef.current)
    );
  }
  clearDropTarget() {
    (this.dropTargetRef = null), (this.dropTargetNode = null);
  }
  constructor(t) {
    (this.hooks = ih({
      dropTarget: (n, r) => {
        this.clearDropTarget(),
          (this.dropTargetOptions = r),
          Ls(n) ? (this.dropTargetRef = n) : (this.dropTargetNode = n),
          this.reconnect();
      },
    })),
      (this.handlerId = null),
      (this.dropTargetRef = null),
      (this.dropTargetOptionsInternal = null),
      (this.lastConnectedHandlerId = null),
      (this.lastConnectedDropTarget = null),
      (this.lastConnectedDropTargetOptions = null),
      (this.backend = t);
  }
}
function sn() {
  const { dragDropManager: e } = g.exports.useContext(Kp);
  return N(e != null, "Expected drag drop context"), e;
}
function k1(e, t) {
  const n = sn(),
    r = g.exports.useMemo(() => new E1(n.getBackend()), [n]);
  return (
    tn(
      () => (
        (r.dragSourceOptions = e || null),
        r.reconnect(),
        () => r.disconnectDragSource()
      ),
      [r, e]
    ),
    tn(
      () => (
        (r.dragPreviewOptions = t || null),
        r.reconnect(),
        () => r.disconnectDragPreview()
      ),
      [r, t]
    ),
    r
  );
}
function O1() {
  const e = sn();
  return g.exports.useMemo(() => new g1(e), [e]);
}
class T1 {
  beginDrag() {
    const t = this.spec,
      n = this.monitor;
    let r = null;
    return (
      typeof t.item == "object"
        ? (r = t.item)
        : typeof t.item == "function"
        ? (r = t.item(n))
        : (r = {}),
      r != null ? r : null
    );
  }
  canDrag() {
    const t = this.spec,
      n = this.monitor;
    return typeof t.canDrag == "boolean"
      ? t.canDrag
      : typeof t.canDrag == "function"
      ? t.canDrag(n)
      : !0;
  }
  isDragging(t, n) {
    const r = this.spec,
      o = this.monitor,
      { isDragging: i } = r;
    return i ? i(o) : n === t.getSourceId();
  }
  endDrag() {
    const t = this.spec,
      n = this.monitor,
      r = this.connector,
      { end: o } = t;
    o && o(n.getItem(), n), r.reconnect();
  }
  constructor(t, n, r) {
    (this.spec = t), (this.monitor = n), (this.connector = r);
  }
}
function P1(e, t, n) {
  const r = g.exports.useMemo(() => new T1(e, t, n), [t, n]);
  return (
    g.exports.useEffect(() => {
      r.spec = e;
    }, [e]),
    r
  );
}
function I1(e) {
  return g.exports.useMemo(() => {
    const t = e.type;
    return N(t != null, "spec.type must be defined"), t;
  }, [e]);
}
function D1(e, t, n) {
  const r = sn(),
    o = P1(e, t, n),
    i = I1(e);
  tn(
    function () {
      if (i != null) {
        const [s, u] = y1(i, o, r);
        return t.receiveHandlerId(s), n.receiveHandlerId(s), u;
      }
    },
    [r, t, n, o, i]
  );
}
function $1(e, t) {
  const n = oh(e, t);
  N(
    !n.begin,
    "useDrag::spec.begin was deprecated in v14. Replace spec.begin() with spec.item(). (see more here - https://react-dnd.github.io/react-dnd/docs/api/use-drag)"
  );
  const r = O1(),
    o = k1(n.options, n.previewOptions);
  return D1(n, r, o), [rh(n.collect, r, o), p1(o), h1(o)];
}
function R1(e) {
  const n = sn().getMonitor(),
    [r, o] = nh(n, e);
  return (
    g.exports.useEffect(() => n.subscribeToOffsetChange(o)),
    g.exports.useEffect(() => n.subscribeToStateChange(o)),
    r
  );
}
function _1(e) {
  return g.exports.useMemo(() => e.hooks.dropTarget(), [e]);
}
function N1(e) {
  const t = sn(),
    n = g.exports.useMemo(() => new C1(t.getBackend()), [t]);
  return (
    tn(
      () => (
        (n.dropTargetOptions = e || null),
        n.reconnect(),
        () => n.disconnectDropTarget()
      ),
      [e]
    ),
    n
  );
}
function b1() {
  const e = sn();
  return g.exports.useMemo(() => new m1(e), [e]);
}
function M1(e) {
  const { accept: t } = e;
  return g.exports.useMemo(
    () => (
      N(e.accept != null, "accept must be defined"), Array.isArray(t) ? t : [t]
    ),
    [t]
  );
}
class L1 {
  canDrop() {
    const t = this.spec,
      n = this.monitor;
    return t.canDrop ? t.canDrop(n.getItem(), n) : !0;
  }
  hover() {
    const t = this.spec,
      n = this.monitor;
    t.hover && t.hover(n.getItem(), n);
  }
  drop() {
    const t = this.spec,
      n = this.monitor;
    if (t.drop) return t.drop(n.getItem(), n);
  }
  constructor(t, n) {
    (this.spec = t), (this.monitor = n);
  }
}
function F1(e, t) {
  const n = g.exports.useMemo(() => new L1(e, t), [t]);
  return (
    g.exports.useEffect(() => {
      n.spec = e;
    }, [e]),
    n
  );
}
function z1(e, t, n) {
  const r = sn(),
    o = F1(e, t),
    i = M1(e);
  tn(
    function () {
      const [s, u] = v1(i, o, r);
      return t.receiveHandlerId(s), n.receiveHandlerId(s), u;
    },
    [r, t, o, n, i.map((l) => l.toString()).join("|")]
  );
}
function j1(e, t) {
  const n = oh(e, t),
    r = b1(),
    o = N1(n.options);
  return z1(n, r, o), [rh(n.collect, r, o), _1(o)];
}
const lh = _e("div", {
    position: "absolute",
    top: 0,
    right: 0,
    padding: "6px 10px",
    background: "#5763d0",
    borderBottomLeftRadius: "5px",
    fontSize: "12px",
  }),
  sh = _e("div", {
    width: "100%",
    background: "#FFFFFF05",
    fontSize: 12,
    padding: 5,
    textAlign: "center",
  }),
  uh = _e("div", {
    background: "#FFFFFF08",
    width: 4,
    height: 26,
    borderRadius: 9,
    position: "relative",
    overflow: "hidden",
  }),
  ah = _e("div", {
    position: "absolute",
    bottom: 0,
    background: "#5763d0",
    width: "100%",
  }),
  ch = (e) => {
    var a;
    const { moveItem: t, quantity: n, setQuantity: r } = Yr(),
      o = g.exports.useRef(null),
      [{ isDragging: i }, l] = $1(
        () => ({
          type: e.type || "item",
          item: {
            item: e == null ? void 0 : e.item,
            section: e.section,
            index: e.index,
          },
          collect: (c) => ({ isDragging: !!c.isDragging() }),
        }),
        [e.type]
      ),
      [{ isOver: s }, u] = j1(
        () => ({
          accept: e.accepts,
          drop: (c) => {
            if (!c.item || !o.current) return;
            const f = c.index,
              p = e.index,
              y = c.section,
              S = e.section;
            return t(f, p, y, S, n, c.item.id);
          },
          collect: (c) => ({ isOver: !!c.isOver() }),
        }),
        [n]
      );
    if ((l(u(o)), e.item && e.item.durability && e.item.days)) {
      const c = 86400 * e.item.days,
        f = 100 - (e.item.durability / c) * 100;
      e.item.durability > 100 && (e.item.durability = f);
    }
    return (
      g.exports.useEffect(() => {
        i
          ? window.addEventListener("keydown", (c) => {
              c.key === "Shift" && e.item && r(e.item.amount);
            })
          : r(1);
      }, [i]),
      P("div", {
        ref: o,
        style: {
          cursor: i ? "grabbing" : "grab",
          background: s ? "#ffffff09" : "transparent",
          width: "100%",
          height: "100%",
          display: "flex",
          justifyContent: "center",
          alignItems: "center",
          position: "relative",
          zIndex: 50,
        },
        children:
          (a = e == null ? void 0 : e.item) != null && a.name
            ? j("div", {
                style: {
                  display: "grid",
                  opacity: i ? 0 : 1,
                  width: "100%",
                  height: "100%",
                  alignItems: e.section == "inventory" ? "flex-end" : "center",
                },
                children: [
                  P("span", {
                    style: {
                      position: "absolute",
                      top: 5,
                      left: 5,
                      fontSize: 9,
                      opacity: 0.7,
                    },
                    children: (e.item.peso * e.item.amount).toFixed(2),
                  }),
                  j("div", {
                    style: {
                      height: "100%",
                      display: "flex",
                      justifyContent: "center",
                      alignItems: "center",
                      padding: 2,
                    },
                    children: [
                      P("img", {
                        src: e.item.url,
                        width: "100%",
                        height: 50,
                        style: { objectFit: "contain" },
                      }),
                      e.item.durability
                        ? P(uh, {
                            children: P(ah, {
                              css: { height: `${e.item.durability}%` },
                            }),
                          })
                        : "",
                    ],
                  }),
                  j(lh, { children: ["x", e.item.amount] }),
                  P(sh, {
                    css: { position: "absolute", bottom: 0 },
                    children: e.item.name,
                  }),
                ],
              })
            : null,
      })
    );
  },
  wr = /^[a-z0-9]+(-[a-z0-9]+)*$/,
  ji = (e, t, n, r = "") => {
    const o = e.split(":");
    if (e.slice(0, 1) === "@") {
      if (o.length < 2 || o.length > 3) return null;
      r = o.shift().slice(1);
    }
    if (o.length > 3 || !o.length) return null;
    if (o.length > 1) {
      const s = o.pop(),
        u = o.pop(),
        a = { provider: o.length > 0 ? o[0] : r, prefix: u, name: s };
      return t && !jo(a) ? null : a;
    }
    const i = o[0],
      l = i.split("-");
    if (l.length > 1) {
      const s = { provider: r, prefix: l.shift(), name: l.join("-") };
      return t && !jo(s) ? null : s;
    }
    if (n && r === "") {
      const s = { provider: r, prefix: "", name: i };
      return t && !jo(s, n) ? null : s;
    }
    return null;
  },
  jo = (e, t) =>
    e
      ? !!(
          (e.provider === "" || e.provider.match(wr)) &&
          ((t && e.prefix === "") || e.prefix.match(wr)) &&
          e.name.match(wr)
        )
      : !1,
  dh = Object.freeze({ left: 0, top: 0, width: 16, height: 16 }),
  hi = Object.freeze({ rotate: 0, vFlip: !1, hFlip: !1 }),
  ia = Object.freeze({ ...dh, ...hi }),
  Fs = Object.freeze({ ...ia, body: "", hidden: !1 });
function A1(e, t) {
  const n = {};
  !e.hFlip != !t.hFlip && (n.hFlip = !0),
    !e.vFlip != !t.vFlip && (n.vFlip = !0);
  const r = ((e.rotate || 0) + (t.rotate || 0)) % 4;
  return r && (n.rotate = r), n;
}
function Gc(e, t) {
  const n = A1(e, t);
  for (const r in Fs)
    r in hi
      ? r in e && !(r in n) && (n[r] = hi[r])
      : r in t
      ? (n[r] = t[r])
      : r in e && (n[r] = e[r]);
  return n;
}
function B1(e, t) {
  const n = e.icons,
    r = e.aliases || Object.create(null),
    o = Object.create(null);
  function i(l) {
    if (n[l]) return (o[l] = []);
    if (!(l in o)) {
      o[l] = null;
      const s = r[l] && r[l].parent,
        u = s && i(s);
      u && (o[l] = [s].concat(u));
    }
    return o[l];
  }
  return (t || Object.keys(n).concat(Object.keys(r))).forEach(i), o;
}
function U1(e, t, n) {
  const r = e.icons,
    o = e.aliases || Object.create(null);
  let i = {};
  function l(s) {
    i = Gc(r[s] || o[s], i);
  }
  return l(t), n.forEach(l), Gc(e, i);
}
function fh(e, t) {
  const n = [];
  if (typeof e != "object" || typeof e.icons != "object") return n;
  e.not_found instanceof Array &&
    e.not_found.forEach((o) => {
      t(o, null), n.push(o);
    });
  const r = B1(e);
  for (const o in r) {
    const i = r[o];
    i && (t(o, U1(e, o, i)), n.push(o));
  }
  return n;
}
const W1 = { provider: "", aliases: {}, not_found: {}, ...dh };
function El(e, t) {
  for (const n in t) if (n in e && typeof e[n] != typeof t[n]) return !1;
  return !0;
}
function ph(e) {
  if (typeof e != "object" || e === null) return null;
  const t = e;
  if (
    typeof t.prefix != "string" ||
    !e.icons ||
    typeof e.icons != "object" ||
    !El(e, W1)
  )
    return null;
  const n = t.icons;
  for (const o in n) {
    const i = n[o];
    if (!o.match(wr) || typeof i.body != "string" || !El(i, Fs)) return null;
  }
  const r = t.aliases || Object.create(null);
  for (const o in r) {
    const i = r[o],
      l = i.parent;
    if (!o.match(wr) || typeof l != "string" || (!n[l] && !r[l]) || !El(i, Fs))
      return null;
  }
  return t;
}
const Kc = Object.create(null);
function H1(e, t) {
  return {
    provider: e,
    prefix: t,
    icons: Object.create(null),
    missing: new Set(),
  };
}
function nn(e, t) {
  const n = Kc[e] || (Kc[e] = Object.create(null));
  return n[t] || (n[t] = H1(e, t));
}
function la(e, t) {
  return ph(t)
    ? fh(t, (n, r) => {
        r ? (e.icons[n] = r) : e.missing.add(n);
      })
    : [];
}
function V1(e, t, n) {
  try {
    if (typeof n.body == "string") return (e.icons[t] = { ...n }), !0;
  } catch {}
  return !1;
}
let jr = !1;
function hh(e) {
  return typeof e == "boolean" && (jr = e), jr;
}
function Q1(e) {
  const t = typeof e == "string" ? ji(e, !0, jr) : e;
  if (t) {
    const n = nn(t.provider, t.prefix),
      r = t.name;
    return n.icons[r] || (n.missing.has(r) ? null : void 0);
  }
}
function G1(e, t) {
  const n = ji(e, !0, jr);
  if (!n) return !1;
  const r = nn(n.provider, n.prefix);
  return V1(r, n.name, t);
}
function K1(e, t) {
  if (typeof e != "object") return !1;
  if ((typeof t != "string" && (t = e.provider || ""), jr && !t && !e.prefix)) {
    let o = !1;
    return (
      ph(e) &&
        ((e.prefix = ""),
        fh(e, (i, l) => {
          l && G1(i, l) && (o = !0);
        })),
      o
    );
  }
  const n = e.prefix;
  if (!jo({ provider: t, prefix: n, name: "a" })) return !1;
  const r = nn(t, n);
  return !!la(r, e);
}
const gh = Object.freeze({ width: null, height: null }),
  mh = Object.freeze({ ...gh, ...hi }),
  Y1 = /(-?[0-9.]*[0-9]+[0-9.]*)/g,
  X1 = /^-?[0-9.]*[0-9]+[0-9.]*$/g;
function Yc(e, t, n) {
  if (t === 1) return e;
  if (((n = n || 100), typeof e == "number")) return Math.ceil(e * t * n) / n;
  if (typeof e != "string") return e;
  const r = e.split(Y1);
  if (r === null || !r.length) return e;
  const o = [];
  let i = r.shift(),
    l = X1.test(i);
  for (;;) {
    if (l) {
      const s = parseFloat(i);
      isNaN(s) ? o.push(i) : o.push(Math.ceil(s * t * n) / n);
    } else o.push(i);
    if (((i = r.shift()), i === void 0)) return o.join("");
    l = !l;
  }
}
const Z1 = (e) => e === "unset" || e === "undefined" || e === "none";
function q1(e, t) {
  const n = { ...ia, ...e },
    r = { ...mh, ...t },
    o = { left: n.left, top: n.top, width: n.width, height: n.height };
  let i = n.body;
  [n, r].forEach((S) => {
    const m = [],
      C = S.hFlip,
      h = S.vFlip;
    let d = S.rotate;
    C
      ? h
        ? (d += 2)
        : (m.push(
            "translate(" +
              (o.width + o.left).toString() +
              " " +
              (0 - o.top).toString() +
              ")"
          ),
          m.push("scale(-1 1)"),
          (o.top = o.left = 0))
      : h &&
        (m.push(
          "translate(" +
            (0 - o.left).toString() +
            " " +
            (o.height + o.top).toString() +
            ")"
        ),
        m.push("scale(1 -1)"),
        (o.top = o.left = 0));
    let v;
    switch ((d < 0 && (d -= Math.floor(d / 4) * 4), (d = d % 4), d)) {
      case 1:
        (v = o.height / 2 + o.top),
          m.unshift("rotate(90 " + v.toString() + " " + v.toString() + ")");
        break;
      case 2:
        m.unshift(
          "rotate(180 " +
            (o.width / 2 + o.left).toString() +
            " " +
            (o.height / 2 + o.top).toString() +
            ")"
        );
        break;
      case 3:
        (v = o.width / 2 + o.left),
          m.unshift("rotate(-90 " + v.toString() + " " + v.toString() + ")");
        break;
    }
    d % 2 === 1 &&
      (o.left !== o.top && ((v = o.left), (o.left = o.top), (o.top = v)),
      o.width !== o.height &&
        ((v = o.width), (o.width = o.height), (o.height = v))),
      m.length && (i = '<g transform="' + m.join(" ") + '">' + i + "</g>");
  });
  const l = r.width,
    s = r.height,
    u = o.width,
    a = o.height;
  let c, f;
  l === null
    ? ((f = s === null ? "1em" : s === "auto" ? a : s), (c = Yc(f, u / a)))
    : ((c = l === "auto" ? u : l),
      (f = s === null ? Yc(c, a / u) : s === "auto" ? a : s));
  const p = {},
    y = (S, m) => {
      Z1(m) || (p[S] = m.toString());
    };
  return (
    y("width", c),
    y("height", f),
    (p.viewBox =
      o.left.toString() +
      " " +
      o.top.toString() +
      " " +
      u.toString() +
      " " +
      a.toString()),
    { attributes: p, body: i }
  );
}
const J1 = /\sid="(\S+)"/g,
  eS =
    "IconifyId" +
    Date.now().toString(16) +
    ((Math.random() * 16777216) | 0).toString(16);
let tS = 0;
function nS(e, t = eS) {
  const n = [];
  let r;
  for (; (r = J1.exec(e)); ) n.push(r[1]);
  if (!n.length) return e;
  const o = "suffix" + ((Math.random() * 16777216) | Date.now()).toString(16);
  return (
    n.forEach((i) => {
      const l = typeof t == "function" ? t(i) : t + (tS++).toString(),
        s = i.replace(/[.*+?^${}()|[\]\\]/g, "\\$&");
      e = e.replace(
        new RegExp('([#;"])(' + s + ')([")]|\\.[a-z])', "g"),
        "$1" + l + o + "$3"
      );
    }),
    (e = e.replace(new RegExp(o, "g"), "")),
    e
  );
}
const zs = Object.create(null);
function rS(e, t) {
  zs[e] = t;
}
function js(e) {
  return zs[e] || zs[""];
}
function sa(e) {
  let t;
  if (typeof e.resources == "string") t = [e.resources];
  else if (((t = e.resources), !(t instanceof Array) || !t.length)) return null;
  return {
    resources: t,
    path: e.path || "/",
    maxURL: e.maxURL || 500,
    rotate: e.rotate || 750,
    timeout: e.timeout || 5e3,
    random: e.random === !0,
    index: e.index || 0,
    dataAfterTimeout: e.dataAfterTimeout !== !1,
  };
}
const ua = Object.create(null),
  rr = ["https://api.simplesvg.com", "https://api.unisvg.com"],
  Ao = [];
for (; rr.length > 0; )
  rr.length === 1 || Math.random() > 0.5
    ? Ao.push(rr.shift())
    : Ao.push(rr.pop());
ua[""] = sa({ resources: ["https://api.iconify.design"].concat(Ao) });
function oS(e, t) {
  const n = sa(t);
  return n === null ? !1 : ((ua[e] = n), !0);
}
function aa(e) {
  return ua[e];
}
const iS = () => {
  let e;
  try {
    if (((e = fetch), typeof e == "function")) return e;
  } catch {}
};
let Xc = iS();
function lS(e, t) {
  const n = aa(e);
  if (!n) return 0;
  let r;
  if (!n.maxURL) r = 0;
  else {
    let o = 0;
    n.resources.forEach((l) => {
      o = Math.max(o, l.length);
    });
    const i = t + ".json?icons=";
    r = n.maxURL - o - n.path.length - i.length;
  }
  return r;
}
function sS(e) {
  return e === 404;
}
const uS = (e, t, n) => {
  const r = [],
    o = lS(e, t),
    i = "icons";
  let l = { type: i, provider: e, prefix: t, icons: [] },
    s = 0;
  return (
    n.forEach((u, a) => {
      (s += u.length + 1),
        s >= o &&
          a > 0 &&
          (r.push(l),
          (l = { type: i, provider: e, prefix: t, icons: [] }),
          (s = u.length)),
        l.icons.push(u);
    }),
    r.push(l),
    r
  );
};
function aS(e) {
  if (typeof e == "string") {
    const t = aa(e);
    if (t) return t.path;
  }
  return "/";
}
const cS = (e, t, n) => {
    if (!Xc) {
      n("abort", 424);
      return;
    }
    let r = aS(t.provider);
    switch (t.type) {
      case "icons": {
        const i = t.prefix,
          s = t.icons.join(","),
          u = new URLSearchParams({ icons: s });
        r += i + ".json?" + u.toString();
        break;
      }
      case "custom": {
        const i = t.uri;
        r += i.slice(0, 1) === "/" ? i.slice(1) : i;
        break;
      }
      default:
        n("abort", 400);
        return;
    }
    let o = 503;
    Xc(e + r)
      .then((i) => {
        const l = i.status;
        if (l !== 200) {
          setTimeout(() => {
            n(sS(l) ? "abort" : "next", l);
          });
          return;
        }
        return (o = 501), i.json();
      })
      .then((i) => {
        if (typeof i != "object" || i === null) {
          setTimeout(() => {
            i === 404 ? n("abort", i) : n("next", o);
          });
          return;
        }
        setTimeout(() => {
          n("success", i);
        });
      })
      .catch(() => {
        n("next", o);
      });
  },
  dS = { prepare: uS, send: cS };
function fS(e) {
  const t = { loaded: [], missing: [], pending: [] },
    n = Object.create(null);
  e.sort((o, i) =>
    o.provider !== i.provider
      ? o.provider.localeCompare(i.provider)
      : o.prefix !== i.prefix
      ? o.prefix.localeCompare(i.prefix)
      : o.name.localeCompare(i.name)
  );
  let r = { provider: "", prefix: "", name: "" };
  return (
    e.forEach((o) => {
      if (
        r.name === o.name &&
        r.prefix === o.prefix &&
        r.provider === o.provider
      )
        return;
      r = o;
      const i = o.provider,
        l = o.prefix,
        s = o.name,
        u = n[i] || (n[i] = Object.create(null)),
        a = u[l] || (u[l] = nn(i, l));
      let c;
      s in a.icons
        ? (c = t.loaded)
        : l === "" || a.missing.has(s)
        ? (c = t.missing)
        : (c = t.pending);
      const f = { provider: i, prefix: l, name: s };
      c.push(f);
    }),
    t
  );
}
function vh(e, t) {
  e.forEach((n) => {
    const r = n.loaderCallbacks;
    r && (n.loaderCallbacks = r.filter((o) => o.id !== t));
  });
}
function pS(e) {
  e.pendingCallbacksFlag ||
    ((e.pendingCallbacksFlag = !0),
    setTimeout(() => {
      e.pendingCallbacksFlag = !1;
      const t = e.loaderCallbacks ? e.loaderCallbacks.slice(0) : [];
      if (!t.length) return;
      let n = !1;
      const r = e.provider,
        o = e.prefix;
      t.forEach((i) => {
        const l = i.icons,
          s = l.pending.length;
        (l.pending = l.pending.filter((u) => {
          if (u.prefix !== o) return !0;
          const a = u.name;
          if (e.icons[a]) l.loaded.push({ provider: r, prefix: o, name: a });
          else if (e.missing.has(a))
            l.missing.push({ provider: r, prefix: o, name: a });
          else return (n = !0), !0;
          return !1;
        })),
          l.pending.length !== s &&
            (n || vh([e], i.id),
            i.callback(
              l.loaded.slice(0),
              l.missing.slice(0),
              l.pending.slice(0),
              i.abort
            ));
      });
    }));
}
let hS = 0;
function gS(e, t, n) {
  const r = hS++,
    o = vh.bind(null, n, r);
  if (!t.pending.length) return o;
  const i = { id: r, icons: t, callback: e, abort: o };
  return (
    n.forEach((l) => {
      (l.loaderCallbacks || (l.loaderCallbacks = [])).push(i);
    }),
    o
  );
}
function mS(e, t = !0, n = !1) {
  const r = [];
  return (
    e.forEach((o) => {
      const i = typeof o == "string" ? ji(o, t, n) : o;
      i && r.push(i);
    }),
    r
  );
}
var vS = {
  resources: [],
  index: 0,
  timeout: 2e3,
  rotate: 750,
  random: !1,
  dataAfterTimeout: !1,
};
function yS(e, t, n, r) {
  const o = e.resources.length,
    i = e.random ? Math.floor(Math.random() * o) : e.index;
  let l;
  if (e.random) {
    let x = e.resources.slice(0);
    for (l = []; x.length > 1; ) {
      const k = Math.floor(Math.random() * x.length);
      l.push(x[k]), (x = x.slice(0, k).concat(x.slice(k + 1)));
    }
    l = l.concat(x);
  } else l = e.resources.slice(i).concat(e.resources.slice(0, i));
  const s = Date.now();
  let u = "pending",
    a = 0,
    c,
    f = null,
    p = [],
    y = [];
  typeof r == "function" && y.push(r);
  function S() {
    f && (clearTimeout(f), (f = null));
  }
  function m() {
    u === "pending" && (u = "aborted"),
      S(),
      p.forEach((x) => {
        x.status === "pending" && (x.status = "aborted");
      }),
      (p = []);
  }
  function C(x, k) {
    k && (y = []), typeof x == "function" && y.push(x);
  }
  function h() {
    return {
      startTime: s,
      payload: t,
      status: u,
      queriesSent: a,
      queriesPending: p.length,
      subscribe: C,
      abort: m,
    };
  }
  function d() {
    (u = "failed"),
      y.forEach((x) => {
        x(void 0, c);
      });
  }
  function v() {
    p.forEach((x) => {
      x.status === "pending" && (x.status = "aborted");
    }),
      (p = []);
  }
  function w(x, k, O) {
    const _ = k !== "success";
    switch (((p = p.filter((R) => R !== x)), u)) {
      case "pending":
        break;
      case "failed":
        if (_ || !e.dataAfterTimeout) return;
        break;
      default:
        return;
    }
    if (k === "abort") {
      (c = O), d();
      return;
    }
    if (_) {
      (c = O), p.length || (l.length ? E() : d());
      return;
    }
    if ((S(), v(), !e.random)) {
      const R = e.resources.indexOf(x.resource);
      R !== -1 && R !== e.index && (e.index = R);
    }
    (u = "completed"),
      y.forEach((R) => {
        R(O);
      });
  }
  function E() {
    if (u !== "pending") return;
    S();
    const x = l.shift();
    if (x === void 0) {
      if (p.length) {
        f = setTimeout(() => {
          S(), u === "pending" && (v(), d());
        }, e.timeout);
        return;
      }
      d();
      return;
    }
    const k = {
      status: "pending",
      resource: x,
      callback: (O, _) => {
        w(k, O, _);
      },
    };
    p.push(k), a++, (f = setTimeout(E, e.rotate)), n(x, t, k.callback);
  }
  return setTimeout(E), h;
}
function yh(e) {
  const t = { ...vS, ...e };
  let n = [];
  function r() {
    n = n.filter((s) => s().status === "pending");
  }
  function o(s, u, a) {
    const c = yS(t, s, u, (f, p) => {
      r(), a && a(f, p);
    });
    return n.push(c), c;
  }
  function i(s) {
    return n.find((u) => s(u)) || null;
  }
  return {
    query: o,
    find: i,
    setIndex: (s) => {
      t.index = s;
    },
    getIndex: () => t.index,
    cleanup: r,
  };
}
function Zc() {}
const Cl = Object.create(null);
function SS(e) {
  if (!Cl[e]) {
    const t = aa(e);
    if (!t) return;
    const n = yh(t),
      r = { config: t, redundancy: n };
    Cl[e] = r;
  }
  return Cl[e];
}
function wS(e, t, n) {
  let r, o;
  if (typeof e == "string") {
    const i = js(e);
    if (!i) return n(void 0, 424), Zc;
    o = i.send;
    const l = SS(e);
    l && (r = l.redundancy);
  } else {
    const i = sa(e);
    if (i) {
      r = yh(i);
      const l = e.resources ? e.resources[0] : "",
        s = js(l);
      s && (o = s.send);
    }
  }
  return !r || !o ? (n(void 0, 424), Zc) : r.query(t, o, n)().abort;
}
const qc = "iconify2",
  Ar = "iconify",
  Sh = Ar + "-count",
  Jc = Ar + "-version",
  wh = 36e5,
  xS = 168;
function As(e, t) {
  try {
    return e.getItem(t);
  } catch {}
}
function ca(e, t, n) {
  try {
    return e.setItem(t, n), !0;
  } catch {}
}
function ed(e, t) {
  try {
    e.removeItem(t);
  } catch {}
}
function Bs(e, t) {
  return ca(e, Sh, t.toString());
}
function Us(e) {
  return parseInt(As(e, Sh)) || 0;
}
const Ai = { local: !0, session: !0 },
  xh = { local: new Set(), session: new Set() };
let da = !1;
function ES(e) {
  da = e;
}
let So = typeof window == "undefined" ? {} : window;
function Eh(e) {
  const t = e + "Storage";
  try {
    if (So && So[t] && typeof So[t].length == "number") return So[t];
  } catch {}
  Ai[e] = !1;
}
function Ch(e, t) {
  const n = Eh(e);
  if (!n) return;
  const r = As(n, Jc);
  if (r !== qc) {
    if (r) {
      const s = Us(n);
      for (let u = 0; u < s; u++) ed(n, Ar + u.toString());
    }
    ca(n, Jc, qc), Bs(n, 0);
    return;
  }
  const o = Math.floor(Date.now() / wh) - xS,
    i = (s) => {
      const u = Ar + s.toString(),
        a = As(n, u);
      if (typeof a == "string") {
        try {
          const c = JSON.parse(a);
          if (
            typeof c == "object" &&
            typeof c.cached == "number" &&
            c.cached > o &&
            typeof c.provider == "string" &&
            typeof c.data == "object" &&
            typeof c.data.prefix == "string" &&
            t(c, s)
          )
            return !0;
        } catch {}
        ed(n, u);
      }
    };
  let l = Us(n);
  for (let s = l - 1; s >= 0; s--)
    i(s) || (s === l - 1 ? (l--, Bs(n, l)) : xh[e].add(s));
}
function kh() {
  if (!da) {
    ES(!0);
    for (const e in Ai)
      Ch(e, (t) => {
        const n = t.data,
          r = t.provider,
          o = n.prefix,
          i = nn(r, o);
        if (!la(i, n).length) return !1;
        const l = n.lastModified || -1;
        return (
          (i.lastModifiedCached = i.lastModifiedCached
            ? Math.min(i.lastModifiedCached, l)
            : l),
          !0
        );
      });
  }
}
function CS(e, t) {
  const n = e.lastModifiedCached;
  if (n && n >= t) return n === t;
  if (((e.lastModifiedCached = t), n))
    for (const r in Ai)
      Ch(r, (o) => {
        const i = o.data;
        return (
          o.provider !== e.provider ||
          i.prefix !== e.prefix ||
          i.lastModified === t
        );
      });
  return !0;
}
function kS(e, t) {
  da || kh();
  function n(r) {
    let o;
    if (!Ai[r] || !(o = Eh(r))) return;
    const i = xh[r];
    let l;
    if (i.size) i.delete((l = Array.from(i).shift()));
    else if (((l = Us(o)), !Bs(o, l + 1))) return;
    const s = {
      cached: Math.floor(Date.now() / wh),
      provider: e.provider,
      data: t,
    };
    return ca(o, Ar + l.toString(), JSON.stringify(s));
  }
  (t.lastModified && !CS(e, t.lastModified)) ||
    !Object.keys(t.icons).length ||
    (t.not_found && ((t = Object.assign({}, t)), delete t.not_found),
    n("local") || n("session"));
}
function td() {}
function OS(e) {
  e.iconsLoaderFlag ||
    ((e.iconsLoaderFlag = !0),
    setTimeout(() => {
      (e.iconsLoaderFlag = !1), pS(e);
    }));
}
function TS(e, t) {
  e.iconsToLoad
    ? (e.iconsToLoad = e.iconsToLoad.concat(t).sort())
    : (e.iconsToLoad = t),
    e.iconsQueueFlag ||
      ((e.iconsQueueFlag = !0),
      setTimeout(() => {
        e.iconsQueueFlag = !1;
        const { provider: n, prefix: r } = e,
          o = e.iconsToLoad;
        delete e.iconsToLoad;
        let i;
        if (!o || !(i = js(n))) return;
        i.prepare(n, r, o).forEach((s) => {
          wS(n, s, (u) => {
            if (typeof u != "object")
              s.icons.forEach((a) => {
                e.missing.add(a);
              });
            else
              try {
                const a = la(e, u);
                if (!a.length) return;
                const c = e.pendingIcons;
                c &&
                  a.forEach((f) => {
                    c.delete(f);
                  }),
                  kS(e, u);
              } catch (a) {
                console.error(a);
              }
            OS(e);
          });
        });
      }));
}
const PS = (e, t) => {
  const n = mS(e, !0, hh()),
    r = fS(n);
  if (!r.pending.length) {
    let u = !0;
    return (
      t &&
        setTimeout(() => {
          u && t(r.loaded, r.missing, r.pending, td);
        }),
      () => {
        u = !1;
      }
    );
  }
  const o = Object.create(null),
    i = [];
  let l, s;
  return (
    r.pending.forEach((u) => {
      const { provider: a, prefix: c } = u;
      if (c === s && a === l) return;
      (l = a), (s = c), i.push(nn(a, c));
      const f = o[a] || (o[a] = Object.create(null));
      f[c] || (f[c] = []);
    }),
    r.pending.forEach((u) => {
      const { provider: a, prefix: c, name: f } = u,
        p = nn(a, c),
        y = p.pendingIcons || (p.pendingIcons = new Set());
      y.has(f) || (y.add(f), o[a][c].push(f));
    }),
    i.forEach((u) => {
      const { provider: a, prefix: c } = u;
      o[a][c].length && TS(u, o[a][c]);
    }),
    t ? gS(t, r, i) : td
  );
};
function IS(e, t) {
  const n = { ...e };
  for (const r in t) {
    const o = t[r],
      i = typeof o;
    r in gh
      ? (o === null || (o && (i === "string" || i === "number"))) && (n[r] = o)
      : i === typeof n[r] && (n[r] = r === "rotate" ? o % 4 : o);
  }
  return n;
}
const DS = /[\s,]+/;
function $S(e, t) {
  t.split(DS).forEach((n) => {
    switch (n.trim()) {
      case "horizontal":
        e.hFlip = !0;
        break;
      case "vertical":
        e.vFlip = !0;
        break;
    }
  });
}
function RS(e, t = 0) {
  const n = e.replace(/^-?[0-9.]*/, "");
  function r(o) {
    for (; o < 0; ) o += 4;
    return o % 4;
  }
  if (n === "") {
    const o = parseInt(e);
    return isNaN(o) ? 0 : r(o);
  } else if (n !== e) {
    let o = 0;
    switch (n) {
      case "%":
        o = 25;
        break;
      case "deg":
        o = 90;
    }
    if (o) {
      let i = parseFloat(e.slice(0, e.length - n.length));
      return isNaN(i) ? 0 : ((i = i / o), i % 1 === 0 ? r(i) : 0);
    }
  }
  return t;
}
function _S(e, t) {
  let n =
    e.indexOf("xlink:") === -1
      ? ""
      : ' xmlns:xlink="http://www.w3.org/1999/xlink"';
  for (const r in t) n += " " + r + '="' + t[r] + '"';
  return '<svg xmlns="http://www.w3.org/2000/svg"' + n + ">" + e + "</svg>";
}
function NS(e) {
  return e
    .replace(/"/g, "'")
    .replace(/%/g, "%25")
    .replace(/#/g, "%23")
    .replace(/</g, "%3C")
    .replace(/>/g, "%3E")
    .replace(/\s+/g, " ");
}
function bS(e) {
  return 'url("data:image/svg+xml,' + NS(e) + '")';
}
const Oh = { ...mh, inline: !1 },
  MS = {
    xmlns: "http://www.w3.org/2000/svg",
    xmlnsXlink: "http://www.w3.org/1999/xlink",
    "aria-hidden": !0,
    role: "img",
  },
  LS = { display: "inline-block" },
  Ws = { backgroundColor: "currentColor" },
  Th = { backgroundColor: "transparent" },
  nd = { Image: "var(--svg)", Repeat: "no-repeat", Size: "100% 100%" },
  rd = { webkitMask: Ws, mask: Ws, background: Th };
for (const e in rd) {
  const t = rd[e];
  for (const n in nd) t[e + n] = nd[n];
}
const FS = { ...Oh, inline: !0 };
function od(e) {
  return e + (e.match(/^[-0-9.]+$/) ? "px" : "");
}
const zS = (e, t, n, r) => {
  const o = n ? FS : Oh,
    i = IS(o, t),
    l = t.mode || "svg",
    s = {},
    u = t.style || {},
    a = { ...(l === "svg" ? MS : {}), ref: r };
  for (let h in t) {
    const d = t[h];
    if (d !== void 0)
      switch (h) {
        case "icon":
        case "style":
        case "children":
        case "onLoad":
        case "mode":
        case "_ref":
        case "_inline":
          break;
        case "inline":
        case "hFlip":
        case "vFlip":
          i[h] = d === !0 || d === "true" || d === 1;
          break;
        case "flip":
          typeof d == "string" && $S(i, d);
          break;
        case "color":
          s.color = d;
          break;
        case "rotate":
          typeof d == "string"
            ? (i[h] = RS(d))
            : typeof d == "number" && (i[h] = d);
          break;
        case "ariaHidden":
        case "aria-hidden":
          d !== !0 && d !== "true" && delete a["aria-hidden"];
          break;
        default:
          o[h] === void 0 && (a[h] = d);
      }
  }
  const c = q1(e, i),
    f = c.attributes;
  if ((i.inline && (s.verticalAlign = "-0.125em"), l === "svg")) {
    (a.style = { ...s, ...u }), Object.assign(a, f);
    let h = 0,
      d = t.id;
    return (
      typeof d == "string" && (d = d.replace(/-/g, "_")),
      (a.dangerouslySetInnerHTML = {
        __html: nS(c.body, d ? () => d + "ID" + h++ : "iconifyReact"),
      }),
      me.createElement("svg", a)
    );
  }
  const { body: p, width: y, height: S } = e,
    m = l === "mask" || (l === "bg" ? !1 : p.indexOf("currentColor") !== -1),
    C = _S(p, { ...f, width: y + "", height: S + "" });
  return (
    (a.style = {
      ...s,
      "--svg": bS(C),
      width: od(f.width),
      height: od(f.height),
      ...LS,
      ...(m ? Ws : Th),
      ...u,
    }),
    me.createElement("span", a)
  );
};
hh(!0);
rS("", dS);
if (typeof document != "undefined" && typeof window != "undefined") {
  kh();
  const e = window;
  if (e.IconifyPreload !== void 0) {
    const t = e.IconifyPreload,
      n = "Invalid IconifyPreload syntax.";
    typeof t == "object" &&
      t !== null &&
      (t instanceof Array ? t : [t]).forEach((r) => {
        try {
          (typeof r != "object" ||
            r === null ||
            r instanceof Array ||
            typeof r.icons != "object" ||
            typeof r.prefix != "string" ||
            !K1(r)) &&
            console.error(n);
        } catch {
          console.error(n);
        }
      });
  }
  if (e.IconifyProviders !== void 0) {
    const t = e.IconifyProviders;
    if (typeof t == "object" && t !== null)
      for (let n in t) {
        const r = "IconifyProviders[" + n + "] is invalid.";
        try {
          const o = t[n];
          if (typeof o != "object" || !o || o.resources === void 0) continue;
          oS(n, o) || console.error(r);
        } catch {
          console.error(r);
        }
      }
  }
}
class Ph extends me.Component {
  constructor(t) {
    super(t), (this.state = { icon: null });
  }
  _abortLoading() {
    this._loading && (this._loading.abort(), (this._loading = null));
  }
  _setData(t) {
    this.state.icon !== t && this.setState({ icon: t });
  }
  _checkIcon(t) {
    const n = this.state,
      r = this.props.icon;
    if (typeof r == "object" && r !== null && typeof r.body == "string") {
      (this._icon = ""),
        this._abortLoading(),
        (t || n.icon === null) && this._setData({ data: r });
      return;
    }
    let o;
    if (typeof r != "string" || (o = ji(r, !1, !0)) === null) {
      this._abortLoading(), this._setData(null);
      return;
    }
    const i = Q1(o);
    if (!i) {
      (!this._loading || this._loading.name !== r) &&
        (this._abortLoading(),
        (this._icon = ""),
        this._setData(null),
        i !== null &&
          (this._loading = {
            name: r,
            abort: PS([o], this._checkIcon.bind(this, !1)),
          }));
      return;
    }
    if (this._icon !== r || n.icon === null) {
      this._abortLoading(), (this._icon = r);
      const l = ["iconify"];
      o.prefix !== "" && l.push("iconify--" + o.prefix),
        o.provider !== "" && l.push("iconify--" + o.provider),
        this._setData({ data: i, classes: l }),
        this.props.onLoad && this.props.onLoad(r);
    }
  }
  componentDidMount() {
    this._checkIcon(!1);
  }
  componentDidUpdate(t) {
    t.icon !== this.props.icon && this._checkIcon(!0);
  }
  componentWillUnmount() {
    this._abortLoading();
  }
  render() {
    const t = this.props,
      n = this.state.icon;
    if (n === null)
      return t.children ? t.children : me.createElement("span", {});
    let r = t;
    return (
      n.classes &&
        (r = {
          ...t,
          className:
            (typeof t.className == "string" ? t.className + " " : "") +
            n.classes.join(" "),
        }),
      zS({ ...ia, ...n.data }, r, t._inline, t._ref)
    );
  }
}
const jS = me.forwardRef(function (t, n) {
  const r = { ...t, _ref: n, _inline: !1 };
  return me.createElement(Ph, r);
});
me.forwardRef(function (t, n) {
  const r = { ...t, _ref: n, _inline: !0 };
  return me.createElement(Ph, r);
});
var id = "./assets/camera-icon.d1153860.svg";
function ie() {
  return (
    (ie = Object.assign
      ? Object.assign.bind()
      : function (e) {
          for (var t = 1; t < arguments.length; t++) {
            var n = arguments[t];
            for (var r in n)
              Object.prototype.hasOwnProperty.call(n, r) && (e[r] = n[r]);
          }
          return e;
        }),
    ie.apply(this, arguments)
  );
}
function Yt(e, t, { checkForDefaultPrevented: n = !0 } = {}) {
  return function (o) {
    if ((e == null || e(o), n === !1 || !o.defaultPrevented))
      return t == null ? void 0 : t(o);
  };
}
function AS(e, t) {
  typeof e == "function" ? e(t) : e != null && (e.current = t);
}
function Ih(...e) {
  return (t) => e.forEach((n) => AS(n, t));
}
function Zr(...e) {
  return g.exports.useCallback(Ih(...e), e);
}
function BS(e, t = []) {
  let n = [];
  function r(i, l) {
    const s = g.exports.createContext(l),
      u = n.length;
    n = [...n, l];
    function a(f) {
      const { scope: p, children: y, ...S } = f,
        m = (p == null ? void 0 : p[e][u]) || s,
        C = g.exports.useMemo(() => S, Object.values(S));
      return g.exports.createElement(m.Provider, { value: C }, y);
    }
    function c(f, p) {
      const y = (p == null ? void 0 : p[e][u]) || s,
        S = g.exports.useContext(y);
      if (S) return S;
      if (l !== void 0) return l;
      throw new Error(`\`${f}\` must be used within \`${i}\``);
    }
    return (a.displayName = i + "Provider"), [a, c];
  }
  const o = () => {
    const i = n.map((l) => g.exports.createContext(l));
    return function (s) {
      const u = (s == null ? void 0 : s[e]) || i;
      return g.exports.useMemo(
        () => ({ [`__scope${e}`]: { ...s, [e]: u } }),
        [s, u]
      );
    };
  };
  return (o.scopeName = e), [r, US(o, ...t)];
}
function US(...e) {
  const t = e[0];
  if (e.length === 1) return t;
  const n = () => {
    const r = e.map((o) => ({ useScope: o(), scopeName: o.scopeName }));
    return function (i) {
      const l = r.reduce((s, { useScope: u, scopeName: a }) => {
        const f = u(i)[`__scope${a}`];
        return { ...s, ...f };
      }, {});
      return g.exports.useMemo(() => ({ [`__scope${t.scopeName}`]: l }), [l]);
    };
  };
  return (n.scopeName = t.scopeName), n;
}
const Hs = Boolean(globalThis == null ? void 0 : globalThis.document)
    ? g.exports.useLayoutEffect
    : () => {},
  WS = Wo["useId".toString()] || (() => {});
let HS = 0;
function kl(e) {
  const [t, n] = g.exports.useState(WS());
  return (
    Hs(() => {
      e || n((r) => (r != null ? r : String(HS++)));
    }, [e]),
    e || (t ? `radix-${t}` : "")
  );
}
function rn(e) {
  const t = g.exports.useRef(e);
  return (
    g.exports.useEffect(() => {
      t.current = e;
    }),
    g.exports.useMemo(
      () =>
        (...n) => {
          var r;
          return (r = t.current) === null || r === void 0
            ? void 0
            : r.call(t, ...n);
        },
      []
    )
  );
}
function VS({ prop: e, defaultProp: t, onChange: n = () => {} }) {
  const [r, o] = QS({ defaultProp: t, onChange: n }),
    i = e !== void 0,
    l = i ? e : r,
    s = rn(n),
    u = g.exports.useCallback(
      (a) => {
        if (i) {
          const f = typeof a == "function" ? a(e) : a;
          f !== e && s(f);
        } else o(a);
      },
      [i, e, o, s]
    );
  return [l, u];
}
function QS({ defaultProp: e, onChange: t }) {
  const n = g.exports.useState(e),
    [r] = n,
    o = g.exports.useRef(r),
    i = rn(t);
  return (
    g.exports.useEffect(() => {
      o.current !== r && (i(r), (o.current = r));
    }, [r, o, i]),
    n
  );
}
const fa = g.exports.forwardRef((e, t) => {
  const { children: n, ...r } = e,
    o = g.exports.Children.toArray(n),
    i = o.find(KS);
  if (i) {
    const l = i.props.children,
      s = o.map((u) =>
        u === i
          ? g.exports.Children.count(l) > 1
            ? g.exports.Children.only(null)
            : g.exports.isValidElement(l)
            ? l.props.children
            : null
          : u
      );
    return g.exports.createElement(
      Vs,
      ie({}, r, { ref: t }),
      g.exports.isValidElement(l) ? g.exports.cloneElement(l, void 0, s) : null
    );
  }
  return g.exports.createElement(Vs, ie({}, r, { ref: t }), n);
});
fa.displayName = "Slot";
const Vs = g.exports.forwardRef((e, t) => {
  const { children: n, ...r } = e;
  return g.exports.isValidElement(n)
    ? g.exports.cloneElement(n, { ...YS(r, n.props), ref: Ih(t, n.ref) })
    : g.exports.Children.count(n) > 1
    ? g.exports.Children.only(null)
    : null;
});
Vs.displayName = "SlotClone";
const GS = ({ children: e }) =>
  g.exports.createElement(g.exports.Fragment, null, e);
function KS(e) {
  return g.exports.isValidElement(e) && e.type === GS;
}
function YS(e, t) {
  const n = { ...t };
  for (const r in t) {
    const o = e[r],
      i = t[r];
    /^on[A-Z]/.test(r)
      ? o && i
        ? (n[r] = (...s) => {
            i(...s), o(...s);
          })
        : o && (n[r] = o)
      : r === "style"
      ? (n[r] = { ...o, ...i })
      : r === "className" && (n[r] = [o, i].filter(Boolean).join(" "));
  }
  return { ...e, ...n };
}
const XS = [
    "a",
    "button",
    "div",
    "form",
    "h2",
    "h3",
    "img",
    "input",
    "label",
    "li",
    "nav",
    "ol",
    "p",
    "span",
    "svg",
    "ul",
  ],
  un = XS.reduce((e, t) => {
    const n = g.exports.forwardRef((r, o) => {
      const { asChild: i, ...l } = r,
        s = i ? fa : t;
      return (
        g.exports.useEffect(() => {
          window[Symbol.for("radix-ui")] = !0;
        }, []),
        g.exports.createElement(s, ie({}, l, { ref: o }))
      );
    });
    return (n.displayName = `Primitive.${t}`), { ...e, [t]: n };
  }, {});
function ZS(e, t) {
  e && Ur.exports.flushSync(() => e.dispatchEvent(t));
}
function qS(e, t = globalThis == null ? void 0 : globalThis.document) {
  const n = rn(e);
  g.exports.useEffect(() => {
    const r = (o) => {
      o.key === "Escape" && n(o);
    };
    return (
      t.addEventListener("keydown", r),
      () => t.removeEventListener("keydown", r)
    );
  }, [n, t]);
}
const Qs = "dismissableLayer.update",
  JS = "dismissableLayer.pointerDownOutside",
  ew = "dismissableLayer.focusOutside";
let ld;
const tw = g.exports.createContext({
    layers: new Set(),
    layersWithOutsidePointerEventsDisabled: new Set(),
    branches: new Set(),
  }),
  nw = g.exports.forwardRef((e, t) => {
    var n;
    const {
        disableOutsidePointerEvents: r = !1,
        onEscapeKeyDown: o,
        onPointerDownOutside: i,
        onFocusOutside: l,
        onInteractOutside: s,
        onDismiss: u,
        ...a
      } = e,
      c = g.exports.useContext(tw),
      [f, p] = g.exports.useState(null),
      y =
        (n = f == null ? void 0 : f.ownerDocument) !== null && n !== void 0
          ? n
          : globalThis == null
          ? void 0
          : globalThis.document,
      [, S] = g.exports.useState({}),
      m = Zr(t, (O) => p(O)),
      C = Array.from(c.layers),
      [h] = [...c.layersWithOutsidePointerEventsDisabled].slice(-1),
      d = C.indexOf(h),
      v = f ? C.indexOf(f) : -1,
      w = c.layersWithOutsidePointerEventsDisabled.size > 0,
      E = v >= d,
      x = rw((O) => {
        const _ = O.target,
          R = [...c.branches].some((z) => z.contains(_));
        !E ||
          R ||
          (i == null || i(O),
          s == null || s(O),
          O.defaultPrevented || u == null || u());
      }, y),
      k = ow((O) => {
        const _ = O.target;
        [...c.branches].some((z) => z.contains(_)) ||
          (l == null || l(O),
          s == null || s(O),
          O.defaultPrevented || u == null || u());
      }, y);
    return (
      qS((O) => {
        v === c.layers.size - 1 &&
          (o == null || o(O),
          !O.defaultPrevented && u && (O.preventDefault(), u()));
      }, y),
      g.exports.useEffect(() => {
        if (!!f)
          return (
            r &&
              (c.layersWithOutsidePointerEventsDisabled.size === 0 &&
                ((ld = y.body.style.pointerEvents),
                (y.body.style.pointerEvents = "none")),
              c.layersWithOutsidePointerEventsDisabled.add(f)),
            c.layers.add(f),
            sd(),
            () => {
              r &&
                c.layersWithOutsidePointerEventsDisabled.size === 1 &&
                (y.body.style.pointerEvents = ld);
            }
          );
      }, [f, y, r, c]),
      g.exports.useEffect(
        () => () => {
          !f ||
            (c.layers.delete(f),
            c.layersWithOutsidePointerEventsDisabled.delete(f),
            sd());
        },
        [f, c]
      ),
      g.exports.useEffect(() => {
        const O = () => S({});
        return (
          document.addEventListener(Qs, O),
          () => document.removeEventListener(Qs, O)
        );
      }, []),
      g.exports.createElement(
        un.div,
        ie({}, a, {
          ref: m,
          style: {
            pointerEvents: w ? (E ? "auto" : "none") : void 0,
            ...e.style,
          },
          onFocusCapture: Yt(e.onFocusCapture, k.onFocusCapture),
          onBlurCapture: Yt(e.onBlurCapture, k.onBlurCapture),
          onPointerDownCapture: Yt(
            e.onPointerDownCapture,
            x.onPointerDownCapture
          ),
        })
      )
    );
  });
function rw(e, t = globalThis == null ? void 0 : globalThis.document) {
  const n = rn(e),
    r = g.exports.useRef(!1),
    o = g.exports.useRef(() => {});
  return (
    g.exports.useEffect(() => {
      const i = (s) => {
          if (s.target && !r.current) {
            let c = function () {
              Dh(JS, n, a, { discrete: !0 });
            };
            var u = c;
            const a = { originalEvent: s };
            s.pointerType === "touch"
              ? (t.removeEventListener("click", o.current),
                (o.current = c),
                t.addEventListener("click", o.current, { once: !0 }))
              : c();
          }
          r.current = !1;
        },
        l = window.setTimeout(() => {
          t.addEventListener("pointerdown", i);
        }, 0);
      return () => {
        window.clearTimeout(l),
          t.removeEventListener("pointerdown", i),
          t.removeEventListener("click", o.current);
      };
    }, [t, n]),
    { onPointerDownCapture: () => (r.current = !0) }
  );
}
function ow(e, t = globalThis == null ? void 0 : globalThis.document) {
  const n = rn(e),
    r = g.exports.useRef(!1);
  return (
    g.exports.useEffect(() => {
      const o = (i) => {
        i.target &&
          !r.current &&
          Dh(ew, n, { originalEvent: i }, { discrete: !1 });
      };
      return (
        t.addEventListener("focusin", o),
        () => t.removeEventListener("focusin", o)
      );
    }, [t, n]),
    {
      onFocusCapture: () => (r.current = !0),
      onBlurCapture: () => (r.current = !1),
    }
  );
}
function sd() {
  const e = new CustomEvent(Qs);
  document.dispatchEvent(e);
}
function Dh(e, t, n, { discrete: r }) {
  const o = n.originalEvent.target,
    i = new CustomEvent(e, { bubbles: !1, cancelable: !0, detail: n });
  t && o.addEventListener(e, t, { once: !0 }),
    r ? ZS(o, i) : o.dispatchEvent(i);
}
const Ol = "focusScope.autoFocusOnMount",
  Tl = "focusScope.autoFocusOnUnmount",
  ud = { bubbles: !1, cancelable: !0 },
  iw = g.exports.forwardRef((e, t) => {
    const {
        loop: n = !1,
        trapped: r = !1,
        onMountAutoFocus: o,
        onUnmountAutoFocus: i,
        ...l
      } = e,
      [s, u] = g.exports.useState(null),
      a = rn(o),
      c = rn(i),
      f = g.exports.useRef(null),
      p = Zr(t, (m) => u(m)),
      y = g.exports.useRef({
        paused: !1,
        pause() {
          this.paused = !0;
        },
        resume() {
          this.paused = !1;
        },
      }).current;
    g.exports.useEffect(() => {
      if (r) {
        let h = function (v) {
            if (y.paused || !s) return;
            const w = v.target;
            s.contains(w) ? (f.current = w) : At(f.current, { select: !0 });
          },
          d = function (v) {
            y.paused ||
              !s ||
              s.contains(v.relatedTarget) ||
              At(f.current, { select: !0 });
          };
        var C = h,
          m = d;
        return (
          document.addEventListener("focusin", h),
          document.addEventListener("focusout", d),
          () => {
            document.removeEventListener("focusin", h),
              document.removeEventListener("focusout", d);
          }
        );
      }
    }, [r, s, y.paused]),
      g.exports.useEffect(() => {
        if (s) {
          cd.add(y);
          const m = document.activeElement;
          if (!s.contains(m)) {
            const h = new CustomEvent(Ol, ud);
            s.addEventListener(Ol, a),
              s.dispatchEvent(h),
              h.defaultPrevented ||
                (lw(dw($h(s)), { select: !0 }),
                document.activeElement === m && At(s));
          }
          return () => {
            s.removeEventListener(Ol, a),
              setTimeout(() => {
                const h = new CustomEvent(Tl, ud);
                s.addEventListener(Tl, c),
                  s.dispatchEvent(h),
                  h.defaultPrevented ||
                    At(m != null ? m : document.body, { select: !0 }),
                  s.removeEventListener(Tl, c),
                  cd.remove(y);
              }, 0);
          };
        }
      }, [s, a, c, y]);
    const S = g.exports.useCallback(
      (m) => {
        if ((!n && !r) || y.paused) return;
        const C = m.key === "Tab" && !m.altKey && !m.ctrlKey && !m.metaKey,
          h = document.activeElement;
        if (C && h) {
          const d = m.currentTarget,
            [v, w] = sw(d);
          v && w
            ? !m.shiftKey && h === w
              ? (m.preventDefault(), n && At(v, { select: !0 }))
              : m.shiftKey &&
                h === v &&
                (m.preventDefault(), n && At(w, { select: !0 }))
            : h === d && m.preventDefault();
        }
      },
      [n, r, y.paused]
    );
    return g.exports.createElement(
      un.div,
      ie({ tabIndex: -1 }, l, { ref: p, onKeyDown: S })
    );
  });
function lw(e, { select: t = !1 } = {}) {
  const n = document.activeElement;
  for (const r of e)
    if ((At(r, { select: t }), document.activeElement !== n)) return;
}
function sw(e) {
  const t = $h(e),
    n = ad(t, e),
    r = ad(t.reverse(), e);
  return [n, r];
}
function $h(e) {
  const t = [],
    n = document.createTreeWalker(e, NodeFilter.SHOW_ELEMENT, {
      acceptNode: (r) => {
        const o = r.tagName === "INPUT" && r.type === "hidden";
        return r.disabled || r.hidden || o
          ? NodeFilter.FILTER_SKIP
          : r.tabIndex >= 0
          ? NodeFilter.FILTER_ACCEPT
          : NodeFilter.FILTER_SKIP;
      },
    });
  for (; n.nextNode(); ) t.push(n.currentNode);
  return t;
}
function ad(e, t) {
  for (const n of e) if (!uw(n, { upTo: t })) return n;
}
function uw(e, { upTo: t }) {
  if (getComputedStyle(e).visibility === "hidden") return !0;
  for (; e; ) {
    if (t !== void 0 && e === t) return !1;
    if (getComputedStyle(e).display === "none") return !0;
    e = e.parentElement;
  }
  return !1;
}
function aw(e) {
  return e instanceof HTMLInputElement && "select" in e;
}
function At(e, { select: t = !1 } = {}) {
  if (e && e.focus) {
    const n = document.activeElement;
    e.focus({ preventScroll: !0 }), e !== n && aw(e) && t && e.select();
  }
}
const cd = cw();
function cw() {
  let e = [];
  return {
    add(t) {
      const n = e[0];
      t !== n && (n == null || n.pause()), (e = dd(e, t)), e.unshift(t);
    },
    remove(t) {
      var n;
      (e = dd(e, t)), (n = e[0]) === null || n === void 0 || n.resume();
    },
  };
}
function dd(e, t) {
  const n = [...e],
    r = n.indexOf(t);
  return r !== -1 && n.splice(r, 1), n;
}
function dw(e) {
  return e.filter((t) => t.tagName !== "A");
}
const fw = g.exports.forwardRef((e, t) => {
  var n;
  const {
    container: r = globalThis == null ||
    (n = globalThis.document) === null ||
    n === void 0
      ? void 0
      : n.body,
    ...o
  } = e;
  return r
    ? fv.createPortal(g.exports.createElement(un.div, ie({}, o, { ref: t })), r)
    : null;
});
function pw(e, t) {
  return g.exports.useReducer((n, r) => {
    const o = t[n][r];
    return o != null ? o : n;
  }, e);
}
const Bi = (e) => {
  const { present: t, children: n } = e,
    r = hw(t),
    o =
      typeof n == "function"
        ? n({ present: r.isPresent })
        : g.exports.Children.only(n),
    i = Zr(r.ref, o.ref);
  return typeof n == "function" || r.isPresent
    ? g.exports.cloneElement(o, { ref: i })
    : null;
};
Bi.displayName = "Presence";
function hw(e) {
  const [t, n] = g.exports.useState(),
    r = g.exports.useRef({}),
    o = g.exports.useRef(e),
    i = g.exports.useRef("none"),
    l = e ? "mounted" : "unmounted",
    [s, u] = pw(l, {
      mounted: { UNMOUNT: "unmounted", ANIMATION_OUT: "unmountSuspended" },
      unmountSuspended: { MOUNT: "mounted", ANIMATION_END: "unmounted" },
      unmounted: { MOUNT: "mounted" },
    });
  return (
    g.exports.useEffect(() => {
      const a = wo(r.current);
      i.current = s === "mounted" ? a : "none";
    }, [s]),
    Hs(() => {
      const a = r.current,
        c = o.current;
      if (c !== e) {
        const p = i.current,
          y = wo(a);
        e
          ? u("MOUNT")
          : y === "none" || (a == null ? void 0 : a.display) === "none"
          ? u("UNMOUNT")
          : u(c && p !== y ? "ANIMATION_OUT" : "UNMOUNT"),
          (o.current = e);
      }
    }, [e, u]),
    Hs(() => {
      if (t) {
        const a = (f) => {
            const y = wo(r.current).includes(f.animationName);
            f.target === t &&
              y &&
              Ur.exports.flushSync(() => u("ANIMATION_END"));
          },
          c = (f) => {
            f.target === t && (i.current = wo(r.current));
          };
        return (
          t.addEventListener("animationstart", c),
          t.addEventListener("animationcancel", a),
          t.addEventListener("animationend", a),
          () => {
            t.removeEventListener("animationstart", c),
              t.removeEventListener("animationcancel", a),
              t.removeEventListener("animationend", a);
          }
        );
      } else u("ANIMATION_END");
    }, [t, u]),
    {
      isPresent: ["mounted", "unmountSuspended"].includes(s),
      ref: g.exports.useCallback((a) => {
        a && (r.current = getComputedStyle(a)), n(a);
      }, []),
    }
  );
}
function wo(e) {
  return (e == null ? void 0 : e.animationName) || "none";
}
let Pl = 0;
function gw() {
  g.exports.useEffect(() => {
    var e, t;
    const n = document.querySelectorAll("[data-radix-focus-guard]");
    return (
      document.body.insertAdjacentElement(
        "afterbegin",
        (e = n[0]) !== null && e !== void 0 ? e : fd()
      ),
      document.body.insertAdjacentElement(
        "beforeend",
        (t = n[1]) !== null && t !== void 0 ? t : fd()
      ),
      Pl++,
      () => {
        Pl === 1 &&
          document
            .querySelectorAll("[data-radix-focus-guard]")
            .forEach((r) => r.remove()),
          Pl--;
      }
    );
  }, []);
}
function fd() {
  const e = document.createElement("span");
  return (
    e.setAttribute("data-radix-focus-guard", ""),
    (e.tabIndex = 0),
    (e.style.cssText =
      "outline: none; opacity: 0; position: fixed; pointer-events: none"),
    e
  );
}
var Ze = function () {
  return (
    (Ze =
      Object.assign ||
      function (t) {
        for (var n, r = 1, o = arguments.length; r < o; r++) {
          n = arguments[r];
          for (var i in n)
            Object.prototype.hasOwnProperty.call(n, i) && (t[i] = n[i]);
        }
        return t;
      }),
    Ze.apply(this, arguments)
  );
};
function Rh(e, t) {
  var n = {};
  for (var r in e)
    Object.prototype.hasOwnProperty.call(e, r) &&
      t.indexOf(r) < 0 &&
      (n[r] = e[r]);
  if (e != null && typeof Object.getOwnPropertySymbols == "function")
    for (var o = 0, r = Object.getOwnPropertySymbols(e); o < r.length; o++)
      t.indexOf(r[o]) < 0 &&
        Object.prototype.propertyIsEnumerable.call(e, r[o]) &&
        (n[r[o]] = e[r[o]]);
  return n;
}
function mw(e, t, n) {
  if (n || arguments.length === 2)
    for (var r = 0, o = t.length, i; r < o; r++)
      (i || !(r in t)) &&
        (i || (i = Array.prototype.slice.call(t, 0, r)), (i[r] = t[r]));
  return e.concat(i || Array.prototype.slice.call(t));
}
var Bo = "right-scroll-bar-position",
  Uo = "width-before-scroll-bar",
  vw = "with-scroll-bars-hidden",
  yw = "--removed-body-scroll-bar-size";
function Sw(e, t) {
  return typeof e == "function" ? e(t) : e && (e.current = t), e;
}
function ww(e, t) {
  var n = g.exports.useState(function () {
    return {
      value: e,
      callback: t,
      facade: {
        get current() {
          return n.value;
        },
        set current(r) {
          var o = n.value;
          o !== r && ((n.value = r), n.callback(r, o));
        },
      },
    };
  })[0];
  return (n.callback = t), n.facade;
}
function xw(e, t) {
  return ww(t || null, function (n) {
    return e.forEach(function (r) {
      return Sw(r, n);
    });
  });
}
function Ew(e) {
  return e;
}
function Cw(e, t) {
  t === void 0 && (t = Ew);
  var n = [],
    r = !1,
    o = {
      read: function () {
        if (r)
          throw new Error(
            "Sidecar: could not `read` from an `assigned` medium. `read` could be used only with `useMedium`."
          );
        return n.length ? n[n.length - 1] : e;
      },
      useMedium: function (i) {
        var l = t(i, r);
        return (
          n.push(l),
          function () {
            n = n.filter(function (s) {
              return s !== l;
            });
          }
        );
      },
      assignSyncMedium: function (i) {
        for (r = !0; n.length; ) {
          var l = n;
          (n = []), l.forEach(i);
        }
        n = {
          push: function (s) {
            return i(s);
          },
          filter: function () {
            return n;
          },
        };
      },
      assignMedium: function (i) {
        r = !0;
        var l = [];
        if (n.length) {
          var s = n;
          (n = []), s.forEach(i), (l = n);
        }
        var u = function () {
            var c = l;
            (l = []), c.forEach(i);
          },
          a = function () {
            return Promise.resolve().then(u);
          };
        a(),
          (n = {
            push: function (c) {
              l.push(c), a();
            },
            filter: function (c) {
              return (l = l.filter(c)), n;
            },
          });
      },
    };
  return o;
}
function kw(e) {
  e === void 0 && (e = {});
  var t = Cw(null);
  return (t.options = Ze({ async: !0, ssr: !1 }, e)), t;
}
var _h = function (e) {
  var t = e.sideCar,
    n = Rh(e, ["sideCar"]);
  if (!t)
    throw new Error(
      "Sidecar: please provide `sideCar` property to import the right car"
    );
  var r = t.read();
  if (!r) throw new Error("Sidecar medium not found");
  return g.exports.createElement(r, Ze({}, n));
};
_h.isSideCarExport = !0;
function Ow(e, t) {
  return e.useMedium(t), _h;
}
var Nh = kw(),
  Il = function () {},
  Ui = g.exports.forwardRef(function (e, t) {
    var n = g.exports.useRef(null),
      r = g.exports.useState({
        onScrollCapture: Il,
        onWheelCapture: Il,
        onTouchMoveCapture: Il,
      }),
      o = r[0],
      i = r[1],
      l = e.forwardProps,
      s = e.children,
      u = e.className,
      a = e.removeScrollBar,
      c = e.enabled,
      f = e.shards,
      p = e.sideCar,
      y = e.noIsolation,
      S = e.inert,
      m = e.allowPinchZoom,
      C = e.as,
      h = C === void 0 ? "div" : C,
      d = Rh(e, [
        "forwardProps",
        "children",
        "className",
        "removeScrollBar",
        "enabled",
        "shards",
        "sideCar",
        "noIsolation",
        "inert",
        "allowPinchZoom",
        "as",
      ]),
      v = p,
      w = xw([n, t]),
      E = Ze(Ze({}, d), o);
    return g.exports.createElement(
      g.exports.Fragment,
      null,
      c &&
        g.exports.createElement(v, {
          sideCar: Nh,
          removeScrollBar: a,
          shards: f,
          noIsolation: y,
          inert: S,
          setCallbacks: i,
          allowPinchZoom: !!m,
          lockRef: n,
        }),
      l
        ? g.exports.cloneElement(
            g.exports.Children.only(s),
            Ze(Ze({}, E), { ref: w })
          )
        : g.exports.createElement(h, Ze({}, E, { className: u, ref: w }), s)
    );
  });
Ui.defaultProps = { enabled: !0, removeScrollBar: !0, inert: !1 };
Ui.classNames = { fullWidth: Uo, zeroRight: Bo };
var Tw = function () {
  if (typeof __webpack_nonce__ != "undefined") return __webpack_nonce__;
};
function Pw() {
  if (!document) return null;
  var e = document.createElement("style");
  e.type = "text/css";
  var t = Tw();
  return t && e.setAttribute("nonce", t), e;
}
function Iw(e, t) {
  e.styleSheet
    ? (e.styleSheet.cssText = t)
    : e.appendChild(document.createTextNode(t));
}
function Dw(e) {
  var t = document.head || document.getElementsByTagName("head")[0];
  t.appendChild(e);
}
var $w = function () {
    var e = 0,
      t = null;
    return {
      add: function (n) {
        e == 0 && (t = Pw()) && (Iw(t, n), Dw(t)), e++;
      },
      remove: function () {
        e--,
          !e && t && (t.parentNode && t.parentNode.removeChild(t), (t = null));
      },
    };
  },
  Rw = function () {
    var e = $w();
    return function (t, n) {
      g.exports.useEffect(
        function () {
          return (
            e.add(t),
            function () {
              e.remove();
            }
          );
        },
        [t && n]
      );
    };
  },
  bh = function () {
    var e = Rw(),
      t = function (n) {
        var r = n.styles,
          o = n.dynamic;
        return e(r, o), null;
      };
    return t;
  },
  _w = { left: 0, top: 0, right: 0, gap: 0 },
  Dl = function (e) {
    return parseInt(e || "", 10) || 0;
  },
  Nw = function (e) {
    var t = window.getComputedStyle(document.body),
      n = t[e === "padding" ? "paddingLeft" : "marginLeft"],
      r = t[e === "padding" ? "paddingTop" : "marginTop"],
      o = t[e === "padding" ? "paddingRight" : "marginRight"];
    return [Dl(n), Dl(r), Dl(o)];
  },
  bw = function (e) {
    if ((e === void 0 && (e = "margin"), typeof window == "undefined"))
      return _w;
    var t = Nw(e),
      n = document.documentElement.clientWidth,
      r = window.innerWidth;
    return {
      left: t[0],
      top: t[1],
      right: t[2],
      gap: Math.max(0, r - n + t[2] - t[0]),
    };
  },
  Mw = bh(),
  Lw = function (e, t, n, r) {
    var o = e.left,
      i = e.top,
      l = e.right,
      s = e.gap;
    return (
      n === void 0 && (n = "margin"),
      `
  .`
        .concat(
          vw,
          ` {
   overflow: hidden `
        )
        .concat(
          r,
          `;
   padding-right: `
        )
        .concat(s, "px ")
        .concat(
          r,
          `;
  }
  body {
    overflow: hidden `
        )
        .concat(
          r,
          `;
    overscroll-behavior: contain;
    `
        )
        .concat(
          [
            t && "position: relative ".concat(r, ";"),
            n === "margin" &&
              `
    padding-left: `
                .concat(
                  o,
                  `px;
    padding-top: `
                )
                .concat(
                  i,
                  `px;
    padding-right: `
                )
                .concat(
                  l,
                  `px;
    margin-left:0;
    margin-top:0;
    margin-right: `
                )
                .concat(s, "px ")
                .concat(
                  r,
                  `;
    `
                ),
            n === "padding" &&
              "padding-right: ".concat(s, "px ").concat(r, ";"),
          ]
            .filter(Boolean)
            .join(""),
          `
  }
  
  .`
        )
        .concat(
          Bo,
          ` {
    right: `
        )
        .concat(s, "px ")
        .concat(
          r,
          `;
  }
  
  .`
        )
        .concat(
          Uo,
          ` {
    margin-right: `
        )
        .concat(s, "px ")
        .concat(
          r,
          `;
  }
  
  .`
        )
        .concat(Bo, " .")
        .concat(
          Bo,
          ` {
    right: 0 `
        )
        .concat(
          r,
          `;
  }
  
  .`
        )
        .concat(Uo, " .")
        .concat(
          Uo,
          ` {
    margin-right: 0 `
        )
        .concat(
          r,
          `;
  }
  
  body {
    `
        )
        .concat(yw, ": ")
        .concat(
          s,
          `px;
  }
`
        )
    );
  },
  Fw = function (e) {
    var t = e.noRelative,
      n = e.noImportant,
      r = e.gapMode,
      o = r === void 0 ? "margin" : r,
      i = g.exports.useMemo(
        function () {
          return bw(o);
        },
        [o]
      );
    return g.exports.createElement(Mw, {
      styles: Lw(i, !t, o, n ? "" : "!important"),
    });
  },
  Gs = !1;
if (typeof window != "undefined")
  try {
    var xo = Object.defineProperty({}, "passive", {
      get: function () {
        return (Gs = !0), !0;
      },
    });
    window.addEventListener("test", xo, xo),
      window.removeEventListener("test", xo, xo);
  } catch {
    Gs = !1;
  }
var pn = Gs ? { passive: !1 } : !1,
  zw = function (e) {
    return e.tagName === "TEXTAREA";
  },
  Mh = function (e, t) {
    var n = window.getComputedStyle(e);
    return (
      n[t] !== "hidden" &&
      !(n.overflowY === n.overflowX && !zw(e) && n[t] === "visible")
    );
  },
  jw = function (e) {
    return Mh(e, "overflowY");
  },
  Aw = function (e) {
    return Mh(e, "overflowX");
  },
  pd = function (e, t) {
    var n = t;
    do {
      typeof ShadowRoot != "undefined" &&
        n instanceof ShadowRoot &&
        (n = n.host);
      var r = Lh(e, n);
      if (r) {
        var o = Fh(e, n),
          i = o[1],
          l = o[2];
        if (i > l) return !0;
      }
      n = n.parentNode;
    } while (n && n !== document.body);
    return !1;
  },
  Bw = function (e) {
    var t = e.scrollTop,
      n = e.scrollHeight,
      r = e.clientHeight;
    return [t, n, r];
  },
  Uw = function (e) {
    var t = e.scrollLeft,
      n = e.scrollWidth,
      r = e.clientWidth;
    return [t, n, r];
  },
  Lh = function (e, t) {
    return e === "v" ? jw(t) : Aw(t);
  },
  Fh = function (e, t) {
    return e === "v" ? Bw(t) : Uw(t);
  },
  Ww = function (e, t) {
    return e === "h" && t === "rtl" ? -1 : 1;
  },
  Hw = function (e, t, n, r, o) {
    var i = Ww(e, window.getComputedStyle(t).direction),
      l = i * r,
      s = n.target,
      u = t.contains(s),
      a = !1,
      c = l > 0,
      f = 0,
      p = 0;
    do {
      var y = Fh(e, s),
        S = y[0],
        m = y[1],
        C = y[2],
        h = m - C - i * S;
      (S || h) && Lh(e, s) && ((f += h), (p += S)), (s = s.parentNode);
    } while ((!u && s !== document.body) || (u && (t.contains(s) || t === s)));
    return (
      ((c && ((o && f === 0) || (!o && l > f))) ||
        (!c && ((o && p === 0) || (!o && -l > p)))) &&
        (a = !0),
      a
    );
  },
  Eo = function (e) {
    return "changedTouches" in e
      ? [e.changedTouches[0].clientX, e.changedTouches[0].clientY]
      : [0, 0];
  },
  hd = function (e) {
    return [e.deltaX, e.deltaY];
  },
  gd = function (e) {
    return e && "current" in e ? e.current : e;
  },
  Vw = function (e, t) {
    return e[0] === t[0] && e[1] === t[1];
  },
  Qw = function (e) {
    return `
  .block-interactivity-`
      .concat(
        e,
        ` {pointer-events: none;}
  .allow-interactivity-`
      )
      .concat(
        e,
        ` {pointer-events: all;}
`
      );
  },
  Gw = 0,
  hn = [];
function Kw(e) {
  var t = g.exports.useRef([]),
    n = g.exports.useRef([0, 0]),
    r = g.exports.useRef(),
    o = g.exports.useState(Gw++)[0],
    i = g.exports.useState(function () {
      return bh();
    })[0],
    l = g.exports.useRef(e);
  g.exports.useEffect(
    function () {
      l.current = e;
    },
    [e]
  ),
    g.exports.useEffect(
      function () {
        if (e.inert) {
          document.body.classList.add("block-interactivity-".concat(o));
          var m = mw([e.lockRef.current], (e.shards || []).map(gd), !0).filter(
            Boolean
          );
          return (
            m.forEach(function (C) {
              return C.classList.add("allow-interactivity-".concat(o));
            }),
            function () {
              document.body.classList.remove("block-interactivity-".concat(o)),
                m.forEach(function (C) {
                  return C.classList.remove("allow-interactivity-".concat(o));
                });
            }
          );
        }
      },
      [e.inert, e.lockRef.current, e.shards]
    );
  var s = g.exports.useCallback(function (m, C) {
      if ("touches" in m && m.touches.length === 2)
        return !l.current.allowPinchZoom;
      var h = Eo(m),
        d = n.current,
        v = "deltaX" in m ? m.deltaX : d[0] - h[0],
        w = "deltaY" in m ? m.deltaY : d[1] - h[1],
        E,
        x = m.target,
        k = Math.abs(v) > Math.abs(w) ? "h" : "v";
      if ("touches" in m && k === "h" && x.type === "range") return !1;
      var O = pd(k, x);
      if (!O) return !0;
      if ((O ? (E = k) : ((E = k === "v" ? "h" : "v"), (O = pd(k, x))), !O))
        return !1;
      if (
        (!r.current && "changedTouches" in m && (v || w) && (r.current = E), !E)
      )
        return !0;
      var _ = r.current || E;
      return Hw(_, C, m, _ === "h" ? v : w, !0);
    }, []),
    u = g.exports.useCallback(function (m) {
      var C = m;
      if (!(!hn.length || hn[hn.length - 1] !== i)) {
        var h = "deltaY" in C ? hd(C) : Eo(C),
          d = t.current.filter(function (E) {
            return E.name === C.type && E.target === C.target && Vw(E.delta, h);
          })[0];
        if (d && d.should) {
          C.cancelable && C.preventDefault();
          return;
        }
        if (!d) {
          var v = (l.current.shards || [])
              .map(gd)
              .filter(Boolean)
              .filter(function (E) {
                return E.contains(C.target);
              }),
            w = v.length > 0 ? s(C, v[0]) : !l.current.noIsolation;
          w && C.cancelable && C.preventDefault();
        }
      }
    }, []),
    a = g.exports.useCallback(function (m, C, h, d) {
      var v = { name: m, delta: C, target: h, should: d };
      t.current.push(v),
        setTimeout(function () {
          t.current = t.current.filter(function (w) {
            return w !== v;
          });
        }, 1);
    }, []),
    c = g.exports.useCallback(function (m) {
      (n.current = Eo(m)), (r.current = void 0);
    }, []),
    f = g.exports.useCallback(function (m) {
      a(m.type, hd(m), m.target, s(m, e.lockRef.current));
    }, []),
    p = g.exports.useCallback(function (m) {
      a(m.type, Eo(m), m.target, s(m, e.lockRef.current));
    }, []);
  g.exports.useEffect(function () {
    return (
      hn.push(i),
      e.setCallbacks({
        onScrollCapture: f,
        onWheelCapture: f,
        onTouchMoveCapture: p,
      }),
      document.addEventListener("wheel", u, pn),
      document.addEventListener("touchmove", u, pn),
      document.addEventListener("touchstart", c, pn),
      function () {
        (hn = hn.filter(function (m) {
          return m !== i;
        })),
          document.removeEventListener("wheel", u, pn),
          document.removeEventListener("touchmove", u, pn),
          document.removeEventListener("touchstart", c, pn);
      }
    );
  }, []);
  var y = e.removeScrollBar,
    S = e.inert;
  return g.exports.createElement(
    g.exports.Fragment,
    null,
    S ? g.exports.createElement(i, { styles: Qw(o) }) : null,
    y ? g.exports.createElement(Fw, { gapMode: "margin" }) : null
  );
}
var Yw = Ow(Nh, Kw),
  zh = g.exports.forwardRef(function (e, t) {
    return g.exports.createElement(Ui, Ze({}, e, { ref: t, sideCar: Yw }));
  });
zh.classNames = Ui.classNames;
var Xw = zh,
  Zw = function (e) {
    if (typeof document == "undefined") return null;
    var t = Array.isArray(e) ? e[0] : e;
    return t.ownerDocument.body;
  },
  gn = new WeakMap(),
  Co = new WeakMap(),
  ko = {},
  $l = 0,
  jh = function (e) {
    return e && (e.host || jh(e.parentNode));
  },
  qw = function (e, t) {
    return t
      .map(function (n) {
        if (e.contains(n)) return n;
        var r = jh(n);
        return r && e.contains(r)
          ? r
          : (console.error(
              "aria-hidden",
              n,
              "in not contained inside",
              e,
              ". Doing nothing"
            ),
            null);
      })
      .filter(function (n) {
        return Boolean(n);
      });
  },
  Jw = function (e, t, n, r) {
    var o = qw(t, Array.isArray(e) ? e : [e]);
    ko[n] || (ko[n] = new WeakMap());
    var i = ko[n],
      l = [],
      s = new Set(),
      u = new Set(o),
      a = function (f) {
        !f || s.has(f) || (s.add(f), a(f.parentNode));
      };
    o.forEach(a);
    var c = function (f) {
      !f ||
        u.has(f) ||
        Array.prototype.forEach.call(f.children, function (p) {
          if (s.has(p)) c(p);
          else {
            var y = p.getAttribute(r),
              S = y !== null && y !== "false",
              m = (gn.get(p) || 0) + 1,
              C = (i.get(p) || 0) + 1;
            gn.set(p, m),
              i.set(p, C),
              l.push(p),
              m === 1 && S && Co.set(p, !0),
              C === 1 && p.setAttribute(n, "true"),
              S || p.setAttribute(r, "true");
          }
        });
    };
    return (
      c(t),
      s.clear(),
      $l++,
      function () {
        l.forEach(function (f) {
          var p = gn.get(f) - 1,
            y = i.get(f) - 1;
          gn.set(f, p),
            i.set(f, y),
            p || (Co.has(f) || f.removeAttribute(r), Co.delete(f)),
            y || f.removeAttribute(n);
        }),
          $l--,
          $l ||
            ((gn = new WeakMap()),
            (gn = new WeakMap()),
            (Co = new WeakMap()),
            (ko = {}));
      }
    );
  },
  ex = function (e, t, n) {
    n === void 0 && (n = "data-aria-hidden");
    var r = Array.from(Array.isArray(e) ? e : [e]),
      o = t || Zw(e);
    return o
      ? (r.push.apply(r, Array.from(o.querySelectorAll("[aria-live]"))),
        Jw(r, o, n, "aria-hidden"))
      : function () {
          return null;
        };
  };
const Ah = "Dialog",
  [Bh, fE] = BS(Ah),
  [tx, et] = Bh(Ah),
  nx = (e) => {
    const {
        __scopeDialog: t,
        children: n,
        open: r,
        defaultOpen: o,
        onOpenChange: i,
        modal: l = !0,
      } = e,
      s = g.exports.useRef(null),
      u = g.exports.useRef(null),
      [a = !1, c] = VS({ prop: r, defaultProp: o, onChange: i });
    return g.exports.createElement(
      tx,
      {
        scope: t,
        triggerRef: s,
        contentRef: u,
        contentId: kl(),
        titleId: kl(),
        descriptionId: kl(),
        open: a,
        onOpenChange: c,
        onOpenToggle: g.exports.useCallback(() => c((f) => !f), [c]),
        modal: l,
      },
      n
    );
  },
  Uh = "DialogPortal",
  [rx, Wh] = Bh(Uh, { forceMount: void 0 }),
  ox = (e) => {
    const { __scopeDialog: t, forceMount: n, children: r, container: o } = e,
      i = et(Uh, t);
    return g.exports.createElement(
      rx,
      { scope: t, forceMount: n },
      g.exports.Children.map(r, (l) =>
        g.exports.createElement(
          Bi,
          { present: n || i.open },
          g.exports.createElement(fw, { asChild: !0, container: o }, l)
        )
      )
    );
  },
  Ks = "DialogOverlay",
  ix = g.exports.forwardRef((e, t) => {
    const n = Wh(Ks, e.__scopeDialog),
      { forceMount: r = n.forceMount, ...o } = e,
      i = et(Ks, e.__scopeDialog);
    return i.modal
      ? g.exports.createElement(
          Bi,
          { present: r || i.open },
          g.exports.createElement(lx, ie({}, o, { ref: t }))
        )
      : null;
  }),
  lx = g.exports.forwardRef((e, t) => {
    const { __scopeDialog: n, ...r } = e,
      o = et(Ks, n);
    return g.exports.createElement(
      Xw,
      { as: fa, allowPinchZoom: !0, shards: [o.contentRef] },
      g.exports.createElement(
        un.div,
        ie({ "data-state": Vh(o.open) }, r, {
          ref: t,
          style: { pointerEvents: "auto", ...r.style },
        })
      )
    );
  }),
  Br = "DialogContent",
  sx = g.exports.forwardRef((e, t) => {
    const n = Wh(Br, e.__scopeDialog),
      { forceMount: r = n.forceMount, ...o } = e,
      i = et(Br, e.__scopeDialog);
    return g.exports.createElement(
      Bi,
      { present: r || i.open },
      i.modal
        ? g.exports.createElement(ux, ie({}, o, { ref: t }))
        : g.exports.createElement(ax, ie({}, o, { ref: t }))
    );
  }),
  ux = g.exports.forwardRef((e, t) => {
    const n = et(Br, e.__scopeDialog),
      r = g.exports.useRef(null),
      o = Zr(t, n.contentRef, r);
    return (
      g.exports.useEffect(() => {
        const i = r.current;
        if (i) return ex(i);
      }, []),
      g.exports.createElement(
        Hh,
        ie({}, e, {
          ref: o,
          trapFocus: n.open,
          disableOutsidePointerEvents: !0,
          onCloseAutoFocus: Yt(e.onCloseAutoFocus, (i) => {
            var l;
            i.preventDefault(),
              (l = n.triggerRef.current) === null || l === void 0 || l.focus();
          }),
          onPointerDownOutside: Yt(e.onPointerDownOutside, (i) => {
            const l = i.detail.originalEvent,
              s = l.button === 0 && l.ctrlKey === !0;
            (l.button === 2 || s) && i.preventDefault();
          }),
          onFocusOutside: Yt(e.onFocusOutside, (i) => i.preventDefault()),
        })
      )
    );
  }),
  ax = g.exports.forwardRef((e, t) => {
    const n = et(Br, e.__scopeDialog),
      r = g.exports.useRef(!1);
    return g.exports.createElement(
      Hh,
      ie({}, e, {
        ref: t,
        trapFocus: !1,
        disableOutsidePointerEvents: !1,
        onCloseAutoFocus: (o) => {
          var i;
          if (
            ((i = e.onCloseAutoFocus) === null || i === void 0 || i.call(e, o),
            !o.defaultPrevented)
          ) {
            var l;
            r.current ||
              (l = n.triggerRef.current) === null ||
              l === void 0 ||
              l.focus(),
              o.preventDefault();
          }
          r.current = !1;
        },
        onInteractOutside: (o) => {
          var i, l;
          (i = e.onInteractOutside) === null || i === void 0 || i.call(e, o),
            o.defaultPrevented || (r.current = !0);
          const s = o.target;
          ((l = n.triggerRef.current) === null || l === void 0
            ? void 0
            : l.contains(s)) && o.preventDefault();
        },
      })
    );
  }),
  Hh = g.exports.forwardRef((e, t) => {
    const {
        __scopeDialog: n,
        trapFocus: r,
        onOpenAutoFocus: o,
        onCloseAutoFocus: i,
        ...l
      } = e,
      s = et(Br, n),
      u = g.exports.useRef(null),
      a = Zr(t, u);
    return (
      gw(),
      g.exports.createElement(
        g.exports.Fragment,
        null,
        g.exports.createElement(
          iw,
          {
            asChild: !0,
            loop: !0,
            trapped: r,
            onMountAutoFocus: o,
            onUnmountAutoFocus: i,
          },
          g.exports.createElement(
            nw,
            ie(
              {
                role: "dialog",
                id: s.contentId,
                "aria-describedby": s.descriptionId,
                "aria-labelledby": s.titleId,
                "data-state": Vh(s.open),
              },
              l,
              { ref: a, onDismiss: () => s.onOpenChange(!1) }
            )
          )
        ),
        !1
      )
    );
  }),
  cx = "DialogTitle",
  dx = g.exports.forwardRef((e, t) => {
    const { __scopeDialog: n, ...r } = e,
      o = et(cx, n);
    return g.exports.createElement(un.h2, ie({ id: o.titleId }, r, { ref: t }));
  }),
  fx = "DialogDescription",
  px = g.exports.forwardRef((e, t) => {
    const { __scopeDialog: n, ...r } = e,
      o = et(fx, n);
    return g.exports.createElement(
      un.p,
      ie({ id: o.descriptionId }, r, { ref: t })
    );
  }),
  hx = "DialogClose",
  gx = g.exports.forwardRef((e, t) => {
    const { __scopeDialog: n, ...r } = e,
      o = et(hx, n);
    return g.exports.createElement(
      un.button,
      ie({ type: "button" }, r, {
        ref: t,
        onClick: Yt(e.onClick, () => o.onOpenChange(!1)),
      })
    );
  });
function Vh(e) {
  return e ? "open" : "closed";
}
const mx = nx,
  vx = ox,
  yx = ix,
  Sx = sx,
  wx = dx,
  xx = px,
  md = gx,
  Ex = Gp({ "0%": { opacity: 0 }, "100%": { opacity: 1 } }),
  Cx = Gp({
    "0%": { opacity: 0, transform: "translate(-50%, -48%) scale(.96)" },
    "100%": { opacity: 1, transform: "translate(-50%, -50%) scale(1)" },
  }),
  kx = Xr({
    position: "fixed",
    inset: 0,
    backgroundColor: "rgba(0, 0, 0, 0.2)",
    animation: `${Ex} 350ms cubic-bezier(0.16, 1, 0.3, 1)`,
  }),
  Ox = Xr({
    borderRadius: 12,
    position: "absolute",
    padding: 20,
    width: 372,
    height: 225,
    top: "50%",
    left: "50%",
    transform: "translate(-50%, -50%)",
    backgroundColor: "#101015",
    color: "White",
    display: "flex",
    flexDirection: "column",
    justifyContent: "space-between",
    animation: `${Cx} 350ms cubic-bezier(0.16, 1, 0.3, 1)`,
  }),
  Tx = Xr({
    marginBottom: -24,
    fontSize: 16,
    fontWeight: 700,
    position: "relative",
  }),
  Px = Xr({
    textAlign: "center",
    fontWeight: 700,
    color: "rgba(255, 255, 255, 0.7)",
    "& span": { color: "White", display: "block", marginTop: 16 },
    "& p": { fontSize: 12, color: "#FFFFFF8C", textAlign: "left" },
  }),
  vd = _e("button", {
    width: "100%",
    padding: "15px 25px",
    textTransform: "uppercase",
    fontWeight: "bold",
    border: "none",
    borderRadius: 5,
    background: "#FFFFFF05",
    color: "#FFFFFF59",
    transition: ".2s all",
    cursor: "pointer",
    "&:hover": { background: "#FFFFFF15" },
    variants: {
      color: {
        purple: {
          background: "linear-gradient(#5763d0, #5763d0)",
          color: "#fff",
          "&:hover": { background: "linear-gradient(#5763d0, #6573f8)" },
        },
      },
    },
  }),
  Ix = _e("input", {
    width: "100%",
    padding: 15,
    background: "#FFFFFF08",
    border: "none",
    borderRadius: 6,
    color: "#FFF",
    "&:focus": { boxShadow: "0 0 0 0", outline: 0 },
    "&:placeholder": { color: "#FFFFFF8C" },
  }),
  Dx = Xr({
    display: "flex",
    flexDirection: "row",
    marginTop: 25,
    justifyContent: "flex-end",
    gap: 10,
  }),
  yd = ({ open: e, setOpen: t }) => {
    const [n, r] = g.exports.useState("");
    function o() {
      Bt("changePhoto", { url: n });
    }
    return P(mx, {
      open: e,
      onOpenChange: t,
      children: j(vx, {
        children: [
          P(yx, { className: kx() }),
          j(Sx, {
            className: Ox(),
            children: [
              P(wx, { className: Tx(), children: "Modificar Avatar" }),
              j(xx, {
                className: Px(),
                children: [
                  P("p", {
                    children:
                      "Modifique sua imagem de perfil do invent\xE1rio.",
                  }),
                  P("span", {
                    children: P(Ix, {
                      type: "url",
                      placeholder:
                        "https://cdn.discordapp.com/attachments/example/example/image.png",
                      value: n,
                      onChange: (i) => r(i.target.value),
                    }),
                  }),
                ],
              }),
              j("div", {
                className: Dx(),
                children: [
                  P(md, {
                    asChild: !0,
                    style: { flex: 2 },
                    children: P(vd, { children: "FECHAR" }),
                  }),
                  P(md, {
                    asChild: !0,
                    children: P(vd, {
                      color: "purple",
                      onClick: o,
                      children: "SALVAR",
                    }),
                  }),
                ],
              }),
            ],
          }),
        ],
      }),
    });
  },
  Sd = _e("div", {
    border: "2px solid #ffffff",
    borderRadius: 10,
    width: 107,
    height: 107,
    minWidth: 107,
    position: "relative",
    variants: {
      noPhoto: {
        true: {
          display: "flex",
          alignItems: "center",
          justifyContent: "center",
        },
      },
    },
  }),
  wd = _e("button", {
    border: "none",
    borderRadius: 12,
    padding: "5px 10px 0",
    background: "$purple",
    position: "absolute",
    bottom: -25,
    left: "50%",
    transform: "translate(-50%, -50%)",
    cursor: "pointer",
  }),
  $x = ({ url: e }) => {
    const [t, n] = g.exports.useState(!1),
      r = () => n(!0);
    return e
      ? j(Sd, {
          css: {
            backgroundImage: `url('${e}')`,
            backgroundRepeat: "no-repeat",
            backgroundSize: "cover",
          },
          children: [
            P(wd, { onClick: r, children: P("img", { src: id }) }),
            P(yd, { open: t, setOpen: n }),
          ],
        })
      : j(Sd, {
          noPhoto: !0,
          css: {
            backgroundRepeat: "no-repeat",
            backgroundSize: "cover",
            borderColor: "rgba(255, 255, 255, 0.15);",
          },
          children: [
            P(jS, { icon: "ep:user-filled", fontSize: 58, color: "#262630" }),
            P(wd, { onClick: r, children: P("img", { src: id }) }),
            P(yd, { open: t, setOpen: n }),
          ],
        });
  };
var Rx = "./assets/solar_user-id-linear.b7d21feb.svg";
const _x = qu("div", {
    display: "flex",
    flexDirection: "row",
    justifyContent: "center",
    gap: 7,
    "& div": {
      display: "flex",
      flexDirection: "column",
      fontSize: 12,
      "& .label": { fontSize: 12, color: "#FFFFFF73" },
      "&>p": { fontWeight: "medium", color: "#FFFFFF" },
      "& .info": { fontWeight: "bold", fontSize: 14 },
    },
  }),
  Rl = ({ label: e, info: t }) =>
    j(_x, {
      children: [
        P("img", { src: Rx }),
        j("div", {
          children: [
            P("p", { className: "label", children: e }),
            P("p", { className: "info", children: t }),
          ],
        }),
      ],
    }),
  Nx = _e("div", { display: "flex", flexDirection: "row", gap: 20 }),
  bx = _e("div", {
    padding: "20px 0",
    width: "100%",
    "&>p": { fontWeight: "medium", marginBottom: 10, color: "#FFFFFF" },
    "& .data-row": { display: "flex", flexDirection: "row", gap: 15 },
  }),
  Mx = () => {
    const { profile: e } = Yr();
    return j(Nx, {
      children: [
        P($x, { url: e == null ? void 0 : e.photo }),
        j(bx, {
          children: [
            j("p", {
              children: [
                e == null ? void 0 : e.name,
                " ",
                e == null ? void 0 : e.name2,
              ],
            }),
            j("div", {
              className: "data-row",
              children: [
                P(Rl, {
                  label: "Passaporte",
                  info: e == null ? void 0 : e.passport,
                }),
                P(Rl, {
                  label: "Registro",
                  info: e == null ? void 0 : e.register,
                }),
                P(Rl, {
                  label: "Telefone",
                  info: e == null ? void 0 : e.phone,
                }),
              ],
            }),
          ],
        }),
      ],
    });
  },
  Lx = _e("div", {
    width: "100%",
    height: "100%",
    background: "$graywhite",
    border: "1px solid #ffffff09",
    userSelect: "none",
  }),
  pa = ({ children: e }) => P(Lx, { children: e }),
  Fx = _e("div", {
    padding: 15,
    width: "100%",
    height: "100%",
    borderRadius: 15,
    background: "$darkblue",
    gridArea: "1 / 2 / 7 / 4",
    overflow: "visible",
    display: "flex",
    flexDirection: "column",
    justifyContent: "space-between",
    gap: 20,
    "& .grid-container": {
      scrollbarWidth: "none",
      "&::-webkit-scrollbar": { display: "none" },
      overflowY: "scroll",
    },
  }),
  zx = _e("div", {
    width: "100%",
    minHeight: 0,
    height: "100%",
    display: "grid",
    gridTemplateColumns: "repeat(5,minmax(90px,1fr))",
    gap: 5,
  }),
  jx = () => {
    const { inventory: e } = Yr(),
      t = e.sections.find((n) => n.sectionId === "inventory");
    return j(Fx, {
      children: [
        P(Mx, {}),
        P("div", {
          className: "grid-container",
          children: P(zx, {
            children:
              t == null
                ? void 0
                : t.itemsList.map((n, r) =>
                    j(
                      "div",
                      {
                        style: {
                          height: 120,
                          borderRadius: 5,
                          overflow: "hidden",
                        },
                        children: [
                          P(pa, {
                            children: P(ch, {
                              index: r,
                              item: n,
                              section: "inventory",
                              type: "item",
                              accepts: ["item", "weapon"],
                            }),
                          }),
                          "s",
                        ],
                      },
                      n ? `${r}-${n.name}` : r
                    )
                  ),
          }),
        }),
      ],
    });
  };
/*! *****************************************************************************
Copyright (c) Microsoft Corporation. All rights reserved.
Licensed under the Apache License, Version 2.0 (the "License"); you may not use
this file except in compliance with the License. You may obtain a copy of the
License at http://www.apache.org/licenses/LICENSE-2.0

THIS CODE IS PROVIDED ON AN *AS IS* BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
KIND, EITHER EXPRESS OR IMPLIED, INCLUDING WITHOUT LIMITATION ANY IMPLIED
WARRANTIES OR CONDITIONS OF TITLE, FITNESS FOR A PARTICULAR PURPOSE,
MERCHANTABLITY OR NON-INFRINGEMENT.

See the Apache Version 2.0 License for specific language governing permissions
and limitations under the License.
***************************************************************************** */ var Ys =
  function (e, t) {
    return (
      (Ys =
        Object.setPrototypeOf ||
        ({ __proto__: [] } instanceof Array &&
          function (n, r) {
            n.__proto__ = r;
          }) ||
        function (n, r) {
          for (var o in r) r.hasOwnProperty(o) && (n[o] = r[o]);
        }),
      Ys(e, t)
    );
  };
function Ax(e, t) {
  Ys(e, t);
  function n() {
    this.constructor = e;
  }
  e.prototype =
    t === null ? Object.create(t) : ((n.prototype = t.prototype), new n());
}
var Xs = function () {
  return (
    (Xs =
      Object.assign ||
      function (t) {
        for (var n, r = 1, o = arguments.length; r < o; r++) {
          n = arguments[r];
          for (var i in n)
            Object.prototype.hasOwnProperty.call(n, i) && (t[i] = n[i]);
        }
        return t;
      }),
    Xs.apply(this, arguments)
  );
};
function Bx(e, t) {
  var n = {};
  for (var r in e)
    Object.prototype.hasOwnProperty.call(e, r) &&
      t.indexOf(r) < 0 &&
      (n[r] = e[r]);
  if (e != null && typeof Object.getOwnPropertySymbols == "function")
    for (var o = 0, r = Object.getOwnPropertySymbols(e); o < r.length; o++)
      t.indexOf(r[o]) < 0 && (n[r[o]] = e[r[o]]);
  return n;
}
var Ux = 100,
  Wx = 100,
  xd = 50,
  Zs = 50,
  qs = 50;
function Ed(e) {
  var t = e.className,
    n = e.counterClockwise,
    r = e.dashRatio,
    o = e.pathRadius,
    i = e.strokeWidth,
    l = e.style;
  return g.exports.createElement("path", {
    className: t,
    style: Object.assign(
      {},
      l,
      Vx({ pathRadius: o, dashRatio: r, counterClockwise: n })
    ),
    d: Hx({ pathRadius: o, counterClockwise: n }),
    strokeWidth: i,
    fillOpacity: 0,
  });
}
function Hx(e) {
  var t = e.pathRadius,
    n = e.counterClockwise,
    r = t,
    o = n ? 1 : 0;
  return (
    `
      M ` +
    Zs +
    "," +
    qs +
    `
      m 0,-` +
    r +
    `
      a ` +
    r +
    "," +
    r +
    " " +
    o +
    " 1 1 0," +
    2 * r +
    `
      a ` +
    r +
    "," +
    r +
    " " +
    o +
    " 1 1 0,-" +
    2 * r +
    `
    `
  );
}
function Vx(e) {
  var t = e.counterClockwise,
    n = e.dashRatio,
    r = e.pathRadius,
    o = Math.PI * 2 * r,
    i = (1 - n) * o;
  return {
    strokeDasharray: o + "px " + o + "px",
    strokeDashoffset: (t ? -i : i) + "px",
  };
}
var Qx = (function (e) {
  Ax(t, e);
  function t() {
    return (e !== null && e.apply(this, arguments)) || this;
  }
  return (
    (t.prototype.getBackgroundPadding = function () {
      return this.props.background ? this.props.backgroundPadding : 0;
    }),
    (t.prototype.getPathRadius = function () {
      return xd - this.props.strokeWidth / 2 - this.getBackgroundPadding();
    }),
    (t.prototype.getPathRatio = function () {
      var n = this.props,
        r = n.value,
        o = n.minValue,
        i = n.maxValue,
        l = Math.min(Math.max(r, o), i);
      return (l - o) / (i - o);
    }),
    (t.prototype.render = function () {
      var n = this.props,
        r = n.circleRatio,
        o = n.className,
        i = n.classes,
        l = n.counterClockwise,
        s = n.styles,
        u = n.strokeWidth,
        a = n.text,
        c = this.getPathRadius(),
        f = this.getPathRatio();
      return g.exports.createElement(
        "svg",
        {
          className: i.root + " " + o,
          style: s.root,
          viewBox: "0 0 " + Ux + " " + Wx,
          "data-test-id": "CircularProgressbar",
        },
        this.props.background
          ? g.exports.createElement("circle", {
              className: i.background,
              style: s.background,
              cx: Zs,
              cy: qs,
              r: xd,
            })
          : null,
        g.exports.createElement(Ed, {
          className: i.trail,
          counterClockwise: l,
          dashRatio: r,
          pathRadius: c,
          strokeWidth: u,
          style: s.trail,
        }),
        g.exports.createElement(Ed, {
          className: i.path,
          counterClockwise: l,
          dashRatio: f * r,
          pathRadius: c,
          strokeWidth: u,
          style: s.path,
        }),
        a
          ? g.exports.createElement(
              "text",
              { className: i.text, style: s.text, x: Zs, y: qs },
              a
            )
          : null
      );
    }),
    (t.defaultProps = {
      background: !1,
      backgroundPadding: 0,
      circleRatio: 1,
      classes: {
        root: "CircularProgressbar",
        trail: "CircularProgressbar-trail",
        path: "CircularProgressbar-path",
        text: "CircularProgressbar-text",
        background: "CircularProgressbar-background",
      },
      counterClockwise: !1,
      className: "",
      maxValue: 100,
      minValue: 0,
      strokeWidth: 8,
      styles: { root: {}, trail: {}, path: {}, text: {}, background: {} },
      text: "",
    }),
    t
  );
})(g.exports.Component);
function Gx(e) {
  e.children;
  var t = Bx(e, ["children"]);
  return g.exports.createElement(
    "div",
    { "data-test-id": "CircularProgressbarWithChildren" },
    g.exports.createElement(
      "div",
      { style: { position: "relative", width: "100%", height: "100%" } },
      g.exports.createElement(Qx, Xs({}, t)),
      e.children
        ? g.exports.createElement(
            "div",
            {
              "data-test-id": "CircularProgressbarWithChildren__children",
              style: {
                position: "absolute",
                width: "100%",
                height: "100%",
                marginTop: "-100%",
                display: "flex",
                flexDirection: "column",
                justifyContent: "center",
                alignItems: "center",
              },
            },
            e.children
          )
        : null
    )
  );
}
function Kx(e) {
  var t = e.rotation,
    n = e.strokeLinecap,
    r = e.textColor,
    o = e.textSize,
    i = e.pathColor,
    l = e.pathTransition,
    s = e.pathTransitionDuration,
    u = e.trailColor,
    a = e.backgroundColor,
    c = t == null ? void 0 : "rotate(" + t + "turn)",
    f = t == null ? void 0 : "center center";
  return {
    root: {},
    path: Oo({
      stroke: i,
      strokeLinecap: n,
      transform: c,
      transformOrigin: f,
      transition: l,
      transitionDuration: s == null ? void 0 : s + "s",
    }),
    trail: Oo({
      stroke: u,
      strokeLinecap: n,
      transform: c,
      transformOrigin: f,
    }),
    text: Oo({ fill: r, fontSize: o }),
    background: Oo({ fill: a }),
  };
}
function Oo(e) {
  return (
    Object.keys(e).forEach(function (t) {
      e[t] == null && delete e[t];
    }),
    e
  );
}
const Cd = ({ usedCapacity: e, maxCapacity: t }) =>
  P("div", {
    style: { width: "100%", minWidth: 100, marginBottom: 10 },
    children: j(Gx, {
      value: e,
      maxValue: t,
      strokeWidth: 2.5,
      styles: Kx({
        textColor: "#5763d0",
        pathColor: "#5763d0",
        trailColor: "#FFFFFF0D",
      }),
      children: [
        j("p", {
          style: { fontSize: 13, color: "#FFFFFF5E" },
          children: [
            P("strong", {
              style: { fontSize: 26, color: "#fff" },
              children: e.toFixed(2),
            }),
            "/",
            t.toFixed(2),
          ],
        }),
        P("p", {
          style: { fontSize: 12, color: "#FFFFFF40", marginTop: 8 },
          children: "utilizados",
        }),
      ],
    }),
  });
qu("div", {
  padding: 15,
  width: "100%",
  height: "100%",
  borderRadius: 15,
  background: "$darkblue",
  gridArea: "1 / 2 / 7 / 4",
  overflow: "visible",
  display: "flex",
  flexDirection: "column",
  justifyContent: "space-between",
  gap: 20,
});
const Yx = qu("div", {
  width: "100%",
  minHeight: 0,
  height: "100%",
  display: "grid",
  gridTemplateColumns: "repeat(5,minmax(90px,1fr))",
  gap: 5,
});
function Xx() {
  var i, l;
  const { chest: e, chestWeight: t, inventoryWeight: n, setQuantity: r } = Yr(),
    o =
      (i = e == null ? void 0 : e.sections) == null
        ? void 0
        : i.find((s) => s.sectionId === "chest");
  return j("div", {
    className: "body",
    children: [
      P("div", { className: "inventory", children: P(jx, {}) }),
      j("div", {
        className: "actions",
        children: [
          j("div", {
            className: "header",
            children: [
              P("svg", {
                width: "1vw",
                height: "1vw",
                viewBox: "0 0 12 7",
                fill: "none",
                xmlns: "http://www.w3.org/2000/svg",
                children: P("path", {
                  d: "M0.75 7V5.83333H11.25V7H0.75ZM0.75 4.08333V2.91667H11.25V4.08333H0.75ZM0.75 1.16667V0H11.25V1.16667H0.75Z",
                  fill: "#5763d0",
                }),
              }),
              P("h1", { children: "Invent\xE1rio" }),
            ],
          }),
          j("div", {
            className: "section",
            children: [
              P(Cd, { usedCapacity: t.weight, maxCapacity: t.maxWeight }),
              P("input", {
                type: "number",
                placeholder: "QTD",
                className: "input",
                onChange: (s) => r(Number(s.target.value)),
              }),
              P(Cd, { usedCapacity: n.weight, maxCapacity: n.maxWeight }),
            ],
          }),
        ],
      }),
      j("div", {
        className: "chest",
        children: [
          P("div", {
            className: "header-chest",
            children: P("h1", { children: "Ba\xFA" }),
          }),
          P("div", {
            className: "grid-containerr",
            children: P(Yx, {
              children:
                (l = o == null ? void 0 : o.itemsList) == null
                  ? void 0
                  : l.map((s, u) =>
                      P(
                        "div",
                        {
                          style: {
                            height: 120,
                            borderRadius: 5,
                            overflow: "hidden",
                          },
                          children: P(pa, {
                            children: P(ch, {
                              index: u,
                              item: s,
                              section: "chest",
                              type: "item",
                              accepts: ["item", "weapon"],
                            }),
                          }),
                        },
                        s ? `${u}-${s.name}` : u
                      )
                    ),
            }),
          }),
        ],
      }),
    ],
  });
}
var It;
(function (e) {
  (e.mouse = "mouse"), (e.touch = "touch"), (e.keyboard = "keyboard");
})(It || (It = {}));
class Zx {
  get delay() {
    var t;
    return (t = this.args.delay) !== null && t !== void 0 ? t : 0;
  }
  get scrollAngleRanges() {
    return this.args.scrollAngleRanges;
  }
  get getDropTargetElementsAtPoint() {
    return this.args.getDropTargetElementsAtPoint;
  }
  get ignoreContextMenu() {
    var t;
    return (t = this.args.ignoreContextMenu) !== null && t !== void 0 ? t : !1;
  }
  get enableHoverOutsideTarget() {
    var t;
    return (t = this.args.enableHoverOutsideTarget) !== null && t !== void 0
      ? t
      : !1;
  }
  get enableKeyboardEvents() {
    var t;
    return (t = this.args.enableKeyboardEvents) !== null && t !== void 0
      ? t
      : !1;
  }
  get enableMouseEvents() {
    var t;
    return (t = this.args.enableMouseEvents) !== null && t !== void 0 ? t : !1;
  }
  get enableTouchEvents() {
    var t;
    return (t = this.args.enableTouchEvents) !== null && t !== void 0 ? t : !0;
  }
  get touchSlop() {
    return this.args.touchSlop || 0;
  }
  get delayTouchStart() {
    var t, n, r, o;
    return (o =
      (r =
        (t = this.args) === null || t === void 0
          ? void 0
          : t.delayTouchStart) !== null && r !== void 0
        ? r
        : (n = this.args) === null || n === void 0
        ? void 0
        : n.delay) !== null && o !== void 0
      ? o
      : 0;
  }
  get delayMouseStart() {
    var t, n, r, o;
    return (o =
      (r =
        (t = this.args) === null || t === void 0
          ? void 0
          : t.delayMouseStart) !== null && r !== void 0
        ? r
        : (n = this.args) === null || n === void 0
        ? void 0
        : n.delay) !== null && o !== void 0
      ? o
      : 0;
  }
  get window() {
    if (this.context && this.context.window) return this.context.window;
    if (typeof window != "undefined") return window;
  }
  get document() {
    var t;
    if (!((t = this.context) === null || t === void 0) && t.document)
      return this.context.document;
    if (this.window) return this.window.document;
  }
  get rootElement() {
    var t;
    return (
      ((t = this.args) === null || t === void 0 ? void 0 : t.rootElement) ||
      this.document
    );
  }
  constructor(t, n) {
    (this.args = t), (this.context = n);
  }
}
function qx(e, t, n, r) {
  return Math.sqrt(Math.pow(Math.abs(n - e), 2) + Math.pow(Math.abs(r - t), 2));
}
function Jx(e, t, n, r, o) {
  if (!o) return !1;
  const i = (Math.atan2(r - t, n - e) * 180) / Math.PI + 180;
  for (let l = 0; l < o.length; ++l) {
    const s = o[l];
    if (s && (s.start == null || i >= s.start) && (s.end == null || i <= s.end))
      return !0;
  }
  return !1;
}
const eE = { Left: 1, Right: 2, Center: 4 },
  tE = { Left: 0, Center: 1, Right: 2 };
function _l(e) {
  return e.button === void 0 || e.button === tE.Left;
}
function nE(e) {
  return e.buttons === void 0 || (e.buttons & eE.Left) === 0;
}
function Qh(e) {
  return !!e.targetTouches;
}
const rE = 1;
function oE(e) {
  const t = e.nodeType === rE ? e : e.parentElement;
  if (!t) return;
  const { top: n, left: r } = t.getBoundingClientRect();
  return { x: r, y: n };
}
function iE(e, t) {
  if (e.targetTouches.length === 1) return gi(e.targetTouches[0]);
  if (t && e.touches.length === 1 && e.touches[0].target === t.target)
    return gi(e.touches[0]);
}
function gi(e, t) {
  return Qh(e) ? iE(e, t) : { x: e.clientX, y: e.clientY };
}
const kd = (() => {
    let e = !1;
    try {
      addEventListener(
        "test",
        () => {},
        Object.defineProperty({}, "passive", {
          get() {
            return (e = !0), !0;
          },
        })
      );
    } catch {}
    return e;
  })(),
  or = {
    [It.mouse]: {
      start: "mousedown",
      move: "mousemove",
      end: "mouseup",
      contextmenu: "contextmenu",
    },
    [It.touch]: { start: "touchstart", move: "touchmove", end: "touchend" },
    [It.keyboard]: { keydown: "keydown" },
  };
class xr {
  profile() {
    var t;
    return {
      sourceNodes: this.sourceNodes.size,
      sourcePreviewNodes: this.sourcePreviewNodes.size,
      sourcePreviewNodeOptions: this.sourcePreviewNodeOptions.size,
      targetNodes: this.targetNodes.size,
      dragOverTargetIds:
        ((t = this.dragOverTargetIds) === null || t === void 0
          ? void 0
          : t.length) || 0,
    };
  }
  get document() {
    return this.options.document;
  }
  setup() {
    const t = this.options.rootElement;
    !t ||
      (N(!xr.isSetUp, "Cannot have two Touch backends at the same time."),
      (xr.isSetUp = !0),
      this.addEventListener(t, "start", this.getTopMoveStartHandler()),
      this.addEventListener(t, "start", this.handleTopMoveStartCapture, !0),
      this.addEventListener(t, "move", this.handleTopMove),
      this.addEventListener(t, "move", this.handleTopMoveCapture, !0),
      this.addEventListener(t, "end", this.handleTopMoveEndCapture, !0),
      this.options.enableMouseEvents &&
        !this.options.ignoreContextMenu &&
        this.addEventListener(t, "contextmenu", this.handleTopMoveEndCapture),
      this.options.enableKeyboardEvents &&
        this.addEventListener(t, "keydown", this.handleCancelOnEscape, !0));
  }
  teardown() {
    const t = this.options.rootElement;
    !t ||
      ((xr.isSetUp = !1),
      (this._mouseClientOffset = {}),
      this.removeEventListener(t, "start", this.handleTopMoveStartCapture, !0),
      this.removeEventListener(t, "start", this.handleTopMoveStart),
      this.removeEventListener(t, "move", this.handleTopMoveCapture, !0),
      this.removeEventListener(t, "move", this.handleTopMove),
      this.removeEventListener(t, "end", this.handleTopMoveEndCapture, !0),
      this.options.enableMouseEvents &&
        !this.options.ignoreContextMenu &&
        this.removeEventListener(
          t,
          "contextmenu",
          this.handleTopMoveEndCapture
        ),
      this.options.enableKeyboardEvents &&
        this.removeEventListener(t, "keydown", this.handleCancelOnEscape, !0),
      this.uninstallSourceNodeRemovalObserver());
  }
  addEventListener(t, n, r, o = !1) {
    const i = kd ? { capture: o, passive: !1 } : o;
    this.listenerTypes.forEach(function (l) {
      const s = or[l][n];
      s && t.addEventListener(s, r, i);
    });
  }
  removeEventListener(t, n, r, o = !1) {
    const i = kd ? { capture: o, passive: !1 } : o;
    this.listenerTypes.forEach(function (l) {
      const s = or[l][n];
      s && t.removeEventListener(s, r, i);
    });
  }
  connectDragSource(t, n) {
    const r = this.handleMoveStart.bind(this, t);
    return (
      this.sourceNodes.set(t, n),
      this.addEventListener(n, "start", r),
      () => {
        this.sourceNodes.delete(t), this.removeEventListener(n, "start", r);
      }
    );
  }
  connectDragPreview(t, n, r) {
    return (
      this.sourcePreviewNodeOptions.set(t, r),
      this.sourcePreviewNodes.set(t, n),
      () => {
        this.sourcePreviewNodes.delete(t),
          this.sourcePreviewNodeOptions.delete(t);
      }
    );
  }
  connectDropTarget(t, n) {
    const r = this.options.rootElement;
    if (!this.document || !r) return () => {};
    const o = (i) => {
      if (!this.document || !r || !this.monitor.isDragging()) return;
      let l;
      switch (i.type) {
        case or.mouse.move:
          l = { x: i.clientX, y: i.clientY };
          break;
        case or.touch.move:
          var s, u;
          l = {
            x:
              ((s = i.touches[0]) === null || s === void 0
                ? void 0
                : s.clientX) || 0,
            y:
              ((u = i.touches[0]) === null || u === void 0
                ? void 0
                : u.clientY) || 0,
          };
          break;
      }
      const a = l != null ? this.document.elementFromPoint(l.x, l.y) : void 0,
        c = a && n.contains(a);
      if (a === n || c) return this.handleMove(i, t);
    };
    return (
      this.addEventListener(this.document.body, "move", o),
      this.targetNodes.set(t, n),
      () => {
        this.document &&
          (this.targetNodes.delete(t),
          this.removeEventListener(this.document.body, "move", o));
      }
    );
  }
  getTopMoveStartHandler() {
    return !this.options.delayTouchStart && !this.options.delayMouseStart
      ? this.handleTopMoveStart
      : this.handleTopMoveStartDelay;
  }
  installSourceNodeRemovalObserver(t) {
    this.uninstallSourceNodeRemovalObserver(),
      (this.draggedSourceNode = t),
      (this.draggedSourceNodeRemovalObserver = new MutationObserver(() => {
        t &&
          !t.parentElement &&
          (this.resurrectSourceNode(),
          this.uninstallSourceNodeRemovalObserver());
      })),
      !(!t || !t.parentElement) &&
        this.draggedSourceNodeRemovalObserver.observe(t.parentElement, {
          childList: !0,
        });
  }
  resurrectSourceNode() {
    this.document &&
      this.draggedSourceNode &&
      ((this.draggedSourceNode.style.display = "none"),
      this.draggedSourceNode.removeAttribute("data-reactid"),
      this.document.body.appendChild(this.draggedSourceNode));
  }
  uninstallSourceNodeRemovalObserver() {
    this.draggedSourceNodeRemovalObserver &&
      this.draggedSourceNodeRemovalObserver.disconnect(),
      (this.draggedSourceNodeRemovalObserver = void 0),
      (this.draggedSourceNode = void 0);
  }
  constructor(t, n, r) {
    (this.getSourceClientOffset = (o) => {
      const i = this.sourceNodes.get(o);
      return i && oE(i);
    }),
      (this.handleTopMoveStartCapture = (o) => {
        !_l(o) || (this.moveStartSourceIds = []);
      }),
      (this.handleMoveStart = (o) => {
        Array.isArray(this.moveStartSourceIds) &&
          this.moveStartSourceIds.unshift(o);
      }),
      (this.handleTopMoveStart = (o) => {
        if (!_l(o)) return;
        const i = gi(o);
        i &&
          (Qh(o) && (this.lastTargetTouchFallback = o.targetTouches[0]),
          (this._mouseClientOffset = i)),
          (this.waitingForDelay = !1);
      }),
      (this.handleTopMoveStartDelay = (o) => {
        if (!_l(o)) return;
        const i =
          o.type === or.touch.start
            ? this.options.delayTouchStart
            : this.options.delayMouseStart;
        (this.timeout = setTimeout(this.handleTopMoveStart.bind(this, o), i)),
          (this.waitingForDelay = !0);
      }),
      (this.handleTopMoveCapture = () => {
        this.dragOverTargetIds = [];
      }),
      (this.handleMove = (o, i) => {
        this.dragOverTargetIds && this.dragOverTargetIds.unshift(i);
      }),
      (this.handleTopMove = (o) => {
        if (
          (this.timeout && clearTimeout(this.timeout),
          !this.document || this.waitingForDelay)
        )
          return;
        const { moveStartSourceIds: i, dragOverTargetIds: l } = this,
          s = this.options.enableHoverOutsideTarget,
          u = gi(o, this.lastTargetTouchFallback);
        if (!u) return;
        if (
          this._isScrolling ||
          (!this.monitor.isDragging() &&
            Jx(
              this._mouseClientOffset.x || 0,
              this._mouseClientOffset.y || 0,
              u.x,
              u.y,
              this.options.scrollAngleRanges
            ))
        ) {
          this._isScrolling = !0;
          return;
        }
        if (
          (!this.monitor.isDragging() &&
            this._mouseClientOffset.hasOwnProperty("x") &&
            i &&
            qx(
              this._mouseClientOffset.x || 0,
              this._mouseClientOffset.y || 0,
              u.x,
              u.y
            ) > (this.options.touchSlop ? this.options.touchSlop : 0) &&
            ((this.moveStartSourceIds = void 0),
            this.actions.beginDrag(i, {
              clientOffset: this._mouseClientOffset,
              getSourceClientOffset: this.getSourceClientOffset,
              publishSource: !1,
            })),
          !this.monitor.isDragging())
        )
          return;
        const a = this.sourceNodes.get(this.monitor.getSourceId());
        this.installSourceNodeRemovalObserver(a),
          this.actions.publishDragSource(),
          o.cancelable && o.preventDefault();
        const c = (l || [])
            .map((S) => this.targetNodes.get(S))
            .filter((S) => !!S),
          f = this.options.getDropTargetElementsAtPoint
            ? this.options.getDropTargetElementsAtPoint(u.x, u.y, c)
            : this.document.elementsFromPoint(u.x, u.y),
          p = [];
        for (const S in f) {
          if (!f.hasOwnProperty(S)) continue;
          let m = f[S];
          for (m != null && p.push(m); m; )
            (m = m.parentElement), m && p.indexOf(m) === -1 && p.push(m);
        }
        const y = p
          .filter((S) => c.indexOf(S) > -1)
          .map((S) => this._getDropTargetId(S))
          .filter((S) => !!S)
          .filter((S, m, C) => C.indexOf(S) === m);
        if (s)
          for (const S in this.targetNodes) {
            const m = this.targetNodes.get(S);
            if (a && m && m.contains(a) && y.indexOf(S) === -1) {
              y.unshift(S);
              break;
            }
          }
        y.reverse(), this.actions.hover(y, { clientOffset: u });
      }),
      (this._getDropTargetId = (o) => {
        const i = this.targetNodes.keys();
        let l = i.next();
        for (; l.done === !1; ) {
          const s = l.value;
          if (o === this.targetNodes.get(s)) return s;
          l = i.next();
        }
      }),
      (this.handleTopMoveEndCapture = (o) => {
        if (
          ((this._isScrolling = !1),
          (this.lastTargetTouchFallback = void 0),
          !!nE(o))
        ) {
          if (!this.monitor.isDragging() || this.monitor.didDrop()) {
            this.moveStartSourceIds = void 0;
            return;
          }
          o.cancelable && o.preventDefault(),
            (this._mouseClientOffset = {}),
            this.uninstallSourceNodeRemovalObserver(),
            this.actions.drop(),
            this.actions.endDrag();
        }
      }),
      (this.handleCancelOnEscape = (o) => {
        o.key === "Escape" &&
          this.monitor.isDragging() &&
          ((this._mouseClientOffset = {}),
          this.uninstallSourceNodeRemovalObserver(),
          this.actions.endDrag());
      }),
      (this.options = new Zx(r, n)),
      (this.actions = t.getActions()),
      (this.monitor = t.getMonitor()),
      (this.sourceNodes = new Map()),
      (this.sourcePreviewNodes = new Map()),
      (this.sourcePreviewNodeOptions = new Map()),
      (this.targetNodes = new Map()),
      (this.listenerTypes = []),
      (this._mouseClientOffset = {}),
      (this._isScrolling = !1),
      this.options.enableMouseEvents && this.listenerTypes.push(It.mouse),
      this.options.enableTouchEvents && this.listenerTypes.push(It.touch),
      this.options.enableKeyboardEvents && this.listenerTypes.push(It.keyboard);
  }
}
const lE = function (t, n = {}, r = {}) {
  return new xr(t, n, r);
};
var Js = (e, t) => ({ x: e.x - t.x, y: e.y - t.y }),
  sE = (e) => {
    let t = e.getInitialClientOffset(),
      n = e.getInitialSourceClientOffset();
    return t === null || n === null ? { x: 0, y: 0 } : Js(t, n);
  },
  uE = (e, t) => {
    let n = e.getClientOffset();
    if (n === null) return null;
    if (!t.current || !t.current.getBoundingClientRect) return Js(n, sE(e));
    let r = t.current.getBoundingClientRect(),
      o = { x: r.width / 2, y: r.height / 2 };
    return Js(n, o);
  },
  aE = (e) => {
    let t = `translate(${e.x.toFixed(1)}px, ${e.y.toFixed(1)}px)`;
    return {
      pointerEvents: "none",
      position: "fixed",
      top: 0,
      left: 0,
      transform: t,
      WebkitTransform: t,
    };
  },
  cE = () => {
    let e = g.exports.useRef(null),
      t = R1((n) => ({
        currentOffset: uE(n, e),
        isDragging: n.isDragging(),
        itemType: n.getItemType(),
        item: n.getItem(),
        monitor: n,
      }));
    return !t.isDragging || t.currentOffset === null
      ? { display: !1 }
      : {
          display: !0,
          itemType: t.itemType,
          item: t.item,
          style: aE(t.currentOffset),
          monitor: t.monitor,
          ref: e,
        };
  };
g.exports.createContext(void 0);
function dE() {
  const e = cE();
  if (!e.display) return null;
  const { item: t, style: n } = e;
  return t.item
    ? t.section === "inventory"
      ? P(Od, { item: t, style: n })
      : t.section === "chest"
      ? P(Od, { item: t, style: n })
      : null
    : null;
}
function Od({ item: e, style: t }) {
  return P("div", {
    style: {
      width: 100,
      height: 120,
      borderRadius: 5,
      overflow: "hidden",
      ...t,
    },
    children: P(pa, {
      children: j("div", {
        style: {
          display: "grid",
          width: "100%",
          height: "100%",
          alignItems: "flex-end",
        },
        children: [
          P("span", {
            style: {
              position: "absolute",
              top: 5,
              left: 5,
              fontSize: 9,
              opacity: 0.7,
            },
            children: (e.item.peso * e.item.amount).toFixed(2),
          }),
          j("div", {
            style: {
              height: "100%",
              display: "flex",
              justifyContent: "center",
              alignItems: "center",
              padding: 2,
            },
            children: [
              P("img", {
                src: e.item.url,
                width: "100%",
                height: 50,
                style: { objectFit: "contain" },
              }),
              e.item.durability
                ? P(uh, {
                    children: P(ah, {
                      css: { height: `${e.item.durability}%` },
                    }),
                  })
                : "",
            ],
          }),
          j(lh, { children: ["x", e.item.amount] }),
          P(sh, {
            css: { position: "absolute", bottom: 0 },
            children: e.item.name,
          }),
        ],
      }),
    }),
  });
}
const Td = () => {
  Yr(), Vy();
  function e(t) {
    (t == null ? void 0 : t.key) === "Escape" && Bt("invClose");
  }
  return (
    g.exports.useEffect(
      () => (
        window.addEventListener("keydown", e),
        () => {
          window.removeEventListener("keydown", e);
        }
      ),
      []
    ),
    j(u1, {
      backend: lE,
      options: { enableMouseEvents: !0 },
      children: [P(Xx, {}), P(dE, {})],
    })
  );
};
Nl.createRoot(document.getElementById("root")).render(
  P(iy, {
    children: P(gy, {
      children: P(my, {
        children: j(oy, {
          children: [
            P($s, { path: "/", element: P(Td, {}) }),
            P($s, { path: "/", element: P(Td, {}) }),
          ],
        }),
      }),
    }),
  })
);
