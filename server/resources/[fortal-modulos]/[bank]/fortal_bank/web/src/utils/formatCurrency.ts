export function formatCurrency(value: number | string | null | undefined): string {
  const numeric = Number(value);
  const safe = isNaN(numeric) ? 0 : numeric;
  return safe.toLocaleString('pt-BR', { minimumFractionDigits: 2, maximumFractionDigits: 2 });
}
