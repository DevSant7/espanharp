import { create } from "zustand";

type Data = {
  name: string;
  surname: string;
  age: string;
  gender: string;
  father: number;
  mother: number;
  paternity: number;
  color: number;
};

interface NuiFrame {
  current: Data;

  setName: (name: string) => void;
  setSurname: (surname: string) => void;
  setAge: (age: string) => void;
  setGender: (gender: string) => void;
  setFather: (father: number) => void;
  setMother: (mother: number) => void;
  setPaternity: (paternity: number) => void;
  setColor: (color: number) => void;
}

export const useGenetics = create<NuiFrame>((set) => ({
  current: {
    name: "",
    surname: "",
    age: "",
    gender: "m",
    father: 0,
    mother: 0,
    paternity: 50,
    color: 0
  },

  setName: (name) => set((state) => ({ current: { ...state.current, name } })),
  setSurname: (surname) =>
    set((state) => ({ current: { ...state.current, surname } })),
  setAge: (age) => set((state) => ({ current: { ...state.current, age } })),
  setGender: (gender) =>
    set((state) => ({ current: { ...state.current, gender } })),
  setFather: (father) =>
    set((state) => ({ current: { ...state.current, father } })),
  setMother: (mother) =>
    set((state) => ({ current: { ...state.current, mother } })),
  setPaternity: (paternity) =>
    set((state) => ({ current: { ...state.current, paternity } })),
  setColor: (color) =>
    set((state) => ({ current: { ...state.current, color } })),
}));
