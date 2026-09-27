import { create } from "zustand";

export type Appearance = {
  title: string;
  value: number;
  min: number;
  max: number;
  step: number;
  camera?: string;
};

interface NuiFrame {
  current: Record<string, Appearance>;
  set: (current: Record<string, Appearance>) => void;
  update: (id: string, value: number) => void;
  increment: (id: string) => void;
  decrement: (id: string) => void;
}

export const usePartial = create<NuiFrame>((set) => ({
  current: {},

  set: (current) => set({ current }),

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

      const newValue = Math.min(item.value + (item.step || 1), item.max);

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

      const newValue = Math.max(item.value - (item.step || 1), item.min);

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
