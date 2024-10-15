FROM python:3

WORKDIR /app

# Copy the Django project files
COPY . /app/

# Install dependencies
RUN pip install -r requirements.txt

# Expose the port that the Django app will run on
EXPOSE 8000

# Set the entrypoint to run Django
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]