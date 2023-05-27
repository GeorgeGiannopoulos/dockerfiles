FROM python:latest

ENV PROJECT_HOME=/app

# Prepare Python Environment:
RUN python -m pip install --upgrade pip

WORKDIR ${PROJECT_HOME}

# Install dependencies:
COPY requirements.txt ${PROJECT_HOME}
RUN pip install -r requirements.txt

# Copy Source code:
COPY . ${PROJECT_HOME}

# Expose to the World:
# EXPOSE XXXX

# Ensure Persistence of Data:
# VOLUME ["/path/to/the/data"]

# Run the application:
ENTRYPOINT [ "python" ]
CMD [ "run.py" ]
