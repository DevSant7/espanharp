import React, { useState } from "react";
import { ArrowUpRight, ArrowDownLeft, DollarSign } from "lucide-react";

interface QuickActionsProps {
  className?: string;
  onDeposit?: (amount: number) => void;
  onWithdraw?: (amount: number) => void;
}

const QuickActions: React.FC<QuickActionsProps> = ({
  className,
  onDeposit,
  onWithdraw,
}) => {
  const [activeAction, setActiveAction] = useState<"deposit" | "withdraw">(
    "deposit"
  );
  const [amount, setAmount] = useState<string>("");

  const handleAmountChange = (value: string) => {
    const cleanValue = value.replace(/[^\d.,]/g, "");
    setAmount(cleanValue);
  };

  const formatAmount = (value: string) => {
    if (!value || value === "" || value === "0") return "";

    const numericValue = parseFloat(value.replace(",", "."));
    if (isNaN(numericValue)) return "";

    return new Intl.NumberFormat("pt-BR", {
      style: "currency",
      currency: "BRL",
    }).format(numericValue);
  };

  const handleConfirm = () => {
    const numericAmount = parseFloat(amount.replace(",", "."));
    if (isNaN(numericAmount) || numericAmount <= 0) return;

    if (activeAction === "deposit" && onDeposit) {
      onDeposit(numericAmount);
    } else if (activeAction === "withdraw" && onWithdraw) {
      onWithdraw(numericAmount);
    }

    setAmount("");
  };

  return (
    <div
      className={`flex flex-col rounded-md p-4 h-[13.5rem] max-h-[13.5rem] overflow-hidden ${className}`}
      style={{
        background:
          "radial-gradient(95.47% 60.03% at 49.84% 76.67%, rgba(255, 255, 255, 0.02) 0%, rgba(255, 255, 255, 0.00) 100%), rgba(255, 255, 255, 0.01)",
      }}
    >
      <div className="flex items-center gap-2 mb-3">
        <svg
          xmlns="http://www.w3.org/2000/svg"
          width=".625rem"
          height=".625rem"
          viewBox="0 0 10 10"
          fill="none"
        >
          <path
            d="M0 5C0 5.14734 0.0585316 5.28865 0.162718 5.39284C0.266905 5.49702 0.408213 5.55556 0.555556 5.55556H3.88889C4.03623 5.55556 4.17754 5.49702 4.28173 5.39284C4.38591 5.28865 4.44444 5.14734 4.44444 5V0.555556C4.44444 0.408213 4.38591 0.266905 4.28173 0.162718C4.17754 0.0585316 4.03623 0 3.88889 0H0.555556C0.408213 0 0.266905 0.0585316 0.162718 0.162718C0.0585316 0.266905 0 0.408213 0 0.555556V5ZM0 9.44444C0 9.59179 0.0585316 9.7331 0.162718 9.83728C0.266905 9.94147 0.408213 10 0.555556 10H3.88889C4.03623 10 4.17754 9.94147 4.28173 9.83728C4.38591 9.7331 4.44444 9.59179 4.44444 9.44444V7.22222C4.44444 7.07488 4.38591 6.93357 4.28173 6.82939C4.17754 6.7252 4.03623 6.66667 3.88889 6.66667H0.555556C0.408213 6.66667 0.266905 6.7252 0.162718 6.82939C0.0585316 6.93357 0 7.07488 0 7.22222V9.44444ZM5.55556 9.44444C5.55556 9.59179 5.61409 9.7331 5.71827 9.83728C5.82246 9.94147 5.96377 10 6.11111 10H9.44444C9.59179 10 9.7331 9.94147 9.83728 9.83728C9.94147 9.7331 10 9.59179 10 9.44444V5C10 4.85266 9.94147 4.71135 9.83728 4.60716C9.7331 4.50298 9.59179 4.44444 9.44444 4.44444H6.11111C5.96377 4.44444 5.82246 4.50298 5.71827 4.60716C5.61409 4.71135 5.55556 4.85266 5.55556 5V9.44444ZM6.11111 0C5.96377 0 5.82246 0.0585316 5.71827 0.162718C5.61409 0.266905 5.55556 0.408213 5.55556 0.555556V2.77778C5.55556 2.92512 5.61409 3.06643 5.71827 3.17061C5.82246 3.2748 5.96377 3.33333 6.11111 3.33333H9.44444C9.59179 3.33333 9.7331 3.2748 9.83728 3.17061C9.94147 3.06643 10 2.92512 10 2.77778V0.555556C10 0.408213 9.94147 0.266905 9.83728 0.162718C9.7331 0.0585316 9.59179 0 9.44444 0H6.11111Z"
            fill="white"
            fill-opacity="0.25"
          />
        </svg>
        <h3 className="text-white/40 text-sm font-normal">Ações rápidas</h3>
      </div>

      <div className="flex rounded-md bg-white/[0.05] p-1 mb-3">
        <button
          onClick={() => setActiveAction("deposit")}
          className={`flex-1 flex items-center justify-center gap-2 px-3 py-1.5 rounded text-sm font-medium transition-all ${
            activeAction === "deposit"
              ? "bg-[#df5454] text-white shadow-lg"
              : "text-white/60 hover:text-white/80"
          }`}
        >
          <ArrowDownLeft size={14} />
          DEPOSITAR
        </button>
        <button
          onClick={() => setActiveAction("withdraw")}
          className={`flex-1 flex items-center justify-center gap-2 px-3 py-1.5 rounded text-sm font-medium transition-all ${
            activeAction === "withdraw"
              ? "bg-[#B35B5B] text-white shadow-lg"
              : "text-white/60 hover:text-white/80"
          }`}
        >
          <ArrowUpRight size={14} />
          SACAR
        </button>
      </div>

      <div className="flex-1 flex items-center justify-center">
        <div className="w-full">
          <input
            type="text"
            value={amount}
            onChange={(e) => handleAmountChange(e.target.value)}
            placeholder="Digite o valor (ex: 100)"
            className="w-full bg-white/[0.05] border border-white/[0.1] rounded-md px-4 py-3 text-white text-center placeholder-white/40 focus:outline-none focus:border-[#df5454] transition-colors text-lg"
          />
        </div>
      </div>

      <div className="mt-3">
        <button
          onClick={handleConfirm}
          disabled={
            !amount ||
            amount === "" ||
            parseFloat(amount.replace(",", ".")) <= 0
          }
          className={`w-full h-[2rem] rounded-md font-medium text-sm transition-all ${
            activeAction === "deposit"
              ? "bg-[#df5454] hover:bg-[#2E6BB8] text-white"
              : "bg-[#B35B5B] hover:bg-[#9A4A4A] text-white"
          } disabled:opacity-50 disabled:cursor-not-allowed`}
        >
          CONFIRMAR
        </button>
      </div>
    </div>
  );
};

export default QuickActions;
