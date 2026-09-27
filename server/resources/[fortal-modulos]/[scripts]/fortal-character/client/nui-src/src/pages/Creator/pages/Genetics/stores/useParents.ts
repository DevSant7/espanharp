import { create } from "zustand";

type Data = {
  name: string;
  id: number;
  image: string;
};

export type Parents = {
  fathers: Data[],
  mothers: Data[]
}

interface NuiFrame {
  current: Parents;
  set: (current: Parents) => void;
}

export const useParents = create<NuiFrame>((set) => ({
  current: {
    fathers: [],
    mothers: []
  },

  set: (current: Parents) => set({ current }),
}));
