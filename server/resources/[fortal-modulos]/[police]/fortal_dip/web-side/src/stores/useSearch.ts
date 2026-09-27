import { IPlayerSearch } from "@/types";
import { create } from "zustand";

interface PlayerSearchFrame {
  current: IPlayerSearch[];
  set: (current: IPlayerSearch[]) => void;
}

export const usePlayerSearch = create<PlayerSearchFrame>((set) => ({
  current: [],
  set: (current: IPlayerSearch[]) => set({ current }),
}));
