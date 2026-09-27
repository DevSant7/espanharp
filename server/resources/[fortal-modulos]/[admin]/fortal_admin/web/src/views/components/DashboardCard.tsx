import { ReactNode } from "react";

interface DashboardCardProps {
  title: string;
  description: string;
  icon: ReactNode;
  inputPlaceholder?: string;
  inputValue?: string;
  onInputChange?: (value: string) => void;
  primaryButtonLabel: ReactNode;
  onPrimaryClick: () => void;
  secondaryButtonLabel?: string;
  onSecondaryClick?: () => void;
}

export function DashboardCard({
  title,
  description,
  icon,
  inputPlaceholder,
  inputValue,
  onInputChange,
  primaryButtonLabel,
  onPrimaryClick,
  secondaryButtonLabel,
  onSecondaryClick,
}: DashboardCardProps) {
  return (
    <div
      className="w-[13.25rem] h-[8.4375rem] rounded-md border border-[rgba(255,255,255,0.03)] p-[.88rem] flex flex-col justify-between"
      style={{
        background:
          "radial-gradient(95.47% 60.03% at 49.84% 76.67%, rgba(255, 255, 255, 0.03) 0%, rgba(255, 255, 255, 0.00) 100%), linear-gradient(91deg, rgba(255, 255, 255, 0.01) 0%, rgba(255, 255, 255, 0.01) 100%)",
      }}
    >
      {/* Cabeçalho */}
      <div className="flex items-start justify-between">
        <div className="flex-1">
          <h3 className="text-base font-bold text-white/85">{title}</h3>
          <p className="text-[.7125rem] text-white/35 font-medium">
            {description}
          </p>
        </div>
        <div className="text-white/70">{icon}</div>
      </div>

      {/* Input + Botões */}
      {inputPlaceholder && (
        <div className="flex gap-2">
          <input
            type="text"
            placeholder={inputPlaceholder}
            value={inputValue || ""}
            onChange={(e) => onInputChange?.(e.target.value)}
            className="w-[8.875rem] h-[2.1875rem] rounded border border-white/10 px-2 py-1 text-white focus:outline-none focus:border-white/20 placeholder-white/65 text-base font-bold"
            style={{
              background:
                "radial-gradient(95.47% 60.03% at 49.84% 76.67%, rgba(255, 255, 255, 0.06) 0%, rgba(255, 255, 255, 0.00) 100%), linear-gradient(91deg, rgba(255, 255, 255, 0.01) 0%, rgba(255, 255, 255, 0.01) 100%)",
            }}
          />
          <button
            onClick={onPrimaryClick}
            className="px-2 py-1 text-base font-bold rounded text-white/65 transition border border-white/[.05]"
            style={{
              background:
                "radial-gradient(95.47% 60.03% at 49.84% 76.67%, rgba(255, 255, 255, 0.03) 0%, rgba(255, 255, 255, 0.00) 100%), linear-gradient(91deg, rgba(255, 255, 255, 0.01) 0%, rgba(255, 255, 255, 0.01) 100%)",
            }}
          >
            {primaryButtonLabel}
          </button>
          {secondaryButtonLabel && onSecondaryClick && (
            <button
              onClick={onSecondaryClick}
              className="px-3 py-1 text-base font-bold rounded text-white/65 transition border border-white/[.05]"
              style={{
                background:
                  "radial-gradient(95.47% 60.03% at 49.84% 76.67%, rgba(255, 255, 255, 0.03) 0%, rgba(255, 255, 255, 0.00) 100%), linear-gradient(91deg, rgba(255, 255, 255, 0.01) 0%, rgba(255, 255, 255, 0.01) 100%)",
              }}
            >
              {secondaryButtonLabel}
            </button>
          )}
        </div>
      )}

      {/* Apenas Botões (quando não há input) */}
      {!inputPlaceholder && (
        <div className="flex gap-2">
          <button
            onClick={onPrimaryClick}
            className="w-full px-3 py-1 text-base font-bold rounded text-white/65 transition border border-white/[.05]"
            style={{
              background:
                "radial-gradient(95.47% 60.03% at 49.84% 76.67%, rgba(255, 255, 255, 0.03) 0%, rgba(255, 255, 255, 0.00) 100%), linear-gradient(91deg, rgba(255, 255, 255, 0.01) 0%, rgba(255, 255, 255, 0.01) 100%)",
            }}
          >
            {primaryButtonLabel}
          </button>
          {secondaryButtonLabel && onSecondaryClick && (
            <button
              onClick={onSecondaryClick}
              className="px-3 py-1 text-base font-bold rounded text-white/65 transition border border-white/[.05]"
              style={{
                background:
                  "radial-gradient(95.47% 60.03% at 49.84% 76.67%, rgba(255, 255, 255, 0.03) 0%, rgba(255, 255, 255, 0.00) 100%), linear-gradient(91deg, rgba(255, 255, 255, 0.01) 0%, rgba(255, 255, 255, 0.01) 100%)",
              }}
            >
              {secondaryButtonLabel}
            </button>
          )}
        </div>
      )}
    </div>
  );
}

export default DashboardCard;
