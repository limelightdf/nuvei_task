import json
import boto3

print('Enter Regin name:')
region = input()

print("----------------EC2 Details-------------------") 
   
client = boto3.client('ec2',region_name=region)

resp = client.describe_instances()

for reservation in resp['Reservations']:
    for instance in reservation['Instances']:
        print("Instance Image ID: {}  Instance Type: {}  Instance Image Id: {} Instance State: {}"
                .format(instance['InstanceId'],instance['InstanceType'],instance['ImageId'], instance['State']))
                

print("----------------RDS Details-------------------")

rds_client = boto3.client('rds', region_name=region)

# List RDS instances
response = rds_client.describe_db_instances()
for i in response['DBInstances']:
    db_instance_name = i['DBInstanceIdentifier']
    db_type = i['DBInstanceClass']
    db_storage = i['AllocatedStorage']
    db_engine = i['Engine']
    print ("DB-Instance-Name",db_instance_name,db_type,db_storage,db_engine)
    
print("----------------SUBNETS Details-------------------")    
#Subnet List
print('Enter VPC id:')
vpc_id = input()

Vpc_id = vpc_id #"vpc-02b79373e6abf2e8f" #change VPC id
session = boto3.Session(region_name=region)
ec2_resource = session.resource("ec2")
ec2_client = session.client("ec2")
subnet_ids = []
for vpc in ec2_resource.vpcs.all():
    # here you can choose which subnet based on the id
    if vpc.id == Vpc_id:
        for subnet in vpc.subnets.all():
            subnet_ids.append(subnet.id)
# the result of this call has the data you're looking for
print(ec2_client.describe_subnets(SubnetIds=subnet_ids))

print("----------------ELB Details-------------------")
print('Enter ELB name:')
elb_name = input()
elb_name = elb_name 

#loadblc_name = 'bnnbbbn'
client = boto3.client('elbv2',region_name=region)
lbs = client.describe_load_balancers(Names=[elb_name])
print(lbs)

print("----------------EBS Details-------------------")
ec2_client = boto3.client('ec2',region_name=region)

response = ec2_client.describe_instances()

for reservation in response['Reservations']:
    for instance in reservation['Instances']:
        volumes = ec2_client.describe_volumes(
            Filters=[{'Name':'attachment.instance-id','Values':[instance['InstanceId']]}]
        )
        for disk in volumes['Volumes']:
            print("Instance-ID :",instance['InstanceId'],"Disk ID :", disk['VolumeId'], "Volume Type",disk['VolumeType'], "Disk Size",disk['Size'])
            
 
print("----------------Elastic Ip Details-------------------")
client = boto3.client('ec2',region_name=region)
addresses_dict = client.describe_addresses()
for eip_dict in addresses_dict['Addresses']:
    print("IP-Address",eip_dict['PublicIp']) 
              
print("----------------Route 53 Details-------------------")

print('Enter hosted zone id:')
hostedzoneid = input()
hostedzoneid = hostedzoneid


r53client = boto3.client('route53',region_name=region)

response = r53client.list_resource_record_sets(
        HostedZoneId=hostedzoneid,
        StartRecordName='dev',
        StartRecordType='A'
        )

#dict = {}
for resource in response['ResourceRecordSets']:
    print(resource)