from flask_sqlalchemy import SQLAlchemy

db = SQLAlchemy()


class Talk(db.Model):
    __tablename__ = 'talk'

    id = db.Column(db.Integer, primary_key=True)

    title = db.Column(db.String)
    description = db.Column(db.String)
    authors = db.Column(db.String)

    date_created = db.Column(
        db.DateTime, default=db.func.current_timestamp())
    date_modified = db.Column(
        db.DateTime, default=db.func.current_timestamp(),
        onupdate=db.func.current_timestamp())

    def __str__(self):
        return str(self.id)

    def __repr__(self):
        return '<Talk %r>' % self.id


class Vote(db.Model):
    __tablename__ = 'vote'

    id = db.Column(db.Integer, primary_key=True)
    value = db.Column(db.String)
    processed = db.Column(db.Boolean, default=False)

    date_created = db.Column(
        db.DateTime, default=db.func.current_timestamp())
    date_modified = db.Column(
        db.DateTime, default=db.func.current_timestamp(),
        onupdate=db.func.current_timestamp())

    def __str__(self):
        return str(self.id)

    def __repr__(self):
        return '<Vote %r>' % self.id
