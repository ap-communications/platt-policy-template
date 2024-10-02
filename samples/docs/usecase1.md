# Policy definitions : Usecase 1

We assume the following policy definition in this case.

![usecase 1 image](./usecase1.drawio.png)

## Role

We have three types of roles.

###  Administration role

Users in the `administrators` group have all permissions granted.

### External vendor role

Users in the 'Vendor X' group have pecific permisions:

- Users can read catalog entities that are owned by `Team A`.
- Users are not allowed any other operations including using scaffolders.

Users in the 'Vendor Y' group have different permissions:

- Users can create and read catalog entities that are owned by `Team B`, but they are not allowed to delete them.
- Users are not allowed any other operations including using scaffolders.


### Default role


All other users has the default role:

- Users can create and read all catalog entities.
- Users can delete the catalog entities that they own.
- Users are not allowed to execute all scaffolder operations.
- User are not allowed any other (unknown) operations.
