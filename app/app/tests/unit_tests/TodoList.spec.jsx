import { describe, it, expect } from "vitest";
import { render, screen, fireEvent } from "@testing-library/react";
import TodoList from "./TodoList";

describe("TodoList", () => {
  it("wyświetla brak zadań, gdy lista jest pusta", () => {
    render(<TodoList tasks={[]} onComplete={() => {}} />);
    expect(screen.getByText("Brak zadań")).toBeDefined();
  });

  it("wyświetla zadania z props", () => {
    const tasks = [{ id: 1, title: "Testowe zadanie" }];
    render(<TodoList tasks={tasks} onComplete={() => {}} />);
    expect(screen.getByText("Testowe zadanie")).toBeDefined();
  });
});
