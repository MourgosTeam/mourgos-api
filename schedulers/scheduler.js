class Scheduler {
    constructor(delay, maxPerPulse) {
        this.stack = [];
        this.delay = delay || 5000;
        this.maxPerPulse = maxPerPulse || 100;
        this.interval = null;
    }

    add(item) {
        this.stack.push(item);
        this.$check();
    }

    $clear() {
        clearInterval(this.interval);
        this.interval = null;
    }

    $set() {
        this.interval = setInterval(this.$execute.bind(this), this.delay);
    }

    $check() {
        if (this.stack.length === 0) {
            this.$clear();
        } else if (this.interval === null) {
            this.$set();
        }
    }

    $execute() {
        for (var ic = 0;
             ic < this.stack.length && ic < this.maxPerPulse;
             ic += 1) {
            try {
                console.log(this.stack);
                const item = this.stack.pop();
                item();
            } catch (err) {
                console.log(err);
            }
        }
        this.$check();
    }
}

module.exports = new Scheduler();