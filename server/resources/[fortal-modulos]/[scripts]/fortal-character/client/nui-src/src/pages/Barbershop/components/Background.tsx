export function Background({ children }: { children: React.ReactNode }) {
  return (
    <div className="flex h-screen w-screen items-center overflow-visible bg-gradient-to-l from-primary/10 from-[-107%] to-transparent pl-9">
      {children}
    </div>
  );
}
