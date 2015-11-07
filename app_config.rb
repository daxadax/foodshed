class Config
  def self.reset_memory_backend
    raise "I only run during development" unless ENV['develop']
    @memory_backend = nil
  end

  def self.database_backend
    return memory_backend if ENV['develop']
    google_drive_backend
  end

  def self.memory_backend
    @memory_backend ||= new.memory_backend
  end

  def self.google_drive_backend
    @google_drive_backend ||= new.google_drive_backend
  end

  def memory_backend
    Gateways::Backends::MemoryBackend.new
  end

  def google_drive_backend
    Gateways::Backends::GoogleDriveBackend.new
  end
end
