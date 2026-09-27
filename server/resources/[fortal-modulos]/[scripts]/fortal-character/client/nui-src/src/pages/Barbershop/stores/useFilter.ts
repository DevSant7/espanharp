import { create } from "zustand";

type Data = string;

interface NuiFrame {
  current: Data;
  set: (current: Data) => void;
}

export const useFilter = create<NuiFrame>((set: any) => ({
  current: "hair",
  set: (current: Data) => set({ current }),
}));
