class Court:
    """ Represents a sports court that can be booked."""

    def __init__(self, court_id, name):
        self.court_id = court_id
        self.name = name

    def __str__(self):
        return f"{self.court_id} - {self.name}"
