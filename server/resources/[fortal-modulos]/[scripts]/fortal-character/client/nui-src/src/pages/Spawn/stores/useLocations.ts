import { create } from "zustand";

export type Location = {
    id: string;
    name: string;
    image: string;
}

interface NuiFrame {
  current: Location[];
  set: (current: Location[]) => void;
}

export const useLocations = create<NuiFrame>((set: any) => ({
  current: [],
  set: (current: Location[]) => set({ current }),
}));
