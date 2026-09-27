import { DataContext } from "@/providers/Visibility";
import { useContext } from "react";

export const useData = () => {
  return useContext(DataContext);
};
