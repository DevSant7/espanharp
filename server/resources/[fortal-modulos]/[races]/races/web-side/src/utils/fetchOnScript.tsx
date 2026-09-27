export async function fetchOnScript<T = any>(eventName: string, data?: T): Promise<{ success: boolean; data?: T; error?: string }> {
  try {
    const resourceName = (window as any).GetParentResourceName?.() || "script-fiveM";
    const url = `https://${resourceName}/${eventName}`;

    const response = await fetch(url, {
      method: "POST",
      headers: {
        "Content-Type": "application/json; charset=UTF-8",
      },
      body: JSON.stringify(data),
    });

    if (!response.ok) {
      return { success: false, error: `Error: ${response.status} - ${response.statusText}` };
    }

    const responseData = await response.json();
    return { success: true, data: responseData };
  } catch (error) {
    return { success: false, error: "Error: interno ao processar a requisição" };
  }
}
