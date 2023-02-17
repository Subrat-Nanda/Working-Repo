-- shipper

INSERT INTO shipper (shipper_name, phone_number) VALUES
  ('DHŁ', '134654324'), ('OutPost', '968522515'),
  ('Poczta Polska', '651115311'), ('DBD', '532225222'),
  ('UPSsss', '424111155'), ('GiLS', '110594033'),
  ('FedEXP', '500202343'), ('Pocztext', '602028199'),
  ('TNT - explosives', '110054698'), ('OPECK', '842000224'),
  ('geSCHENKER', '549282095'), ('IKS-Press', '406593928'),
  ('Amarzon', '324106532');
  
  
  -- status
  
INSERT INTO status (status) VALUES
  ('AWAITING'),
  ('PAID'),
  ('SENT'),
  ('DELIVERED'),
  ('FAILED'),
  ('CANCELLED'),
  ('SUCCESSED')