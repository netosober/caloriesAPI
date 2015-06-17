json.meal do
  json.id @meal.id
    json.description @meal.description
    json.calories @meal.calories
      json.day @meal.day
        json.hour @meal.hour
end
