import { create } from "zustand";

type Data = {
  options: string[];
  edited: boolean;
  selected: number;
  initial: number;
};

interface NuiFrame {
  current: Data;
  setOptions: (options: string[]) => void;
  setSelected: (selected: number) => void;
  setEdited: (edited: boolean) => void;
  setInitial: (initial: number) => void;
}

export const useHair = create<NuiFrame>((set: any) => ({
  current: {
    options: [],
    edited: false,
    selected: 0,
    initial: 0,
  },
  setOptions: (options: string[]) =>
    set((h: NuiFrame) => ({ current: { ...h.current, options } })),
  setSelected: (selected: number) =>
    set((h: NuiFrame) => ({current: { ...h.current, selected } })),
  setEdited: (edited: boolean) =>
    set((h: NuiFrame) => ({ current: { ...h.current, edited } })),
  setInitial: (initial: number) =>
    set((h: NuiFrame) => ({ current: { ...h.current, initial } })),
}));
