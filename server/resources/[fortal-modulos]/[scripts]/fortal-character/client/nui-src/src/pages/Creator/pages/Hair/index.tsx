import Cell from "./components/Cell";
import Footer from "../../components/Footer";
import Header from "../../components/Header";
import { Post } from "@/hooks/post";
import { useEffect } from "react";
import { usePartial } from "./stores/usePartial";
import { useSave } from "../../stores/useSave";

export default function Hair() {
  const partial = usePartial();
  const { current: data } = partial;
  useEffect(() => {
    Post.create(
      "Creator:GetData",
      { section: "Hair" },
      {
        eye: {
          title: "Cor dos Olhos",
          value: 1,
          min: 1,
          max: 33,
        },
        nose1: {
          title: "Altura do Nariz",
          value: 1,
          min: 1,
          max: 33,
        },
      },
    ).then(partial.set);
  }, []);
  const save = useSave();
  useEffect(() => {
    Post.create("Creator:UpdatePedPreview", { section: "hair", data });
  }, [data]);
  return (
    <div className="flex size-full items-center justify-between overflow-visible">
      <div className="flex w-[20.125rem] flex-col items-center overflow-visible">
        <Header />
        <ul className="scroll-hidden mb-2 mt-6 flex h-[37.0625rem] w-full flex-col gap-3.5 overflow-y-scroll">
          {Object.keys(data).map((key) => {
            const char = data[key];
            return <Cell key={key} descriminator={key} data={char} />;
          })}
        </ul>
        <Footer canReturn page="4" isSave canClick={save.current} />
      </div>
    </div>
  );
}
