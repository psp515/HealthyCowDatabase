CREATE UNIQUE CLUSTERED INDEX MealInMenu
ON Menu(MenuMealId)

CREATE NONCLUSTERED INDEX Meal
ON Menu(MealId)
