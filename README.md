# Brighter API assignment

## Installation

```
 bundle install
 ./migrate.rb --recreate
 unicorn / rackup / (other rack server)
```

## Testing

From the root directory:

```
./migrate.rb --recreate
rspec
```

For a more long-term permanent project I would include automatic recreation of the db, and the option to use a different DB for testing 

## Notes

I chose to give the subscription (UserPlan class) a status field rather than deleting a record from a database when the user unsubscribes as I believe it's important to keep historical records for this kind of thing.

