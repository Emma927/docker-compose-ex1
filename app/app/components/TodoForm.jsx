'use client';

import React from "react";
import { useForm } from "react-hook-form";
import { zodResolver } from "@hookform/resolvers/zod";
import { z } from "zod";
import { v4 as uuidv4 } from "uuid";

const taskSchema = z.object({
  title: z.string().min(1, "Pole zadania nie może być puste"),
});

export default function TodoForm({ onAddTask = () => {} }) {
  const {
    register,
    handleSubmit,
    reset,
    formState: { errors },
  } = useForm({
    resolver: zodResolver(taskSchema),
  });

  const onSubmit = (data) => {
    const newTask = { id: uuidv4(), title: data.title };

    if (typeof onAddTask === "function") {
      onAddTask(newTask);
    } else {
      console.warn("onAddTask nie jest funkcją!");
    }

    reset();
  };

  return (
    <form onSubmit={handleSubmit(onSubmit)} style={{ marginBottom: "1rem" }}>
      <input
        {...register("title")}
        placeholder="Dodaj nowe zadanie"
        style={{ padding: "0.5rem", width: "70%" }}
      />
      <button type="submit" style={{ padding: "0.5rem", marginLeft: "0.5rem" }}>
        Dodaj
      </button>
      {errors.title && <p style={{ color: "red" }}>{errors.title.message}</p>}
    </form>
  );
}
