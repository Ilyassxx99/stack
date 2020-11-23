# readme

This repository has a docker-compose files that let you create and delete EKS cluster with 5 t2.micro nodes autoscaled between 3 and 7. It contains a docker-compose to start spark job on the EKS cluster.
You should have docker and docker-compose installed in your environment


## Prepare the content

To successfully create the cluster, please enter your AWS user (with the right permissions to use AWS resources) Access_key and Secret_key and Region used, in the .env file in 
```
- stack-job/stack-creator
- stack-job/stack-destructor
```
## Running the containers

To create the EKS cluster go to :
```
 stack-job/stack-creator
```
and execute :
```
 docker-compose up
```

### References

- **Choose an open source license**. Github. Available at: https://choosealicense.com/
- **Getting started with writing and formatting on Github**. Github. Available at: https://help.github.com/articles/getting-started-with-writing-and-formatting-on-github/
- **Markdown here cheatsheet**. Markdown Here Wiki. Available at: https://github.com/adam-p/markdown-here/wiki/Markdown-Here-Cheatsheet
- **Markdown quick reference**. Wordpress. Available at: https://en.support.wordpress.com/markdown-quick-reference/
- **readme-template**. Dan Bader. Github. Available at: https://github.com/dbader/readme-template
- Writing READMEs. **Udacity**. Available at: https://classroom.udacity.com/courses/ud777/
