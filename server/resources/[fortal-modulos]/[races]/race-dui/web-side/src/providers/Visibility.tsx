import React, { createContext, useState } from "react";

import type { Data } from "@/types";
import { useObserve } from "@/hooks/useObserve";

export const DataContext = createContext<{
  current: Data | null;
  set: (e: Data) => void;
} | null>(null);

export const VisibilityProvider: React.FC<{ children: React.ReactNode }> = ({
  children,
}) => {
  const [data, setData] = useState<Data | null>(null);

  useObserve<Data>("data", setData);

  return (
    <DataContext.Provider value={{ current: data, set: setData }}>
      {children}
    </DataContext.Provider>
  );
};
