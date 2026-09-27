import { ReactNode, useEffect, useState } from "react";

export const Title = ({ children }: { children: ReactNode }) => {
  const [loading, setLoading] = useState(false);
  const [content, setContent] = useState<ReactNode>(children);
  const [animateKey, setAnimateKey] = useState(0);

  useEffect(() => {
    setLoading(true);
    setAnimateKey((prev) => prev + 1);

    const timeout = setTimeout(() => {
      setContent(children);
      setLoading(false);
    }, 300);

    return () => clearTimeout(timeout);
  }, [children]);

  return (
    <div className="relative flex h-[2.5vw] w-full items-center gap-[.5vw] overflow-hidden border-b border-solid border-[#FFFFFF08] px-[1vw]">
      {content}

      {loading && (
        <div
          key={animateKey}
          className="animate-loading-bar absolute bottom-0 left-0 h-[.05vw] bg-white/50"
        />
      )}
    </div>
  );
};
