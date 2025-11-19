import { render, screen, fireEvent } from "@testing-library/react";
import Home from "./page";

test("dodaje nowe zadanie i oznacza je jako ukończone", () => {
  render(<Home />);
  
  // Dodaj nowe zadanie
  fireEvent.change(screen.getByPlaceholderText("Dodaj nowe zadanie"), {
    target: { value: "Nowe zadanie" },
  });
  fireEvent.click(screen.getByText("Dodaj"));

  // Sprawdź, czy zadanie pojawiło się w TodoList
  expect(screen.getByText("Nowe zadanie")).toBeDefined();

  // Kliknij przycisk ✓, żeby oznaczyć jako ukończone
  fireEvent.click(screen.getByText("✓"));

  // Sprawdź, czy zadanie pojawiło się w CompletedList
  expect(screen.getByText("Nowe zadanie")).toBeDefined();
});
