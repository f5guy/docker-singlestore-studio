from hashlib import sha1
print("*" + sha1(sha1('secretpass@123'.encode('utf-8')).digest()).hexdigest().upper())
