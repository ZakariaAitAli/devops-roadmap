# 📊 Nginx Log Analyzer  

## 📌 Overview  
**Nginx Log Analyzer** is a Bash script designed to process and analyze Nginx access logs. It extracts useful insights such as:  
- 🔹 Top 5 IP addresses with the most requests  
- 🔹 Top 5 most requested paths  
- 🔹 Top 5 response status codes  
- 🔹 Top 5 user agents  

This project is part of the **[DevOps Roadmap](https://github.com/ZakariaAitAli/devops-roadmap)** and focuses on enhancing shell scripting and log analysis skills.  

## 📂 Project Structure  
```
Projects/nginx-log-analyser/
│── nginx_log_analyzer.sh  # Shell script to analyze logs
│── nginx-access.log       # Sample Nginx access log
└── README.md              # Project documentation
```

## 🔧 Prerequisites  
Ensure you have the following installed on your system:  
- Linux/macOS (or Windows with WSL)  
- Bash shell  
- Standard Unix tools (`awk`, `sort`, `uniq`, `head`)  

## 🚀 Installation  
1. Navigate to the **DevOps Roadmap** repo:  
   ```bash
   cd devops-roadmap/Projects/nginx-log-analyser
   ```
2. Make the script executable:  
   ```bash
   chmod +x nginx_log_analyzer.sh
   ```

## 📊 Usage  
Run the script by passing an Nginx log file as an argument:  
```bash
./nginx_log_analyzer.sh nginx-access.log
```

### 📌 Example Output  
```
Analyzing log file: nginx-access.log

Top 5 IP addresses with the most requests:
178.128.94.113 - 1087 requests
...

Top 5 most requested paths:
/v1-health - 4560 requests
...

Top 5 response status codes:
200 - 5740 requests
...
```

## 🛠️ How It Works  
The script extracts and sorts log data using:  
- `awk '{print $1}'` → Extracts IP addresses  
- `awk '{print $7}'` → Extracts request paths  
- `awk '{print $9}'` → Extracts response status codes  
- `awk -F'"' '{print $6}'` → Extracts user agents  
- `sort | uniq -c | sort -nr | head -5` → Counts & sorts results  

## 📌 Related Projects  
This project is part of the **[DevOps Roadmap](https://github.com/ZakariaAitAli/devops-roadmap)**. Check out other projects in the repository!  

## License
This project is open-source and available for use and modification.
