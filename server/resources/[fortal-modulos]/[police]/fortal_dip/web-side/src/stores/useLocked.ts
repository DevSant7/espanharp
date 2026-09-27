import { IOptions, ISelectUsers } from "@/types";

import { create } from "zustand";

interface OptionsFrame {
  current: IOptions;
  set: (current: IOptions) => void;
}

interface SelectUserFrame {
  current: ISelectUsers;
  set: (current: ISelectUsers) => void;
}

interface DescriptionFrame {
  current: string;
  set: (current: string) => void;
}

export const useDescription = create<DescriptionFrame>((set) => ({
  current: "",
  set: (current: string) => set({ current }),
}));

export const useSelectUsers = create<SelectUserFrame>((set) => ({
  current: {
    suspects: [],
    infractions: [],
  },
  set: (current: ISelectUsers) => set({ current }),
}));

export const useOptions = create<OptionsFrame>((set) => ({
  current: {
    suspect: [],
    infractions: [],
  },
  set: (current: IOptions) => set({ current }),
}));
