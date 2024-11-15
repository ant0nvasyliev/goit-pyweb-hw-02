# Docker-команда FROM вказує базовий образ контейнера
# Наш базовий образ - це Linux з попередньо встановленим python-3.13
FROM python:3.13-slim

# Встановимо змінну середовища
ENV APP_HOME /main

# Встановимо робочу директорію всередині контейнера
WORKDIR $APP_HOME

# Встановимо залежності всередині контейнера
COPY pyproject.toml $APP_HOME/pyproject.toml
COPY poetry.lock $APP_HOME/poetry.lock

# Встановлюємо poetry та залежності
RUN pip install poetry
RUN poetry config virtualenvs.create false && poetry install --only main

# Скопіюємо інші файли в робочу директорію контейнера
COPY . .

# Позначимо порт, де працює застосунок всередині контейнера
EXPOSE 5000

# Запустимо наш застосунок всередині контейнера
CMD ["python", "main.py"]


# Створення образу --- docker build -t phone-book .
# Створення контейнеру docker run -it phone-book /bin/bashcd