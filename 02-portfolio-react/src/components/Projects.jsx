function Projects() {
  const projects = [
    {
      title: "Dockerized Application with CI/CD Pipeline",
      description: "Build and containerize a web application using Docker, then automate testing and deployment through GitHub Actions."
    },
    {
      title: "Infrastructure as Code with Terraform",
      description: "Provision cloud infrastructure using Terraform to create reproducible and version-controlled environments."
    },
    {
      title: "Kubernetes Deployment with Monitoring",
      description: "Deploy a containerized application on Kubernetes and integrate monitoring and logging."
    }
  ];

  return (
    <section className="projects">
      <h2>Projects</h2>
      {projects.map((project, index) => (
        <div key={index}>
          <h3>{project.title}</h3>
          <p>{project.description}</p>
        </div>
      ))}
    </section>
  );
}

export default Projects;