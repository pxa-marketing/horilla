"""
horilla/storage_backends.py

Custom storage backend for Hetzner S3 private media storage.
"""

from django.db import models
from storages.backends.s3boto3 import S3Boto3Storage


class PrivateMediaStorage(S3Boto3Storage):
    """
    PrivateMediaStorage - Stores media files privately in Hetzner S3 bucket.
    """

    location = "media"
    default_acl = "private"
    file_overwrite = False
    custom_domain = False


# To set the private storage globally
models.FileField.storage = PrivateMediaStorage()
models.ImageField.storage = PrivateMediaStorage()
