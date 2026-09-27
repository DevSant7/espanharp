import { create } from "zustand";

type Data = {
  title: string;
  value: number;
  min: number;
  max: number;
  camera?: string;
};

interface NuiFrame {
  current: Record<string, Data>;
  initial: Record<string, Data>;
  set: (current: Record<string, Data>) => void;
  update: (id: string, value: number) => void;
  increment: (id: string) => void;
  decrement: (id: string) => void;
}

export const usePartial = create<NuiFrame>((set) => ({
  current: {},
  initial: {},

  set: (newData) => {
    const mergedCurrent: Record<string, Data> = {};
    const mergedInitial: Record<string, Data> = {};

    for (const key in newData) {
      mergedCurrent[key] = newData[key];
      mergedInitial[key] = structuredClone(newData[key]);
    }

    set({
      current: mergedCurrent,
      initial: mergedInitial,
    });
  },

  update: (id, value) =>
    set((state) => {
      const existing = state.current[id];
      if (!existing) return state;

      return {
        current: {
          ...state.current,
          [id]: {
            ...existing,
            value,
          },
        },
      };
    }),

  increment: (id) =>
    set((state) => {
      const item = state.current[id];
      if (!item) return state;

      const newValue = Math.min(item.value + 1, item.max);
      return {
        current: {
          ...state.current,
          [id]: {
            ...item,
            value: newValue,
          },
        },
      };
    }),

  decrement: (id) =>
    set((state) => {
      const item = state.current[id];
      if (!item) return state;

      const newValue = Math.max(item.value - 1, item.min);
      return {
        current: {
          ...state.current,
          [id]: {
            ...item,
            value: newValue,
          },
        },
      };
    }),
}));
