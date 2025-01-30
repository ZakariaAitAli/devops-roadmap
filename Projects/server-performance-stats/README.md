# Server Performance Stats
A bash script to analyse basic server performance stats.  

- Goal of this project is to write a script to analyse server performance stats.

## Requirements
You are required to write a script server-stats.sh that can analyse basic server performance stats. You should be able to run the script on any Linux server and it should give you the following stats:

- Total CPU usage
- Total memory usage (Free vs Used including percentage)
- Total disk usage (Free vs Used including percentage)
- Top 5 processes by CPU usage
- Top 5 processes by memory usage

**Stretch goal:** optionally add more stats such as os version, uptime, load average, logged in users, failed login attempts etc.

## Getting Started

1. **Clone the repository**
    ```
    git clone https://github.com/ZakariaAitAli/devops-roadmap
    cd Projects/server-performance-stats
    ```
2. **Make the script executable**
    ```
    chmod +x server-stats.sh
    ```
3. **Execute the script**  
    ```
    ./server-stats.sh
    ```

This project is part of [roadmap.sh](https://roadmap.sh/projects/server-stats) DevOps projects.
