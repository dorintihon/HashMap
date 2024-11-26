class HashMap

  attr_accessor :loadfactor, :capacity

  def initialize
    @loadfactor = 0
    @capacity = 8
    @buckets = Array.new(@capacity) { [] }
  end

  def hash(key)
    hash_code = 0
    prime_number = 31

    key.each_char {|char| hash_code = prime_number * hash_code + char.ord}

    hash_code
  end

  def set(key, value)
    bucket = @buckets[get_index(key)]

    bucket.each do |pair|
      if pair[0] == key
        pair[1] = value
        return
      end
    end

    bucket << [key, value]
  end

  def get(key)
    bucket = @buckets[get_index(key)]

    bucket.each do |pair|
      if pair[0] == key
        return pair[1]
      end
    end

    return nil
  end

  def has?(key)
    bucket = @buckets[get_index(key)]

    bucket.each do |pair|
      if pair[0] == key
        return true
      end
    end

    return false
  end

  def remove(key)
    bucket = @buckets[get_index(key)]

    removed_value = nil
    bucket.delete_if do |pair|
      if pair[0] == key
        removed_value = pair[1]
        true
      else
        false
      end
    end

    removed_value ? removed_value : nil
  end

  def length()
    count = 0
    @buckets.each do |bucket|
      count += bucket.length
    end

    return count
  end

  def clear()
    @buckets = Array.new(@capacity) { [] }
  end

  def keys()
    keys = []
    @buckets.each do |bucket|
        bucket.each do |pair|
          keys << pair[0]
        end
    end

    return keys
  end

  def values()
    values = []
    @buckets.each do |bucket|
        bucket.each do |pair|
          values << pair[1]
        end
    end

    return values
  end

  def entries()
    entries = []

    @buckets.each do |bucket|
      bucket.each do |pair|
        entries << pair
      end
    end

    return entries
  end


  def get_index(key)
    index = hash(key).abs % @capacity
    raise IndexError if index.negative? || index >= @buckets.length
    return index

  end

  def get_bucket_size(index)
    bucket = @buckets[index]

    return bucket.length
  end

  def print_bucket(index)
    if index < 0 || index >= @capacity
      puts "Invalid index. Valid indices are from 0 to #{@capacity - 1}."
      return
    end

    bucket = @buckets[index]

    if bucket.empty?
      puts "Bucket at index #{index} is empty."
    else
      puts "Bucket at index #{index} contains:"
      bucket.each { |pair| puts "  Key: #{pair[0]}, Value: #{pair[1]}" }
    end
  end
end
