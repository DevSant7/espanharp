import { create } from "zustand";

type Data = string | false;

interface NuiFrame {
  current: Data;
  set: (current: Data) => void;
}

export const useCamera = create<NuiFrame>((set: any) => ({
  current: "face",
  set: (current: Data) => set({ current }),
}));
