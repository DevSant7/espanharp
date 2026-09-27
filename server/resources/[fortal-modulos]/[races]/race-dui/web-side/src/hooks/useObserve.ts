import { useEffect } from "react";

function isValidJSON(value: string): boolean {
  try {
    JSON.parse(value);
    return true;
  } catch {
    return false;
  }
}

export function useObserve<T>(
  param: string,
  handle: (value: T | null) => void,
) {
  useEffect(() => {
    const url = new URL(window.location.href);
    const paramValue = url.searchParams.get(param);

    if (paramValue && isValidJSON(paramValue)) {
      handle(JSON.parse(paramValue) as T);
    } else {
      handle(null);
    }
  }, [param, handle]);
}
