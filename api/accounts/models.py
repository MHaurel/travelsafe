from django.db import models
from django.contrib.auth.models import AbstractBaseUser, BaseUserManager
from django.contrib.auth.hashers import make_password

from criteria.models import Criteria


class UsersManager(BaseUserManager):
    def create_user(self, email, password=None, **extra_fields):
        """
        Creates and saves a User with the given email and password.
        """
        if not email:
            raise ValueError('Users must have an email address')
        user = self.model(
            email=self.normalize_email(email), **extra_fields
        )
        user.password = make_password(password)
        user.save(using=self._db)
        return user

    def create_staffuser(self, email, password):
        """
        Creates and saves a staff user with the given email and password.
        """
        user = self.create_user(
            email,
            password=password,
        )
        user.staff = True
        user.save(using=self._db)
        return user

    def create_superuser(self, email, password):
        """
        Creates and saves a superuser with the given email and password.
        """
        user = self.create_user(
            email,
            password=password,
        )
        user.staff = True
        user.admin = True
        user.save(using=self._db)
        return user


class CustomUser(AbstractBaseUser):
    id = models.AutoField(primary_key=True)
    email = models.EmailField(unique=True, max_length=255)
    first_name = models.CharField(max_length=100)
    last_name = models.CharField(max_length=100)
    active = models.BooleanField(default=True)
    staff = models.BooleanField(default=False)
    admin = models.BooleanField(default=False)
    time_stamp = models.TimeField(auto_now_add=True)

    # Criteria
    # Femmes et enfants
    criteria_women_children = models.ForeignKey(
        Criteria, on_delete=models.CASCADE, blank=True, null=True, related_name="criteria_women_children")

    # Sécurité
    criteria_security = models.ForeignKey(
        Criteria, on_delete=models.CASCADE, blank=True, null=True, related_name="criteria_security")

    # Sanitaires
    criteria_sanitary = models.ForeignKey(
        Criteria, on_delete=models.CASCADE, blank=True, null=True, related_name="criteria_sanitary")

    # Climat sociopolitique
    criteria_sociopolitical = models.ForeignKey(
        Criteria, on_delete=models.CASCADE, blank=True, null=True, related_name="criteria_sociopolitical")

    # Conséquences liées au changement politique du pays
    criteria_climate = models.ForeignKey(
        Criteria, on_delete=models.CASCADE, blank=True, null=True, related_name="criteria_climate")

    # Us et coutumes
    criteria_customs = models.ForeignKey(
        Criteria, on_delete=models.CASCADE, blank=True, null=True, related_name="criteria_customs")

    # LGBTQ+
    criteria_lgbt = models.ForeignKey(
        Criteria, on_delete=models.CASCADE, blank=True, null=True, related_name="criteria_lgbt")

    # Allergies alimentaires
    criteria_allergy = models.ForeignKey(
        Criteria, on_delete=models.CASCADE, blank=True, null=True, related_name="criteria_allergy")

    USERNAME_FIELD = 'email'
    REQUIRED_FIELDS = []

    def get_first_name(self):
        return self.email

    def get_short_name(self):
        return self.email

    def __str__(self):
        return self.email

    def has_perm(self, perm, obj=None):
        return self.is_staff

    def has_module_perms(self, app_label):
        return self.is_staff

    @property
    def is_staff(self):
        "Is the user a member of staff?"
        return self.staff

    @property
    def is_admin(self):
        "Is the user a admin member?"
        return self.admin

    @property
    def is_active(self):
        "Is the user active?"
        return self.active

    objects = UsersManager()
