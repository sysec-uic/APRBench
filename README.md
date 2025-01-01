# **APRBench: Automatic Program Repair Benchmark**

**APRBench** is an open-source benchmark designed to evaluate and test automatic program repair (APR) systems. It provides a collection of real-world and synthetic vulnerable programs, along with **corresponding inputs that trigger bugs (crashes)** and **inputs that do not**. The project leverages fuzzing tools, such as **AFL (American Fuzzy Lop)**, to generate diverse test cases.

## **Features**
- A collection of vulnerable programs with known issues.
- Inputs classified as:
  - **Crash-triggering inputs** (found in the `crashes` folder).
  - **Safe inputs** (found in the `queue` folder).
- Support for testing repaired programs to verify correctness and robustness.
- Docker-based isolation for reproducibility and ease of use.

## **Getting Started**

### **Prerequisites**
- Install Docker: [Get Docker](https://docs.docker.com/get-docker/)

### **Clone the Repository**
```bash
git clone https://github.com/sysec-uic/APRBench.git
cd APRBench
```

### **Build the Docker Image**
Use the provided Dockerfile to build the Docker image:
```
cd 01-quickstart    # Currently, we only have one test case.
docker build -t aprbench .
```

### **Run the Container**

Run the container:

```
docker run --rm aprbench
```

### **Crash Rate Calculation**
The `test.sh` script outputs:
- Total number of test cases.
- Number of crashes.
- Crash rate (percentage of inputs causing crashes).

Example output:
```
... ...
=====================================
Testing input: out/queue/id:000026,src:000009+000017,op:splice,rep:8,+cov
EADHNNNNN2NNNNNNNNNNNNNNNNNE4 JNNONNNCAD NNMD NNMNNNNNNNONNHNNNNNNNNNNNNNNNENNN2NNNONNHEAD NCAPNo crash for input: out/queue/id:000026,src:000009+000017,op:splice,rep:8,+cov
=====================================
Total Test Cases: 43
Total Crashes: 20
Crash Rate: 46.00%
=====================================
Testing completed.
```

## **Benchmark Structure**
The project directory contains the following components:
```
$ tree . -L 2 
.                  
├── 01-quickstart    
│   ├── Dockerfile
│   └── src
│       ├── Makefile
│       ├── out
│       │   ├── crashes
│       │   ... ...
│       │   └── queue
│       ├── test.sh
│       └── vulnerable.c
├── LICENSE         
├── README.md
```

**Input Classification**

- **Crash Inputs** (`out/crashes/`):
Inputs that caused the program to crash during fuzzing.
- **Queue Inputs** (`out/queue/`):
Inputs that increased program coverage but did not necessarily cause crashes.

## **Contributing**

Contributions to APRBench are welcome! To contribute:

	1.	Fork the repository.
	2.	Create a feature branch (git checkout -b feature-branch).
	3.	Commit your changes (git commit -m 'Add feature').
	4.	Push to your branch (git push origin feature-branch).
	5.	Open a pull request.

## **License**
Licensed under the Creative Commons Attribution 4.0 License.

Please see the respective license files for details.

## **Acknowledgments**
- **AFL (American Fuzzy Lop)**: For its outstanding fuzzing capabilities.
- Community contributions that helped shape this benchmark.

## **Contact**

For questions, issues, or feedback, please contact:

- **Email**: xgwang9@uic.edu
- **GitHub Issues**: [APRBench Issues](https://github.com/sysec-uic/APRBench/issues)